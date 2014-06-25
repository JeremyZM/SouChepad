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
#import "AddUserCarBodyController.h"


@interface LimitSearchView() <UICollectionViewDataSource,UICollectionViewDelegate,UIPopoverControllerDelegate,LiChengViewControllerDelegate,YushuanViewControllerDelegate>
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
    [HttpManager requestUserRequirementInfo:@{@"user":@"18758188560"} Success:^(id obj) {
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:obj];
        reqBrandsArray = [obj objectForKey:@"requireBrands"];
        reqDeleteBrandArray = [NSArray arrayWithArray:[obj objectForKey:@"requireBrandsDelete"]];
        reqInfoModel = [dataDic objectForKey:@"requireInfo"];
        
        [userCarCollection reloadData];
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
    
    yushuanBut = [[UIButton alloc] initWithFrame:CGRectMake(70, 45, 230, 30)];
    
    [yushuanBut setNeedsLayout];
    [yushuanBut addTarget:self action:@selector(showAllPopoView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:yushuanBut];
    
    lichengBut = [[UIButton alloc] initWithFrame:CGRectMake(370, 45, 230, 30)];
    
    [lichengBut setNeedsLayout];
    [lichengBut addTarget:self action:@selector(showAllPopoView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lichengBut];
    
    dateBut = [[UIButton alloc] initWithFrame:CGRectMake(710, 45, 200, 30)];
    [dateBut setNeedsLayout];
    [dateBut addTarget:self action:@selector(showAllPopoView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dateBut];
    
    guobieBut = [[UIButton alloc] initWithFrame:CGRectMake(70, 105, 230, 30)];
    [guobieBut setNeedsLayout];
    [guobieBut addTarget:self action:@selector(showAllPopoView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:guobieBut];
    
    chexingBut = [[UIButton alloc] initWithFrame:CGRectMake(370, 105, 230, 30)];
    [chexingBut setNeedsLayout];
    [chexingBut addTarget:self action:@selector(showAllPopoView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chexingBut];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setSectionInset:UIEdgeInsetsMake(0, 20, 20, 20)];
    [layout setItemSize:CGSizeMake(280, 169)];
    
    userCarCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 160, self.bounds.size.width, 490) collectionViewLayout:layout];
    
    // 注册cell
    [userCarCollection registerNib:[UINib nibWithNibName:@"DemandAddCell" bundle:nil] forCellWithReuseIdentifier:demandAddCellid];
    
    [userCarCollection registerNib:[UINib nibWithNibName:@"UserDemandCell" bundle:nil] forCellWithReuseIdentifier:userDemandCellid];
    
    //        [userCarCollection registerClass:[UserCarCollectionCell class] forCellWithReuseIdentifier:userUserCarCellid];
    
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
    if (button == yushuanBut) {
        YushuanViewController *YSvc = [[YushuanViewController alloc] init];
        controller = YSvc;
        [YSvc setDelegate:self];
    }else if (button == dateBut) {
        controller = [[DatePaiViewController alloc] init];
    } else if (button == chexingBut) {
        LiChengViewController *CXvc = [[LiChengViewController alloc] init];
        controller = CXvc;
        [CXvc setSelectButton:chexingBut];
        [CXvc setDelegate:self];
        [CXvc setDataArray:[NSArray arrayWithContentsOfFile:KvehicleType]];
    }else if (button == lichengBut) {
        LiChengViewController *LCvc = [[LiChengViewController alloc] init];
        [LCvc setSelectButton:lichengBut];
        [LCvc setDelegate:self];
        controller = LCvc;
        [LCvc setDataArray:[NSArray arrayWithContentsOfFile:KmileageSimple]];
    }else if (button == guobieBut) {
        LiChengViewController *GBvc = [[LiChengViewController alloc] init];
        [GBvc setSelectButton:guobieBut];
        [GBvc setDelegate:self];
        controller = GBvc;
        [GBvc setDataArray:[NSArray arrayWithContentsOfFile:KcarCountrySimple]];
    }
    
    if (controller) {
        popoVC = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popoVC setDelegate:self];
        CGRect frame = [self convertRect:button.frame fromView:button.superview];
        popoVC.popoverContentSize = CGSizeMake(320, 340);
        [popoVC presentPopoverFromRect:frame inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    DLog(@"%@---%@----%@---%@----%@---%@",reqInfoModel.priceRange,reqInfoModel.miles,reqInfoModel.years,reqInfoModel.country,reqInfoModel.carbody,reqInfoModel.carUsed);
    
    // 预算
    if ([reqInfoModel.priceRange isEqualToString:@"暂无"]||reqInfoModel.priceRange == nil) {
        [yushuanBut setBackgroundColor:[UIColor whiteColor]];
        [yushuanBut setTitle:@"请选择" forState:UIControlStateNormal];
        [yushuanBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [yushuanBut.layer setMasksToBounds:YES];
        [yushuanBut.layer setCornerRadius:8.0];
    }else {
        [yushuanBut setTitle:reqInfoModel.purchaseCarBudget forState:UIControlStateNormal];
        [yushuanBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [yushuanBut.titleLabel setFont:[UIFont systemFontOfSize:22]];
    }
    
    // 里程
    if ([reqInfoModel.miles isEqualToString:@"暂无"]||reqInfoModel.miles == nil) {
        [lichengBut setBackgroundColor:[UIColor whiteColor]];
        [lichengBut setTitle:@"请选择" forState:UIControlStateNormal];
        [lichengBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [lichengBut.layer setMasksToBounds:YES];
        [lichengBut.layer setCornerRadius:8.0];
    }else {
        [lichengBut setTitle:reqInfoModel.milesName forState:UIControlStateNormal];
        [lichengBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [lichengBut.titleLabel setFont:[UIFont systemFontOfSize:22]];
    }
    
    
    // 上牌时间
    if ([reqInfoModel.years isEqualToString:@"暂无"]||reqInfoModel.years == nil) {
        [dateBut setBackgroundColor:[UIColor whiteColor]];
        [dateBut setTitle:@"请选择" forState:UIControlStateNormal];
        [dateBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [dateBut.layer setMasksToBounds:YES];
        [dateBut.layer setCornerRadius:8.0];

    }else {
        [dateBut setTitle:reqInfoModel.yearsName forState:UIControlStateNormal];
        [dateBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [dateBut.titleLabel setFont:[UIFont systemFontOfSize:22]];
    }
    
    // 国别
    if ([reqInfoModel.country isEqualToString:@"暂无"]||reqInfoModel.country == nil) {
        [guobieBut setBackgroundColor:[UIColor whiteColor]];
        [guobieBut setTitle:@"请选择" forState:UIControlStateNormal];
        [guobieBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [guobieBut.layer setMasksToBounds:YES];
        [guobieBut.layer setCornerRadius:8.0];

    }else {
    
        [guobieBut setTitle:reqInfoModel.countryName forState:UIControlStateNormal];
        [guobieBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [guobieBut.titleLabel setFont:[UIFont systemFontOfSize:22]];
    }
    
    
    // 车型
    if ([reqInfoModel.carbody isEqualToString:@"暂无"]||reqInfoModel.carbody == nil) {
        [chexingBut setBackgroundColor:[UIColor whiteColor]];
        [chexingBut setTitle:@"请选择" forState:UIControlStateNormal];
        [chexingBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [chexingBut.layer setMasksToBounds:YES];
        [chexingBut.layer setCornerRadius:8.0];

    }else {
        [chexingBut setTitle:reqInfoModel.carbodyName forState:UIControlStateNormal];
        [chexingBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [chexingBut.titleLabel setFont:[UIFont systemFontOfSize:22]];
        
    }
    
    [userCarCollection reloadData];
    
}

- (void)yuShuanViewController:(YushuanViewController *)yushuanVC selectCode:(NSString *)selectCode selectStr:(NSString *)selectStr
{
    [yushuanBut setTitle:selectStr forState:UIControlStateNormal];
}

- (void)liChengViewController:(LiChengViewController *)lichengVC selectBut:(UIButton *)button selectDic:(NSDictionary *)selectDic
{

    [button setTitle:[selectDic objectForKey:@"name"] forState:UIControlStateNormal];

}



- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{

    
    
    return YES;
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
    }else {
        UserDemandCell *userDemandCell = [collectionView dequeueReusableCellWithReuseIdentifier:userDemandCellid forIndexPath:indexPath];
        cell = userDemandCell;
    }
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];

    //圆角
    cell.layer.cornerRadius = 8.0; // 圆角的弧度
    cell.layer.masksToBounds = YES;
//    //边框
//    cell.contentView.layer.borderWidth = 0.5;
//    cell.contentView.layer.borderColor = [[UIColor hexStringToColor:KSeparatorColor] CGColor];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AddUserCarBodyController *addUserCarBodyVC = [[AddUserCarBodyController alloc] init];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:addUserCarBodyVC];
        
        [navVC setModalPresentationStyle:UIModalPresentationFormSheet];
        
        [self.secrVC presentViewController:navVC animated:YES completion:^{
            
        }];
//        [self presentViewController:navVC animated:YES completion:^{
//            
//        }];
    }
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



@end
