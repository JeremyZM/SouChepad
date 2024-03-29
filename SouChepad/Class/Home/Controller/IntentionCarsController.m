//
//  IntentionCarsController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "IntentionCarsController.h"
//#import "Cell.h"
#import "CollectCarCell.h"
#import "HttpManager.h"
#import "UserReservationM.h"
#import "CollectHeadView.h"
#import "CarDetailWebView.h"
#import "TradeCarInfoCell.h"
#import "LookOrDriveCarInfoCell.h"
#import "ZBarController.h"
//#import "ZBarSDK.h"
#import "CarDetailWebView.h"
#import "LookOrDriveCarInfoModel.h"
#import "OverDriveCarController.h"
#import "CarOrderVC.h"


@interface IntentionCarsController () <UICollectionViewDataSource,UICollectionViewDelegate,ZBarControllerDelegate,CollectCarCellDelegate,CarOrderVCDelegate>
{
    UICollectionView *_collectionView;
    NSDictionary *intentionCars;    // 所有意向车辆
    NSArray *tradesCars;            // 成交车辆
    NSArray *driveCars;             // 试驾 看车
    NSArray *readyseeCars;          // 预约车辆
    NSArray *collectCars;           // 收藏车辆
    
    UISegmentedControl *_orderSegmented;
}

@property(nonatomic, strong) UIRefreshControl *refreshControl;

@end
static NSString *CollectCarCellid = @"CollectCarCellid";
static NSString *TradeCarInfoCellid = @"TradeCarInfoCellid";
static NSString *LookOrDriveCarInfoCellid = @"LookOrDriveCarInfoCellid";

@implementation IntentionCarsController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick beginLogPageView:@"意向车辆"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshViewControlEventValueChanged) name:@"userIDchange" object:nil];
    [self addCollectionView];
    [self addToolbar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshViewControlEventValueChanged) name:@"update" object:nil];
    
    [self RefreshViewControlEventValueChanged];
}

- (void)addToolbar
{
    UISegmentedControl *orderSegmented = [[UISegmentedControl alloc] initWithItems:@[@"成交车辆",@"预约车辆",@"其他行为"]];
    _orderSegmented = orderSegmented;
    [orderSegmented setTintColor:[UIColor whiteColor]];
    [orderSegmented setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:19] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    [orderSegmented setBounds:CGRectMake(0, 0, 504, 40)];
    [orderSegmented setCenter:self.headBar.center];
    [orderSegmented setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [orderSegmented setSelectedSegmentIndex:0];
    [orderSegmented addTarget:self action:@selector(SegmentedChanged:) forControlEvents:UIControlEventValueChanged];
    [self.headBar addSubview:orderSegmented];
    
    UIButton *scanBut = [[UIButton alloc] initWithFrame:CGRectMake(750, 30, 150, 44)];
    [scanBut addTarget:self action:@selector(scanErWeiMaBut:) forControlEvents:UIControlEventTouchUpInside];
    [scanBut setTitle:@"扫描车辆二维码" forState:UIControlStateNormal];
    [scanBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headBar addSubview:scanBut];
}


- (void)scanErWeiMaBut:(UIButton*)seanBut
{
    [MobClick event:KzbarClick attributes:@{@"sellName":KUserName}];
    ZBarController *zbarVC = [[ZBarController alloc] init];
    [zbarVC setDelegate:self];
    [self presentViewController:zbarVC animated:YES completion:^{
    
    }];
}

- (void)zBarController:(ZBarController *)zbarVC didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *carid = DicValueForKey(info, nil, @"dataString");
    [zbarVC dismissViewControllerAnimated:YES completion:^{
        CarDetailWebView *carDetailVC = [[CarDetailWebView alloc] init];
        [carDetailVC setCarID:carid];
        [self presentViewController:carDetailVC animated:YES completion:^{}];
    }];
//    NSArray *components = [[info objectForKey:@"dataString"] componentsSeparatedByString:@"?"];
//    for (NSString *str in components) {
//        NSArray *comArray = [str componentsSeparatedByString:@"&"];
//        for (NSString *carid in comArray) {
//            if ([carid hasPrefix:@"carId"]) {
//            }
//        }
//    }

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{

    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}


- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setSectionInset:UIEdgeInsetsMake(10, 20, 20, 30)];
    [layout setMinimumLineSpacing:20.0];
    [layout setHeaderReferenceSize:CGSizeMake(self.view.bounds.size.width, 34)];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView setContentInset:UIEdgeInsetsMake(120, 0, 0, 0)];
    
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectCarCell" bundle:nil] forCellWithReuseIdentifier:CollectCarCellid];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"TradeCarInfoCell" bundle:nil] forCellWithReuseIdentifier:TradeCarInfoCellid];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"LookOrDriveCarInfoCell" bundle:nil] forCellWithReuseIdentifier:LookOrDriveCarInfoCellid];
    
    // 注册头部view
    [_collectionView registerClass:[CollectHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionView"];
    
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

    [self.view insertSubview:_collectionView atIndex:0];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.refreshControl setTintColor:[UIColor hexStringToColor:KBaseColo]];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [_collectionView addSubview:self.refreshControl];
    _collectionView.alwaysBounceVertical = YES;
    [self.refreshControl beginRefreshing];
    
}

