//
//  MasterTableViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MasterTableViewController.h"
#import "HttpManager.h"
#import "SystermMessage.h"
#import "DetailViewController.h"
#import "CoreDateManager.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MyMessageCell.h"
#import "MessageType.h"

@interface MasterTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate>{
    NSMutableArray *_messageArray;
    UISearchBar *mySearchBar;
    UISegmentedControl *messageTypeSegment;
    NSArray *filteredContentList;
    int messageType;//消息类型
    int page;//请求第一页消息
    int pageSize;
}
@property (nonatomic, strong) DetailViewController *detailViewController;

@end

@implementation MasterTableViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化数据
    page = 0;
    pageSize = 40;// 每页显示40条
    
    [self navigationset];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.refreshControl setTintColor:[UIColor hexStringToColor:KBaseColo]];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self.refreshControl beginRefreshing];

    messageType = kMyMessage;
    [self requestMessageWithType:messageType];
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

- (void)RefreshViewControlEventValueChanged
{
    [self requestMessageWithType:messageType];
}

// 消息类型改变监听
- (void)messageTypeChanged:(UISegmentedControl*)control{
    page = 0;
    [_messageArray removeAllObjects];
    
    messageType = control.selectedSegmentIndex == 0 ? kMyMessage : kSystermMessage;
    [self requestMessageWithType:messageType];
}

// 获取系统消息或者我的消息
- (void)requestMessageWithType:(int)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    // 页
    [dic setObject:[NSNumber numberWithInt:page] forKey:@"index"];
    // 条
    [dic setObject:@"40" forKey:@"pageSize"];
    //销售ID
    [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forKey:@"userName"];
    
    // 获取系统消息
    if (type == kSystermMessage) {
        // 类型（系统信息：system）
        [dic setObject:@"system" forKey:@"readType"];
        
        [HttpManager requestSystermMessage:dic Success:^(id obj) {
            [self showFirstMessages:obj];
        } fail:^(id obj) {
            [self.refreshControl endRefreshing];
        }];
    }else{
        // 获取个人消息
        [HttpManager requestMyMessageWithParamDic:dic Success:^(id obj) {
            [self showFirstMessages:obj];
        } fail:^(id obj) {
            [self.refreshControl endRefreshing];
        }];
        
    }
}


// 数据请求完后显示消息
- (void)showFirstMessages:(id)obj{
    _messageArray = [NSMutableArray arrayWithArray:obj];
    [self.tableView reloadData];
    //默认显示第一条详情
    [self showMessageDetailWithIndex:0];
    [self.refreshControl endRefreshing];
}

// 显示消息详情
- (void)showMessageDetailWithIndex:(int)msgIndex{
    if (_messageArray.count > 0) {
        SystermMessage *message = [_messageArray objectAtIndex:msgIndex];
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
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyMessageCell";
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[MyMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)_cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageCell *cell = (MyMessageCell*)_cell;
    SystermMessage *msg = [_messageArray objectAtIndex:indexPath.row];
    [cell fillValueWithMessage:msg type:messageType];
    if (indexPath.row == 0) {
        [cell markMessageStatusForData];
    }

    
    // 加载到最后一条的时候自动加载下一页
    if ((indexPath.row == _messageArray.count-1) && (_messageArray.count%pageSize == 0)) {
        page++;
        [self requestMessageWithType:messageType];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showMessageDetailWithIndex:indexPath.row];
}

@end
