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
    NSArray *_messageArray;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplay;
    NSArray *filteredContentList;
    
    CoreDateManager *coreManager;
     MJRefreshHeaderView *_refreshControl; // 下拉刷新
}
@property (nonatomic, strong) DetailViewController *detailViewController;

@end

@implementation MasterTableViewController


- (void)navigationset
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] style:UIBarButtonItemStyleBordered target:self action:@selector(iconShowDock)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleBordered target:self action:@selector(iconShowDock)];
}

- (void)addsearchDisplay
{
    mySearchBar = [[UISearchBar alloc] init];
    [mySearchBar sizeToFit];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索消息"];
    //    [self.navigationItem setTitleView:mySearchBar];
    [self.tableView setTableHeaderView:mySearchBar];
    
    searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    searchDisplay.delegate = self;
    searchDisplay.searchResultsDataSource = self;
    searchDisplay.searchResultsDelegate = self;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self navigationset];
    
    [self addsearchDisplay];
    
    coreManager = [[CoreDateManager alloc]init];
    
    // 1.添加下拉刷新
    _refreshControl = [MJRefreshHeaderView header];
    _refreshControl.delegate = self;
    _refreshControl.scrollView = self.tableView;
    [_refreshControl setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    // 自动进入刷新状态
    [_refreshControl beginRefreshing];

    
}

// 开始刷新
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self writeDate];
}

// 结束刷新
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{

}


-(void)writeDate
{
    [HttpManager requestMyMessageWithParamDic:nil Success:^(id obj) {
        [_refreshControl endRefreshing];
        _messageArray = [NSArray arrayWithArray:obj];
        [coreManager deleteData];
        //把数据写到数据库
        [coreManager insertCoreData:_messageArray];
        
        [self.tableView reloadData];
    } fail:^(id obj) {
        _messageArray = [coreManager selectData:100 andOffset:0];
        [self.tableView reloadData];
        [_refreshControl endRefreshing];
    }];
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessage *message;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        message = filteredContentList[indexPath.row];
    } else {
        message = _messageArray[indexPath.row];
    }
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self.detailViewController setMessageM:message];
//    [self.detailViewController.view setNeedsLayout];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchString:(NSString *)searchString {
    //根据用户的输入的关键字searchString，处理出搜索结果（可以是本地搜索，可以是从服务器请求过来的数据）到数组
    filteredContentList = [self siftArray:_messageArray orderWithKey:searchString];
    
    return YES; //返回yes，重新加载tableView对象
}

// 模糊搜索
-(NSArray *)siftArray:(NSArray*)dicArray orderWithKey:(NSString *)key{
    
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"title contains[cd] %@", key];
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"title=%@",key];
    NSArray *array = [dicArray filteredArrayUsingPredicate:predicateString];
    
    return array;
}


- (void)dealloc
{
    [_refreshControl free];
}

@end
