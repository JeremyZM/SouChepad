//
//  LimitSearchView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-15.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "LimitSearchView.h"
#import "YushuanViewController.h"
#import "CheXingViewController.h"
#import "LiChengViewController.h"
#import "DatePaiViewController.h"
#import "GuoBieViewController.h"
#import "DemandAddCell.h"
#import "UserDemandCell.h"
#import "HttpManager.h"
#import "RequireBrandsModel.h"
#import "RequireInfoModel.h"
#import "ProgressHUD.h"
#import "AddCarController.h"

@interface LimitSearchView() <UICollectionViewDataSource,UICollectionViewDelegate,UIPopoverControllerDelegate,LiChengViewControllerDelegate,YushuanViewControllerDelegate,AddCarControllerDelegate>
{
    UICollectionView *userCarCollection;
    UIButton *yushuanBut;
    UIButton *lichengBut;
    UIButton *dateBut;
    UIButton *guobieBut;
    UIButton *chexingBut;
    
    UIPopoverController *popoVC;
    
    NSArray *reqBrandsArray;
    NSArray *reqDeleteBrandArray;
    RequireInfoModel *reqInfoModel;
    
    NSMutableDictionary *basicRequstDicM;
}

@end

static NSString *demandAddCellid = @"demandAddCellid";
static NSString *userDemandCellid = @"userDemandCellid";
@implementation LimitSearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        [self upUserData];
        
    }
    return self;
}

- (void)upUserData
{
    basicRequstDicM = [NSMutableDictionary dictionary];
    [basicRequstDicM setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
    [HttpManager requestUserRequirementInfo:@{@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:obj];
        reqBrandsArray = [obj objectForKey:@"requireBrands"];
        reqDeleteBrandArray = [NSArray arrayWithArray:[obj objectForKey:@"requireBrandsDelete"]];
        reqInfoModel = [dataDic objectForKey:@"requireInfo"];
        if (reqInfoModel.miles) {
            
            [basicRequstDicM setObject:reqInfoModel.miles forKey:@"miles"];
        }
        if (reqInfoModel.years) {
            
            [basicRequstDicM setObject:reqInfoModel.years forKey:@"years"];
        }
        if (reqInfoModel.carbody) {
            
            [basicRequstDicM setObject:reqInfoModel.carbody forKey:@"carbody"];
        }
        if (reqInfoModel.startBudget) {
            
            [basicRequstDicM setObject:reqInfoModel.startBudget forKey:@"startBudget"];
        }
        if (reqInfoModel.endBudget) {
            
            [basicRequstDicM setObject:reqInfoModel.endBudget forKey:@"endBudget"];
        }

        [self layoutSubviews];
        
    } fail:^(id obj) {
        
    }];

}

- (void)addUI
{
    
    UILabel *yushuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 60, 40)];
    [yushuanLabel setText:@"预算"];
    [yushuanLabel setFont:[UIFont systemFontOfSize:20]];
    [self addSubview:yushuanLabel];
    
    UILabel *lichengLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 40, 60, 40)];
    [lichengLabel setFont:[UIFont systemFontOfSize:20]];
    [lichengLabel setText:@"里程"];
    [self addSubview:lichengLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(620, 40, 100, 40)];
    [dateLabel setText:@"上牌时间"];
    [dateLabel setFont:[UIFont systemFontOfSize:20]];
    [self addSubview:dateLabel];
    
    UILabel *guobieLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 60, 40)];
    [guobieLabel setText:@"国别"];
    [guobieLabel setFont:[UIFont systemFontOfSize:20]];
    [self addSubview:guobieLabel];
    
    UILabel *chexingLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 100, 60, 40)];
    [chexingLabel setFont:[UIFont systemFontOfSize:20]];
    [chexingLabel setText:@"车型"];
    [self addSubview:chexingLabel];
    
    // 预算
    yushuanBut = [self addButtonFrame:CGRectMake(70, 45, 230, 30)];
    [yushuanBut setTag:2000];
    [self addSubview:yushuanBut];
    
    // 里程
    lichengBut = [self addButtonFrame:CGRectMake(370, 45, 230, 30)];
    [self addSubview:lichengBut];
    
    // 上牌时间
    dateBut = [self addButtonFrame:CGRectMake(710, 45, 200, 30)];
    [dateBut setTag:2006];
    [self addSubview:dateBut];
    
    // 国别
    guobieBut = [self addButtonFrame:CGRectMake(70, 105, 230, 30)];
    [self addSubview:guobieBut];
    
    // 车型
    chexingBut = [self addButtonFrame:CGRectMake(370, 105, 230, 30)];
    [self addSubview:chexingBut];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setSectionInset:UIEdgeInsetsMake(0, 20, 20, 20)];
    [layout setItemSize:CGSizeMake(280, 169)];
    
    userCarCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 160, self.bounds.size.width, 490) collectionViewLayout:layout];
    
    // 注册cell
    [userCarCollection registerNib:[UINib nibWithNibName:@"DemandAddCell" bundle:nil] forCellWithReuseIdentifier:demandAddCellid];
    
    [userCarCollection registerNib:[UINib nibWithNibName:@"UserDemandCell" bundle:nil] forCellWithReuseIdentifier:userDemandCellid];
    
    userCarCollection.delegate = self;
    userCarCollection.dataSource = self;
    userCarCollection.backgroundColor = [UIColor clearColor];
    [userCarCollection setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self insertSubview:userCarCollection atIndex:0];
    
    
    UIButton *deleteCarBut = [[UIButton alloc] initWithFrame:CGRectMake(40, 680, 60, 60)];
    [deleteCarBut setBackgroundColor:[UIColor redColor]];
    [self addSubview:deleteCarBut];
    
    self.searchBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBut setFrame:CGRectMake(340, 690, 280, 40)];
    [self.searchBut addTarget:self action:@selector(hidLimitView) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBut setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.searchBut];

}


