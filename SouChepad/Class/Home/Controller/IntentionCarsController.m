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
#import "seconCell.h"
#import "HttpManager.h"
#import "UserReservationM.h"
#import "CollectHeadView.h"
#import "CarDetailWebView.h"

@interface IntentionCarsController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    NSDictionary *intentionCars;    // 所有意向车辆
    NSArray *tradesCars;            // 成交车辆
    NSArray *driveCars;             // 试驾 看车
    NSArray *readyseeCars;          // 预约车辆
    NSArray *collectCars;           // 收藏车辆
    
    UISegmentedControl *_orderSegmented;
}
@end
static NSString *CollectCarCellid = @"CollectCarCellid";
static NSString *seconCellID = @"seconCell";

@implementation IntentionCarsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    if (self.isNew) {
        
    }else {
        [HttpManager requestUserIntentionWithParamDic:@{@"userId":self.userReserM.crmUserId} Success:^(id obj) {
            intentionCars = [NSDictionary dictionaryWithDictionary:obj];
            tradesCars = [NSArray arrayWithArray:[intentionCars objectForKey:@"trades"]];
            driveCars = [NSArray arrayWithArray:[intentionCars objectForKey:@"drive"]];
            readyseeCars = [NSArray arrayWithArray:[intentionCars objectForKey:@"readyseecar"]];
            collectCars = [NSArray arrayWithArray:[intentionCars objectForKey:@"collect"]];
            [_collectionView reloadData];
            [_orderSegmented setTitle:[NSString stringWithFormat:@"已购车辆 %d",tradesCars.count] forSegmentAtIndex:0];
            [_orderSegmented setTitle:[NSString stringWithFormat:@"试驾看车 %d",driveCars.count] forSegmentAtIndex:1];
            [_orderSegmented setTitle:[NSString stringWithFormat:@"预约车辆 %d",readyseeCars.count] forSegmentAtIndex:2];
            [_orderSegmented setTitle:[NSString stringWithFormat:@"收藏车辆 %d",collectCars.count] forSegmentAtIndex:3];
        } fail:^(id obj) {
            
        }];
    }

    
    [self addCollectionView];
    [self addToolbar];
}

- (void)addToolbar
{
    UISegmentedControl *orderSegmented = [[UISegmentedControl alloc] initWithItems:@[@"已购车辆",@"试驾看车",@"预约车辆",@"收藏车辆"]];
    _orderSegmented = orderSegmented;
    [orderSegmented setTintColor:[UIColor whiteColor]];
    [orderSegmented setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:19] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    [orderSegmented setBounds:CGRectMake(0, 0, 504, 40)];
    [orderSegmented setCenter:self.headBar.center];
    [orderSegmented setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [orderSegmented setSelectedSegmentIndex:0];
    //    [orderSegmented setTintColor:[UIColor lightGrayColor]];
    [orderSegmented addTarget:self action:@selector(SegmentedChanged:) forControlEvents:UIControlEventValueChanged];
    [self.headBar addSubview:orderSegmented];
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
    [_collectionView registerClass:[seconCell class] forCellWithReuseIdentifier:seconCellID];
    
    
    // 注册头部view
    [_collectionView registerClass:[CollectHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionView"];
    
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

    [self.view insertSubview:_collectionView atIndex:0];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"成交车辆%d",tradesCars.count]];
            break;
        case 1:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"试驾看车%d",driveCars.count]];
            break;
        case 2:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"预约车辆%d",readyseeCars.count]];
            break;
        case 3:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"收藏车辆%d",collectCars.count]];
            break;
        default:
            break;
    }
    
    return headView;

}


- (void)SegmentedChanged:(UISegmentedControl *)Seg
{
    NSIndexPath *index  = [NSIndexPath indexPathForItem:0 inSection:Seg.selectedSegmentIndex];
    
   
    [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
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
            i = driveCars.count;
            break;
        case 2:
            i = readyseeCars.count;
            break;
        case 3:
            i = collectCars.count;
            break;
    }
    return i;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGSize size = CGSizeMake(self.view.frame.size.width-40 , 300);
//    if (indexPath.section==1) {
      CGSize  size = CGSizeMake(278, 286);
//    }
    return size;
}


- (UITableViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectCarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectCarCellid forIndexPath:indexPath];
    [cell.contentView.layer setBorderWidth:1.0];
    [cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.contentView.layer setCornerRadius:2.0];
    [cell.labelView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];

//    [[cell.contentView layer] setShadowOffset:CGSizeMake(1, 1)];
//    [[cell.contentView layer] setShadowRadius:5];
//    [[cell.contentView layer] setShadowOpacity:1];
//    [[cell.contentView layer] setShadowColor:[UIColor blackColor].CGColor];
    
        if (indexPath.section==0) {
        
        [cell setCarModel:tradesCars[indexPath.row]];
    }else if (indexPath.section == 1){
        [cell setCarModel:driveCars[indexPath.row]];
    }else if (indexPath.section == 2){
        [cell setCarModel:readyseeCars[indexPath.row]];
    }else {
        [cell setCarModel:collectCars[indexPath.row]];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarBaseModel *carmodel = nil;
    if (indexPath.section==0) {
        
        carmodel = tradesCars[indexPath.row];
    }else if (indexPath.section == 1){
        carmodel = driveCars[indexPath.row];
    }else if (indexPath.section == 2){
        carmodel = readyseeCars[indexPath.row];
    }else {
        carmodel = collectCars[indexPath.row];
    }

    CarDetailWebView *car = [[CarDetailWebView alloc] init];
    [car setCarID:carmodel.carId];
    [self presentViewController:car animated:YES completion:^{
        
    }];
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
