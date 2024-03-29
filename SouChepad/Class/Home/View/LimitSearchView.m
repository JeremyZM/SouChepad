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
#import "RequireDeleteController.h"


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
    UIButton *deleteCarBut;
    
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
//        [self setBackgroundColor:[UIColor whiteColor]];
        [self addUI];
        [self upUserData];
    }
    return self;
}

// 获取用户的过滤条件，关注的品牌车型，所有车辆
- (void)upUserData
{
    basicRequstDicM = [NSMutableDictionary dictionary];
    [basicRequstDicM setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
    [HttpManager requestUserRequirementInfo:@{@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:obj];
        reqBrandsArray = [obj objectForKey:@"requireBrands"];
        reqDeleteBrandArray = [NSArray arrayWithArray:[obj objectForKey:@"requireBrandsDelete"]];
        reqInfoModel = [dataDic objectForKey:@"requireInfo"];
        
//        [self.searchBut setTitle:[NSString stringWithFormat:@"场馆内共%@辆车",[dataDic objectForKey:@"number"]] forState:UIControlStateNormal];
        [self.searchBut setTitle:@"场馆内辆车" forState:UIControlStateNormal];
        [deleteCarBut setTitle:[NSString stringWithFormat:@"%d",reqDeleteBrandArray.count] forState:UIControlStateNormal];
        [self setViewData];
        
    } fail:^(id obj) {
        
    }];

}

