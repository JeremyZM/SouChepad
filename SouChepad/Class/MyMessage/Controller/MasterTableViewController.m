//
//  MasterTableViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MasterTableViewController.h"
#import "HttpManager.h"
#import "MyMessage.h"
#import "DetailViewController.h"
#import "CoreDateManager.h"
#import "MJRefresh.h"

@interface MasterTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_messageArray;
    UISearchBar *mySearchBar;
    UISegmentedControl *messageTypeSegment;
    NSArray *filteredContentList;
    int messageType;//消息类型
    int page;//请求第一页消息
}
@property (nonatomic, strong) DetailViewController *detailViewController;

@end

@implementation MasterTableViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationset
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor hexStringToColor:KBaseColo]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]  initWithImage:[UIImage imageNamed:@"tubiao_36"] style:UIBarButtonItemStyleBordered target:self action:@selector(iconShowDock)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    // 消息类型选择的segment
    messageTypeSegment = [[UISegmentedControl alloc] initWithItems:@[@"个人消息", @"系统消息"]];
    messageTypeSegment.frame = CGRectMake(70, 0, 210, 35);
    [[UISegmentedControl appearance] setTintColor:[UIColor whiteColor]];
    messageTypeSegment.selectedSegmentIndex = 0;
    [messageTypeSegment addTarget:self action:@selector(messageTypeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:messageTypeSegment];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self navigationset];

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.refreshControl setTintColor:[UIColor hexStringToColor:KBaseColo]];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self.refreshControl beginRefreshing];
    
//    // 1.添加下拉刷新
//    _refreshControl = [MJRefreshHeaderView header];
//    _refreshControl.delegate = self;
//    _refreshControl.scrollView = self.tableView;
//    [_refreshControl setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
//    // 自动进入刷新状态
//    [_refreshControl beginRefreshing];

    messageType = 0;
    [self requestMessageWithType:messageType];
}

//// 开始刷新
//- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
//{
//    [self writeDate];
//}
//
//// 结束刷新
//- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
//{
//
//}

- (void)RefreshViewControlEventValueChanged
{
    [self requestMessageWithType:messageType];
}

// 消息类型改变监听
- (void)messageTypeChanged:(UISegmentedControl*)control{
    page = 0;
    messageType = control.selectedSegmentIndex;
    [_messageArray removeAllObjects];
    [self requestMessageWithType:messageType];
}

// 获取系统消息或者我的消息
- (void)requestMessageWithType:(int)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    // 页
    [dic setObject:[NSNumber numberWithInt:page] forKey:@"index"];
    // 条
    [dic setObject:@"40" forKey:@"pageSize"];
    // 类型（系统信息：system）
    [dic setObject:@"system" forKey:@"readType"];
    //销售ID
    [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forKey:@"userName"];
    
    [HttpManager requestMyMessageWithParamDic:dic messageType:type Success:^(id obj) {
        
        _messageArray = [NSMutableArray arrayWithArray:obj];
        [self.tableView reloadData];
        //默认显示第一条详情
        [self showMessageDetailWithIndex:0];
        [self.refreshControl endRefreshing];
    } fail:^(id obj) {
        [self.refreshControl endRefreshing];
    }];
}

// 显示消息详情
- (void)showMessageDetailWithIndex:(int)msgIndex{
    if (_messageArray.count > 0) {
        MyMessage *message = [_messageArray objectAtIndex:msgIndex];
        self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
        [self.detailViewController setMessageM:message];
    }else{
        [self.detailViewController setMessageM:nil];
    }
}

- (void)iconShowDock
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KShowDockNotification object:nil];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
    [mySearchBar setShowsCancelButton:YES animated:YES];
//    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    return YES;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView  isEqual:self.searchDisplayController.searchResultsTableView]) {
        return filteredContentList.count;
    }
    return _messageArray.count;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    MyMessage *message;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        message = filteredContentList[indexPath.row];
        DLog(@"1112121212121");
    } else {
        DLog(@"------------------");
        message = _messageArray[indexPath.row];
    }
    
    
    [cell.textLabel setText:message.title];
    [cell.detailTextLabel setText:message.dateCreate];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showMessageDetailWithIndex:indexPath.row];
}

@end