- (void)RefreshViewControlEventValueChanged
{

        [HttpManager requestUserIntentionWithParamDic:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
            intentionCars = [NSDictionary dictionaryWithDictionary:obj];
            tradesCars = [NSArray arrayWithArray:[intentionCars objectForKey:@"trades"]];
            driveCars = nil;//[NSArray arrayWithArray:[intentionCars objectForKey:@"drive"]];
            readyseeCars = [NSArray arrayWithArray:[intentionCars objectForKey:@"readyseecar"]];
            collectCars = [NSArray arrayWithArray:[intentionCars objectForKey:@"collect"]];
            [_collectionView reloadData];
            [_orderSegmented setTitle:[NSString stringWithFormat:@"成交车辆 %d",tradesCars.count] forSegmentAtIndex:0];
            [_orderSegmented setTitle:[NSString stringWithFormat:@"预约车辆 %d",readyseeCars.count] forSegmentAtIndex:1];
            [_orderSegmented setTitle:[NSString stringWithFormat:@"其他行为 %d",collectCars.count] forSegmentAtIndex:2];
            [self.refreshControl endRefreshing];
        } fail:^(id obj) {
            [self.refreshControl endRefreshing];
        }];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionView" forIndexPath:indexPath];
//    [headView setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    switch (indexPath.section) {
        case 0:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"成交车辆%d",tradesCars.count]];
            break;
        case 1:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"预约车辆%d",readyseeCars.count]];
            break;
        case 2:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"其他行为%d",collectCars.count]];
            break;
        default:
            break;
    }
    
    return headView;

}


- (void)SegmentedChanged:(UISegmentedControl *)Seg
{
    NSIndexPath *index  = [NSIndexPath indexPathForItem:0 inSection:Seg.selectedSegmentIndex];
    
    if ((Seg.selectedSegmentIndex==0&&tradesCars.count)||(Seg.selectedSegmentIndex==1&&readyseeCars.count)||(Seg.selectedSegmentIndex==2&&collectCars.count)) {
        [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

#pragma mark - 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger i = 0;
    switch (section) {
        case 0:
            i = tradesCars.count;
            break;
        case 1:
            i = readyseeCars.count;
            break;
        case 2:
            i = collectCars.count;
            break;
    }
    return i;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(875 , 286);
    if (indexPath.section==1||indexPath.section == 2) {
        size = CGSizeMake(278, 286);
    }
    return size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    if (indexPath.section==0) {
        // 成交车辆
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:TradeCarInfoCellid forIndexPath:indexPath];
        TradeCarInfoCell *tradeCarCell = (TradeCarInfoCell*)cell;
        [tradeCarCell setTradeCarInfoM:tradesCars[indexPath.row]];
        [cell.contentView.layer setBorderColor:[UIColor hexStringToColor:KSeparatorColor].CGColor];
    }else if (indexPath.section == 1){
        // 预约车辆
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectCarCellid forIndexPath:indexPath];
        CollectCarCell *collectCell = (CollectCarCell*)cell;
        collectCell.delegate = self;
        [collectCell setCarModel:readyseeCars[indexPath.row]];
        [cell.contentView.layer setBorderColor:[UIColor hexStringToColor:KSeparatorColor].CGColor];
    }else {
        // 搜藏车辆
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectCarCellid forIndexPath:indexPath];
        CollectCarCell *collectCell = (CollectCarCell*)cell;
        [collectCell setCarModel:collectCars[indexPath.row]];
        [cell.contentView.layer setBorderColor:[UIColor hexStringToColor:KSeparatorColor].CGColor];
        [collectCell hiddenShoukuanXiajiaButton];
    }
    
    [cell.contentView.layer setBorderWidth:1.0];
    [cell.contentView.layer setCornerRadius:2.0];
    
    return cell;
}

#pragma mark - CollectCarCellDelegate
- (void)collectCarCell:(id)cell shoukuanXiajiaButtonClicked:(UIButton *)button{
    CollectCarCell *carCell = cell;
    CarOrderVC *vc = [[CarOrderVC alloc] initWithCarModel:carCell.carModel];
    vc.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{}];
}

#pragma mark - 结束接待
- (void)endDrvie:(UIButton*)but
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    LookOrDriveCarInfoModel *lookOrDriveM = driveCars[but.tag-333];
    NSString *carID = lookOrDriveM.carId;
    [HttpManager lastUserDriveCarByData:@{@"user":userID,@"carId":carID} Success:^(id obj) {
        
        DriveCarLastData *driveDataM = obj;
        OverDriveCarController *overDriveCarVC = [[OverDriveCarController alloc] init];
        UINavigationController *driveNavVC = [[UINavigationController alloc] initWithRootViewController:overDriveCarVC];
        [overDriveCarVC setCarId:carID];
        [overDriveCarVC setDriveCarDataM:driveDataM];
        [driveNavVC setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentViewController:driveNavVC animated:YES completion:^{

        }];
        
    } fail:^(id obj) {
        
    }];
}

#pragma mark - CarOrderVCDelegate 订单完成
- (void)orderDidComplete{
    [self RefreshViewControlEventValueChanged];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarBaseModel *carmodel = nil;
    if (indexPath.section==0) {
        
        carmodel = tradesCars[indexPath.row];
    }else if (indexPath.section == 1){
        carmodel = readyseeCars[indexPath.row];
    }else {
        carmodel = collectCars[indexPath.row];
    }

    CarDetailWebView *car = [[CarDetailWebView alloc] init];
    [car setCarID:carmodel.carId];
    car.carBaseModel = carmodel;
    if ([carmodel.carStatus isEqualToString:@"在售"]) {
        [car setCarStatusType:CarStatusTypeSelling];
    }else if ([carmodel.carStatus isEqualToString:@"预售"]){
        [car setCarStatusType:CarStatusTypePresell];
    }else {
        [car setCarStatusType:CarStatusTypeSellout];
    }
    [self presentViewController:car animated:YES completion:^{
        
    }];
    

}

- (void)dealloc
{
    [MobClick endLogPageView:@"意向车辆"];
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"userIDchange" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"update" object:nil];
}

@end