- (void)addUI{
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
    guobieLabel.hidden = YES;
    [guobieLabel setFont:[UIFont systemFontOfSize:20]];
    [self addSubview:guobieLabel];
    
    UILabel *chexingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 60, 40)];
    [chexingLabel setFont:[UIFont systemFontOfSize:20]];
    [chexingLabel setText:@"车型"];
    [self addSubview:chexingLabel];
    
    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(670, 685, 220, 50)];
    [tishi setText:@"✺以上需求来源于客户在网站首页的提交，及坐席确认。"];
    [tishi setFont:[UIFont systemFontOfSize:15]];
    [tishi setTextColor:[UIColor lightGrayColor]];
    [tishi setNumberOfLines:0];
    [self addSubview:tishi];
    
    
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
    guobieBut.hidden = YES;
    [self addSubview:guobieBut];
    
    // 车型
    chexingBut = [self addButtonFrame:CGRectMake(70, 105, 230, 30)];
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
    
    
    deleteCarBut = [[UIButton alloc] initWithFrame:CGRectMake(40, 680, 60, 60)];
    [self addSubview:deleteCarBut];
    [deleteCarBut.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [deleteCarBut setBackgroundImage:[UIImage imageNamed:@"xuqiushouji_76"] forState:UIControlStateNormal];
    [deleteCarBut setTitle:@"0" forState:UIControlStateNormal];
    [deleteCarBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [deleteCarBut addTarget:self action:@selector(showRequireDelete) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBut setFrame:CGRectMake(340, 690, 280, 40)];
    [self.searchBut addTarget:self action:@selector(hidLimitView) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBut setTitle:@"场馆内共0辆车" forState:UIControlStateNormal];
    [self.searchBut setBackgroundImage:[UIImage imageNamed:@"dengluanniu1_60"] forState:UIControlStateNormal];
    [self.searchBut setBackgroundImage:[UIImage imageNamed:@"denglu2"] forState:UIControlStateHighlighted];
//    [self.searchBut setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.searchBut];

    
    
}

- (void)showRequireDelete
{
    RequireDeleteController *requireDeleteVC = [[RequireDeleteController alloc] initWithStyle:UITableViewStylePlain];
    [requireDeleteVC setReqDeleteBrandArray:reqDeleteBrandArray];
    UINavigationController *requireDeleteNavVC = [[UINavigationController alloc] initWithRootViewController:requireDeleteVC];
    [requireDeleteNavVC setModalPresentationStyle:UIModalPresentationFormSheet];
    
    [self.secrVC presentViewController:requireDeleteNavVC animated:YES completion:^{
        
    }];
}



- (void)showAllPopoView:(UIButton*)button
{
    
    [MobClick event:KdemandChange attributes:@{@"sellName":KUserName}];
    UIViewController *controller = nil;
    if (button == yushuanBut) {  // 预算
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i <= 100; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [array addObject:str];
        }
        
        NSMutableArray *endArray = [NSMutableArray array];
        for (NSInteger i = 0; i <= 100; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [endArray addObject:str];
        }
//        [endArray addObject:@"不限"];
        
        YushuanViewController *YSvc = [[YushuanViewController alloc] init];
        controller = YSvc;
        [YSvc setBeginSelect:reqInfoModel.startBudgetShow];
        [YSvc setEndSelect:reqInfoModel.endBudgetShow];
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
        
        NSMutableArray *endArray = [NSMutableArray array];
        for (NSInteger i = 2006; i <= [dateStr integerValue]; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [endArray addObject:str];
        }
        
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

- (void)setViewData
{
    
    // 预算
    [yushuanBut setTitle:reqInfoModel.purchaseCarBudget && ![reqInfoModel.priceRange isEqualToString:@"0-100000"]?reqInfoModel.purchaseCarBudget:@"不限 - 不限" forState:UIControlStateNormal];
    
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
        [yushuanVC.seleckBut setTitle:selectCode forState:UIControlStateNormal];
        [reqInfoModel setStartBudget:[NSString stringWithFormat:@"%lld",([selectBeginStr longLongValue]*10000)]];
        [reqInfoModel setEndBudget:[NSString stringWithFormat:@"%lld",([selectEndStr longLongValue]*10000)]];
//        [basicRequstDicM setObject:selectBeginStr forKey:@"startBudget"];
//        [basicRequstDicM setObject:selectEndStr forKey:@"endBudget"];
        
    }else if (yushuanVC.seleckBut == dateBut){
        reqInfoModel.beginYear = selectBeginStr;
        reqInfoModel.endYear = selectEndStr;
        [yushuanVC.seleckBut setTitle:selectCode forState:UIControlStateNormal];
        [reqInfoModel setBeginYear:selectBeginStr];
        [reqInfoModel setEndYear:selectEndStr];
        [reqInfoModel setYears:selectCode];
//        [basicRequstDicM setObject:[NSString stringWithFormat:@"%@-%@",selectBeginStr,selectEndStr] forKey:@"years"];
    }
}

- (void)liChengViewController:(LiChengViewController *)lichengVC selectBut:(UIButton *)button selectDic:(NSDictionary *)selectDic
{
    if (button == lichengBut) {
        [reqInfoModel setMiles:[selectDic objectForKey:@"code"]];
    }
    if (button == chexingBut) {
        [reqInfoModel setCarbody:[selectDic objectForKey:@"code"]];
    }
    if (button == guobieBut) {
        [reqInfoModel setCountry:[selectDic objectForKey:@"code"]];
    }
    [button setTitle:[selectDic objectForKey:@"name"] forState:UIControlStateNormal];

}

// 开始搜索
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (reqInfoModel.miles) {
        
        [basicRequstDicM setObject:reqInfoModel.miles forKey:@"miles"];
    }
    if (reqInfoModel.years) {
        
        [basicRequstDicM setObject:reqInfoModel.years forKey:@"years"];
    }
    if (reqInfoModel.carbody) {
        
        [basicRequstDicM setObject:reqInfoModel.carbody forKey:@"carbody"];
    }
    
//    if (![reqInfoModel.priceRange isEqualToString:@"0-100000"]) {
        if (reqInfoModel.startBudget) {
            
            [basicRequstDicM setObject:reqInfoModel.startBudget forKey:@"startBudget"];
        }
        if (reqInfoModel.endBudget) {
            
            [basicRequstDicM setObject:reqInfoModel.endBudget forKey:@"endBudget"];
        }
//    }
    if (reqInfoModel.country) {
        [basicRequstDicM setObject:reqInfoModel.country forKey:@"country"];
    }


    [HttpManager updateUserRequirementInfo:basicRequstDicM Success:^(id obj) {
        [self upUserData];
        [self.searchBut setTitle:[NSString stringWithFormat:@"场馆内共%@辆车",[obj objectForKey:@"number"]] forState:UIControlStateNormal];
    } fail:^(id obj) {
        
    }];
    
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
        [MobClick event:KdemandChange attributes:@{@"sellName":KUserName}];
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
    }else {
        RequireBrandsModel *requireBrandM = reqBrandsArray[indexPath.row-1];
        if ([_limitDelegate respondsToSelector:@selector(limitSearch:withDic:)]) {
            [_limitDelegate limitSearch:self withDic:@{@"requirementBrandId":requireBrandM._id}];
        }
    }
}

- (void)addCarCotrollerDismiss:(AddCarController *)addCarVC
{
    [self upUserData];
}


- (void)hidLimitView
{
        if ([_limitDelegate respondsToSelector:@selector(limitSearch:withDic:)]) {
            [_limitDelegate limitSearch:self withDic:nil];
        }

    
//    if ([_limitDelegate respondsToSelector:@selector(limitSearch:withDic:)]) {
//        [_limitDelegate limitSearch:self withDic:nil];
//    }
    
//    CGRect frme = self.frame;
//    frme.origin.y -= frme.size.height;
//    [UIView animateWithDuration:0.25 animations:^{
//        [self setFrame:frme];
//    } completion:^(BOOL finished) {
//        if ([_limitDelegate respondsToSelector:@selector(limitSearch:withDic:)]) {
//            [_limitDelegate limitSearch:self withDic:nil];
//        }
//    }];
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