- (void)showAllPopoView:(UIButton*)button
{
    UIViewController *controller = nil;
    if (button == yushuanBut) {  // 预算
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 1; i <= 100; i++) {
            NSString *str = [NSString stringWithFormat:@"%d万",i];
            [array addObject:str];
        }
        [array insertObject:@"不限" atIndex:0];
        
        NSMutableArray *endArray = [NSMutableArray array];
        for (NSInteger i = 1; i <= 100; i++) {
            NSString *str = [NSString stringWithFormat:@"%d万",i];
            [endArray addObject:str];
        }
        [endArray addObject:@"不限"];
        
        YushuanViewController *YSvc = [[YushuanViewController alloc] init];
        controller = YSvc;
        [YSvc setBeginSelect:[NSString stringWithFormat:@"%@万",reqInfoModel.startBudgetShow]];
        [YSvc setEndSelect:[NSString stringWithFormat:@"%@万",reqInfoModel.endBudgetShow]];
        [YSvc setArray:array];
        [YSvc setEndArray:endArray];
        [YSvc setSeleckBut:yushuanBut];
        [YSvc setDelegate:self];
    }else if (button == dateBut) { // 上牌时间
        NSMutableArray *array = [NSMutableArray array];
        NSDate *date = [NSDate date];
        // NSDateFormatter 专门用来转换日期格式的 类
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置格式
        [formatter setDateFormat:@"yyyy"];
        // NSDateFormatter转换为NSString
        NSString *dateStr = [formatter stringFromDate:date];
        
        
        for (NSInteger i = 2006; i <= [dateStr integerValue]; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [array addObject:str];
        }
        [array insertObject:@"不限" atIndex:0];
        
        NSMutableArray *endArray = [NSMutableArray array];
        for (NSInteger i = 2006; i <= [dateStr integerValue]; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [endArray addObject:str];
        }
        [endArray addObject:@"不限"];
        
        YushuanViewController *dateVC = [[YushuanViewController alloc] init];
        controller = dateVC;
        [dateVC setSeleckBut:dateBut];
        [dateVC setDelegate:self];
        [dateVC setBeginSelect:reqInfoModel.beginYear];
        [dateVC setEndSelect:reqInfoModel.endYear];
        [dateVC setArray:array];
        [dateVC setEndArray:endArray];
        
    } else if (button == chexingBut) {  // 车型
        LiChengViewController *CXvc = [[LiChengViewController alloc] init];
        controller = CXvc;
        [CXvc setSelectButton:chexingBut];
        [CXvc setDelegate:self];
        NSMutableArray *carType = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:KvehicleType]];
        NSDictionary *buxian = @{@"code":@"",@"name":@"不限"};
        [carType insertObject:buxian atIndex:0];
        [CXvc setDataArray:carType];
    }else if (button == lichengBut) {  // 里程
        LiChengViewController *LCvc = [[LiChengViewController alloc] init];
        [LCvc setSelectButton:lichengBut];
        [LCvc setDelegate:self];
        controller = LCvc;
        NSMutableArray *liChengType = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:KmileageSimple]];
        NSDictionary *licheng = @{@"code":@"",@"name":@"不限"};
        [liChengType insertObject:licheng atIndex:0];
        [LCvc setDataArray:liChengType];
        
    }else if (button == guobieBut) {  // 国别
        LiChengViewController *GBvc = [[LiChengViewController alloc] init];
        [GBvc setSelectButton:guobieBut];
        [GBvc setDelegate:self];
        controller = GBvc;
        NSMutableArray *guobieType = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:KcarCountrySimple]];
        NSDictionary *buxian = @{@"code":@"",@"name":@"不限"};
        [guobieType insertObject:buxian atIndex:0];
        [GBvc setDataArray:guobieType];
    }
    
    if (controller) {
        popoVC = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popoVC setDelegate:self];
        CGRect frame = [self convertRect:button.frame fromView:button.superview];
        popoVC.popoverContentSize = CGSizeMake(320, 280);
        [popoVC presentPopoverFromRect:frame inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 预算
    [yushuanBut setTitle:reqInfoModel.purchaseCarBudget?reqInfoModel.purchaseCarBudget:@"不限 - 不限" forState:UIControlStateNormal];

    
    // 里程
    [lichengBut setTitle:reqInfoModel.milesName?reqInfoModel.milesName:@"不限" forState:UIControlStateNormal];
    
    // 上牌时间
    [dateBut setTitle:reqInfoModel.yearsName?reqInfoModel.yearsName:@"不限" forState:UIControlStateNormal];

    
    // 国别
    [guobieBut setTitle:reqInfoModel.countryName?reqInfoModel.countryName:@"不限" forState:UIControlStateNormal];

    // 车型
    [chexingBut setTitle:reqInfoModel.carbodyName?reqInfoModel.carbodyName:@"不限" forState:UIControlStateNormal];
    
    [userCarCollection reloadData];
    
}

