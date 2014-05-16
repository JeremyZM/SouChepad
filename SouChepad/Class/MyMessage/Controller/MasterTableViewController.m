//
//  MasterTableViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MasterTableViewController.h"
#import "HttpManager.h"
#import "MyMessageM.h"
#import "DetailViewController.h"

@interface MasterTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSArray *_messageArray;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplay;
    NSArray *filteredContentList;
}
@property (nonatomic, strong) DetailViewController *detailViewController;
@end

@implementation MasterTableViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [HttpManager requestMyMessageWithParamDic:nil Success:^(id obj) {
        _messageArray = [NSArray arrayWithArray:obj];
        [self.tableView reloadData];
    } fail:^(id obj) {
        
    }];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] style:UIBarButtonItemStyleBordered target:self action:@selector(iconShowDock)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleBordered target:self action:@selector(iconShowDock)];
    
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
    MyMessageM *message;
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
    MyMessageM *message;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        message = filteredContentList[indexPath.row];
    } else {
        message = _messageArray[indexPath.row];
    }
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self.detailViewController setMessageM:message];
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


@end
