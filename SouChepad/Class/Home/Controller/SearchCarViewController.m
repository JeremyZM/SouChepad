
//  SearchCarViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SearchCarViewController.h"
#import "LimitSearchView.h"
#import "HttpManager.h"
#import "CollectCarCell.h"
#import "MJRefresh.h"
#import "CarBaseModel.h"
#import "CarDetailWebView.h"
#import "CollectHeadView.h"

@interface SearchCarViewController () <UICollectionViewDataSource,UICollectionViewDelegate,LimitSearchViewDelegate,MJRefreshBaseViewDelegate>
{
    UICollectionView *_collectionView;
//    UIToolbar *_headview;
    
    CGFloat contentOffsetY;
    
    CGFloat oldContentOffsetY;
    
    CGFloat newContentOffsetY;
    
    LimitSearchView *_limitView;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    NSInteger _page;
    
    NSString *totalNumber;
    
    NSDictionary *dataDic;
    
    NSMutableArray *jzCarArrayM;
    NSMutableArray *mhCarArrayM;
    
    NSString *yushouOrzaishou;
    
    NSMutableDictionary *requstDic;
    
}
@end
static NSString *seconCellID = @"seconCell";
//static NSString * const HeaderIdentifier = @"HeaderIdentifier";
@implementation SearchCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    yushouOrzaishou = @"zaishou";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitSearch:withDic:) name:@"userIDchange" object:nil];
    requstDic = [NSMutableDictionary dictionary];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addLimitSearchView];
    
}

- (void)addLimitSearchView
{
    _limitView = [[LimitSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_limitView setSecrVC:self];
    [_limitView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_limitView];
    [_limitView setLimitDelegate:self];
}

- (void)limitSearch:(LimitSearchView *)limitSearchView withDic:(NSDictionary *)searchDic
{
    [requstDic removeAllObjects];
    _page = 1;
    if (_collectionView == nil) {
        
        [self addHeadToobar];
        [self addCollectionView];
    }
    [requstDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
    [requstDic setObject:@"15" forKey:@"pageSize"];
    
    if ([searchDic objectForKey:@"requirementBrandId"]) {
    
        [requstDic setObject:[searchDic objectForKey:@"requirementBrandId"] forKey:@"requirementBrandId"];
        
    }
    [self refreshViewBeginRefreshing:_header];
    
}



- (void)addHeadToobar
{

    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 20, 20)];
    [xian setTextColor:[UIColor whiteColor]];
    [xian setText:@"显示预售车"];
    [xian setFont:[UIFont boldSystemFontOfSize:20]];
    [xian sizeToFit];
    [self.headBar addSubview:xian];
    
    UISwitch *switchPresell = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xian.frame)+10, 40, 55, 30)];
    [switchPresell addTarget:self action:@selector(hideOrShowYushouCar:) forControlEvents:UIControlEventValueChanged];
    [self.headBar addSubview:switchPresell];
    
    UIButton *limitBut = [[UIButton alloc] initWithFrame:CGRectMake(self.headBar.center.x-105, 0, 144, 46)];
    [limitBut setImage:[UIImage imageNamed:@"xuqiushouji_78"] forState:UIControlStateNormal];
    [limitBut addTarget:self action:@selector(showLimitView) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:limitBut];
    
    UILabel *biaoti = [[UILabel alloc] initWithFrame:CGRectMake(self.headBar.center.x-105, 50, 144, 30)];
    [biaoti setText:@"需求车辆"];
    [biaoti setTextAlignment:NSTextAlignmentCenter];
    [biaoti setTextColor:[UIColor whiteColor]];
    [biaoti setFont:[UIFont boldSystemFontOfSize:22]];
    [self.headBar addSubview:biaoti];
    
}

#pragma mark - 显示预售车
- (void)hideOrShowYushouCar:(UISwitch*)swit
{
    if (swit.on) {
        yushouOrzaishou = @"zaishou-yushou";
    }else{
        yushouOrzaishou = @"zaishou";
    }
    [self refreshViewBeginRefreshing:_header];
}


- (void)showLimitView
{
    [UIView animateWithDuration:0.25 animations:^{
        [_limitView setCenter:self.view.center];
    } completion:^(BOOL finished) {
        
    }];
    
}


#pragma mark --  拖拽视图

////开始拖拽视图
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//
//{
//    
//    contentOffsetY = scrollView.contentOffset.y;
//    
//}
//
//// 滚动时调用此方法(手指离开屏幕后)
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//
//{
//    
//    newContentOffsetY = scrollView.contentOffset.y;
//    
//    CGRect frame = self.headBar.frame;
//    
//    if (scrollView.dragging) {  // 拖拽
//        
//        
//        if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f) {  // 向上拖拽
//            
//            if (self.headBar.frame.origin.y == 0) {
//            
//                frame.origin.y -= self.headBar.frame.size.height;
//            }
//            
//                  } else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f) {   // 向下拖拽
//            
//            if (self.headBar.frame.origin.y!=0) {
//                frame.origin.y+= self.headBar.frame.size.height;
//            }
//            
//        }
//    }
//    [UIView animateWithDuration:0.25 animations:^{
//
//        [self.headBar setFrame:frame];
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//}
//
//// 完成拖拽(滚动停止时调用此方法，手指离开屏幕前)
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//
//{
//    oldContentOffsetY = scrollView.contentOffset.y;
//}




- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setSectionInset:UIEdgeInsetsMake(10, 20, 20, 30)];
    [layout setMinimumLineSpacing:20.0];
    [layout setHeaderReferenceSize:CGSizeMake(self.view.bounds.size.width, 34)];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    
    
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectCarCell" bundle:nil] forCellWithReuseIdentifier:seconCellID];
    // 注册头部view
    [_collectionView registerClass:[CollectHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionView"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _collectionView.alwaysBounceVertical = YES;
    
    [self.view insertSubview:_collectionView atIndex:0];
    
    // 1.添加下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    _header.scrollView = _collectionView;
    // 自动进入刷新状态
//    [_header beginRefreshing];
    
    // 2.添加上拉加载
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    _footer.scrollView = _collectionView;
}


#pragma mark - 刷新的代理方法
/**
 *  当控件进入刷新状态的时候就会调用
 *
 *  @param refreshView 哪个控件进入了刷新状态
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{

 [requstDic setObject:yushouOrzaishou forKey:@"type"];
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) { // 下拉
        _page = 1;
        [requstDic setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"index"];
        [_footer setHidden:NO];
        [HttpManager queryUserRequirementInfoCarZJ:requstDic Success:^(id obj) {
            jzCarArrayM = nil;
            mhCarArrayM = nil;
            dataDic = [NSDictionary dictionaryWithDictionary:obj];
            jzCarArrayM = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"jz"]];
            
            if ([[dataDic objectForKey:@"currentIndex"] isEqualToString:[dataDic objectForKey:@"totalPage"]]) {
                
                [_footer setHidden:YES];
                [HttpManager queryUserRequirementInfoCarMH:@{@"type":yushouOrzaishou,@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
                    mhCarArrayM = [NSMutableArray arrayWithArray:obj];
                    [_header endRefreshingWithoutIdle];
                    [_footer endRefreshingWithoutIdle];
                    [_collectionView reloadData];
                } fail:^(id obj) {
                    [_header endRefreshing];
                    [_footer endRefreshing];
                }];
            }else {
                _page++;
                [_collectionView reloadData];
                [_header endRefreshing];
                [_footer endRefreshing];
            }
        } fail:^(id obj) {
            [_header endRefreshing];
            [_footer endRefreshing];
        }];
        
    }else { // 上拉加载更多
        [requstDic setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"index"];
        [HttpManager queryUserRequirementInfoCarZJ:requstDic Success:^(id obj) {
            dataDic = [NSDictionary dictionaryWithDictionary:obj];
            NSArray *moreA = [dataDic objectForKey:@"jz"];
            for (CarBaseModel *carM in moreA) {
                [jzCarArrayM addObject:carM];
            }
            if ([[dataDic objectForKey:@"currentIndex"] isEqualToString:[dataDic objectForKey:@"totalPage"]]) {
                
                [_footer setHidden:YES];
                [HttpManager queryUserRequirementInfoCarMH:@{@"type":yushouOrzaishou,@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
                    mhCarArrayM = [NSMutableArray arrayWithArray:obj];
                    [_footer endRefreshing];
                    [_collectionView reloadData];
                } fail:^(id obj) {
                    [_header endRefreshing];
                    [_footer endRefreshing];
                }];
            }else {
                _page++;
                [_header endRefreshing];
                [_footer endRefreshing];
                [_collectionView reloadData];
            }

        } fail:^(id obj) {
            [_header endRefreshing];
            [_footer endRefreshing];
        }];
    }
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return mhCarArrayM.count?2:1;
}

#pragma mark - 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section?mhCarArrayM.count:jzCarArrayM.count;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(278, 286);
    return size;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionView" forIndexPath:indexPath];
//    [headView setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    switch (indexPath.section) {
        case 0:

            [headView.stateCarLabel setText:[NSString stringWithFormat:@"搜索车辆   %d/%@",jzCarArrayM?jzCarArrayM.count:0,[dataDic objectForKey:@"totalNumber"]?[dataDic objectForKey:@"totalNumber"]:@"0"]];
            break;
        case 1:
            [headView.stateCarLabel setText:[NSString stringWithFormat:@"猜你喜欢  15"]];
            break;
        default:
            break;
    }
    
    return headView;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CollectCarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:seconCellID forIndexPath:indexPath];
    [cell.labelView setHidden:YES];
    [cell.contentView.layer setBorderColor:[UIColor hexStringToColor:KSeparatorColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0];
    [cell.contentView.layer setCornerRadius:2.0];
    if (indexPath.section==0) {
        [cell setCarModel:jzCarArrayM[indexPath.row]];
    }else if (indexPath.section ==1){
        [cell setCarModel:mhCarArrayM[indexPath.row]];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CarDetailWebView *car = [[CarDetailWebView alloc] init];
    CarBaseModel *carmodel= nil;
    if (indexPath.section==0) {
        carmodel  = jzCarArrayM[indexPath.row];

    }else if (indexPath.section ==1){
        carmodel = mhCarArrayM[indexPath.row];
    }
    [car setCarID:carmodel.carId];
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
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"userIDchange" object:nil];
}

@end
