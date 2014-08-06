
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
    
}
@end
static NSString *seconCellID = @"seconCell";
//static NSString * const HeaderIdentifier = @"HeaderIdentifier";
@implementation SearchCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    if (_collectionView == nil) {
        
        [self addHeadToobar];
        [self addCollectionView];
    }

//    [self refreshViewBeginRefreshing:_header];
    
//    [HttpManager queryUserRequirementInfoCarMH:@{@"type":@"yushou",@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
//        
//    } fail:^(id obj) {
//        
//    }];
}



- (void)addHeadToobar
{

    [self.view insertSubview:self.headBar belowSubview:_limitView];
    
    UILabel *gong = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 20, 20)];
    [gong setText:@"共搜索到车辆"];
    [gong setTextColor:[UIColor whiteColor]];
    [gong sizeToFit];
    [self.headBar addSubview:gong];
    
    UILabel *carNumbar = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gong.frame)+5, 35, 20, 20)];
    [carNumbar setTextColor:[UIColor whiteColor]];
    [carNumbar setText:@"28"];
    [carNumbar setFont:[UIFont systemFontOfSize:28]];
    [carNumbar sizeToFit];
    [self.headBar addSubview:carNumbar];
    

    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(carNumbar.frame)+30, 40, 20, 20)];
    [xian setTextColor:[UIColor whiteColor]];
    [xian setText:@"显示预售车"];
    [xian sizeToFit];
    [self.headBar addSubview:xian];
    
    UISwitch *switchPresell = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xian.frame)+10, 40, 40, 30)];

    [self.headBar addSubview:switchPresell];
    
    
    UIButton *limitBut = [[UIButton alloc] initWithFrame:CGRectMake(self.headBar.frame.size.width-100, 20, 80, 80)];
    [limitBut setBackgroundColor:[UIColor yellowColor]];
    [limitBut addTarget:self action:@selector(showLimitView) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:limitBut];
    
}


- (void)showLimitView
{
    [UIView animateWithDuration:0.25 animations:^{
        [_limitView setCenter:self.view.center];
    } completion:^(BOOL finished) {
        
    }];
    
}


#pragma mark --  拖拽视图

//开始拖拽视图

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView

{
    
    contentOffsetY = scrollView.contentOffset.y;
    
}

// 滚动时调用此方法(手指离开屏幕后)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    newContentOffsetY = scrollView.contentOffset.y;
    
    CGRect frame = self.headBar.frame;
    
    if (scrollView.dragging) {  // 拖拽
        
        
        if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f) {  // 向上拖拽
            
            if (self.headBar.frame.origin.y == 0) {
            
                frame.origin.y -= self.headBar.frame.size.height;
            }
            
                  } else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f) {   // 向下拖拽
            
            if (self.headBar.frame.origin.y!=0) {
                frame.origin.y+= self.headBar.frame.size.height;
            }
            
        }
    }
    [UIView animateWithDuration:0.25 animations:^{

        [self.headBar setFrame:frame];
    } completion:^(BOOL finished) {
        
    }];
    
}

// 完成拖拽(滚动停止时调用此方法，手指离开屏幕前)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    oldContentOffsetY = scrollView.contentOffset.y;
}




- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setSectionInset:UIEdgeInsetsMake(20, 20, 20, 20)];
//    [layout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, 100)];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    // 注册cell
    [_collectionView registerClass:[CollectCarCell class] forCellWithReuseIdentifier:seconCellID];
    
    // 注册头部view
//    [_collectionView registerClass:[SearchHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [self.view insertSubview:_collectionView atIndex:0];
    
    // 1.添加下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    _header.scrollView = _collectionView;
    // 自动进入刷新状态
    [_header beginRefreshing];
    
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
    
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) { // 下拉
        _page = 1;
        [HttpManager queryUserRequirementInfoCarZJ:@{@"type":@"yushou",@"index":[NSString stringWithFormat:@"%d",_page],@"pageSize":@"15",@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
            NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:obj];
            if ([dataDic objectForKey:@"currentIndex"]==[dataDic objectForKey:@"totalPage"]) {
                [HttpManager queryUserRequirementInfoCarMH:@{@"type":@"yushou",@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
                    [_header endRefreshing];
                    [_footer endRefreshing];
                    [_footer setHidden:YES];
                } fail:^(id obj) {
                    [_header endRefreshing];
                    [_footer endRefreshing];
                }];
            }else {
                [_header endRefreshing];
                [_footer endRefreshing];
            }
        } fail:^(id obj) {
            [_header endRefreshing];
            [_footer endRefreshing];
        }];
        
    }else { // 上拉加载更多
        _page++;
        [HttpManager queryUserRequirementInfoCarZJ:@{@"type":@"yushou",@"index":[NSString stringWithFormat:@"%d",_page],@"pageSize":@"15",@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
            NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:obj];
            if ([dataDic objectForKey:@"currentIndex"]==[dataDic objectForKey:@"totalPage"]) {
                
                [HttpManager queryUserRequirementInfoCarMH:@{@"type":@"yushou",@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
                    
                    [_footer endRefreshing];
                    [_footer setHidden:YES];
                } fail:^(id obj) {
                    [_header endRefreshing];
                    [_footer endRefreshing];
                }];
            }else {
                [_header endRefreshing];
                [_footer endRefreshing];
            }
        } fail:^(id obj) {
            [_header endRefreshing];
            [_footer endRefreshing];
        }];
    }
    
    

    
}

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"aa");
}




#pragma mark - 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(278, 286);
    return size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:seconCellID forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor orangeColor]];
    return cell;
}



@end