- (void)yuShuanViewController:(YushuanViewController *)yushuanVC selectCode:(NSString *)selectCode selectBeginStr:(NSString *)selectBeginStr selectEndStr:(NSString *)selectEndStr
{
    if (yushuanVC.seleckBut == yushuanBut) {
        reqInfoModel.startBudgetShow = selectBeginStr;
        reqInfoModel.endBudgetShow = selectEndStr;
        [yushuanVC.seleckBut setTitle:[NSString stringWithFormat:@"%@ - %@",selectBeginStr,selectEndStr] forState:UIControlStateNormal];
    }else if (yushuanVC.seleckBut == dateBut){
        reqInfoModel.beginYear = selectBeginStr;
        reqInfoModel.endYear = selectEndStr;
        [yushuanVC.seleckBut setTitle:[NSString stringWithFormat:@"%@ - %@",selectBeginStr,selectEndStr] forState:UIControlStateNormal];
    }
}

- (void)liChengViewController:(LiChengViewController *)lichengVC selectBut:(UIButton *)button selectDic:(NSDictionary *)selectDic
{
    if (button == lichengBut) {
        [basicRequstDicM setObject:[selectDic objectForKey:@"code"] forKey:@"miles"];
    }
    if (button == chexingBut) {
        [basicRequstDicM setObject:[selectDic objectForKey:@"code"] forKey:@"carbody"];
    }
    if (button == guobieBut) {
        [basicRequstDicM setObject:[selectDic objectForKey:@"code"] forKey:@"country"];
    }
    [button setTitle:[selectDic objectForKey:@"name"] forState:UIControlStateNormal];

}

// 开始搜索
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return reqBrandsArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.row==0) {
        DemandAddCell *addDemandCell = [collectionView dequeueReusableCellWithReuseIdentifier:demandAddCellid forIndexPath:indexPath];
        cell = addDemandCell;
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        
        //圆角
        cell.layer.cornerRadius = 8.0; // 圆角的弧度
        cell.layer.masksToBounds = YES;
    }else {
        UserDemandCell *userDemandCell = [collectionView dequeueReusableCellWithReuseIdentifier:userDemandCellid forIndexPath:indexPath];
        [userDemandCell.deleteDemandCarBut addTarget:self action:@selector(deleteUserDemandCar:) forControlEvents:UIControlEventTouchUpInside];
        [userDemandCell.deleteDemandCarBut setTag:indexPath.row-1+122];
        cell = userDemandCell;
        RequireBrandsModel *requireBrandM = reqBrandsArray[indexPath.row-1];
        [userDemandCell setRequireBrandM:requireBrandM];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        
        //圆角
        cell.layer.cornerRadius = 8.0; // 圆角的弧度
        cell.layer.masksToBounds = YES;
    }
    
    return cell;
}

- (void)deleteUserDemandCar:(UIButton*)deleteBut
{
    RequireBrandsModel *requireBrandM = reqBrandsArray[deleteBut.tag-122];

    [HttpManager delUserRequirementInfoBrand:@{@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"userRequirementInfoBrandId":requireBrandM._id} Success:^(id obj) {
        
        [self upUserData];
        
    } fail:^(id obj) {
        
    }];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AddCarController *addUserCarBodyVC = [[AddCarController alloc] init];
        [addUserCarBodyVC setDelegate:self];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:addUserCarBodyVC];
        
        [navVC setModalPresentationStyle:UIModalPresentationFormSheet];
        [self.secrVC presentViewController:navVC animated:YES completion:^{
            
        }];
    }
}

- (void)addCarCotrollerDismiss:(AddCarController *)addCarVC
{
    [self upUserData];
}


- (void)hidLimitView
{
    CGRect frme = self.frame;
    frme.origin.y -= frme.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        [self setFrame:frme];
        
        if ([_limitDelegate respondsToSelector:@selector(limitSearch:withDic:)]) {
            [_limitDelegate limitSearch:self withDic:@{}];
        }

    } completion:^(BOOL finished) {
    }];
}

- (UIButton*)addButtonFrame:(CGRect)frame
{
    UIButton *but = [[UIButton alloc] initWithFrame:frame];
    [but setBackgroundColor:[UIColor whiteColor]];
    [but.layer setMasksToBounds:YES];
    [but.layer setCornerRadius:8.0];
    [but setNeedsLayout];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [but.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [but addTarget:self action:@selector(showAllPopoView:) forControlEvents:UIControlEventTouchUpInside];
    return but;
}


@end
