//
//  MyMessageController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MyMessageController.h"
#import "HttpManager.h"
#import "MyMessage.h"

@interface MyMessageController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_messageArray;
    UISearchBar *mySearchBar;
    NSMutableArray *filteredContentList;
//    BOOL isSearching;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyMessageController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [HttpManager requestMyMessageWithParamDic:nil Success:^(id obj) {
        _messageArray = [NSMutableArray arrayWithArray:obj];
        [self.tableView reloadData];
    } fail:^(id obj) {
        
    }];
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 340, self.view.bounds.size.height) style:UITableViewStylePlain];
//    [self.tableView setDataSource:self];
//    [self.tableView setDelegate:self];
//    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin];
//    [self.view addSubview:self.tableView];
//
//    
//    mySearchBar = [[UISearchBar alloc] init];
//    [mySearchBar sizeToFit];
//    mySearchBar.delegate = self;
//    self.tableView.tableHeaderView = mySearchBar;

    
    [self addMessageUI];
}

- (void)addMessageUI
{

    CGSize size = [UIScreen mainScreen].bounds.size;
    UIView *headBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 100)];
    [headBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [headBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:headBar];
    
    
    UIButton *icon = [UIButton buttonWithType:UIButtonTypeCustom];
    [icon setFrame:CGRectMake(10, 30, 120, 50)];
    [icon setBackgroundColor:[UIColor blueColor]];
    [icon addTarget:self action:@selector(iconShowDock) forControlEvents:UIControlEventTouchUpInside];
    [icon setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forState:UIControlStateNormal];
    [headBar addSubview:icon];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headBar.frame), 340, self.view.bounds.size.height-100) style:UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];

    [self.view addSubview:self.tableView];
    
    
    
}

- (void)iconShowDock
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KShowDockNotification object:nil];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    mySearchBar = [[UISearchBar alloc] init];
    [mySearchBar sizeToFit];
    mySearchBar.delegate = self;
    return mySearchBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return [_messageArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    MyMessage *message = _messageArray[indexPath.row];
    [cell.textLabel setText:message.title];
    [cell.detailTextLabel setText:message.dateCreate];
    
    return cell;
}

- (void)resetSearch {
    [_messageArray removeAllObjects];
    [_messageArray addObjectsFromArray:filteredContentList];
}

- (void)searchTableList {
    
    
    NSString *searchString = mySearchBar.text;
    
    for (MyMessage *message in _messageArray) {
        NSString *tempStr = message.title;
        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [filteredContentList addObject:tempStr];
        }
    }
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    //Remove all objects first.
    [filteredContentList removeAllObjects];
    if ([searchText length] == 0)
    {
        [self resetSearch];
        //[table reloadData];
        return;
    }
    [self searchTableList];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    DLog(@"%d",_messageArray.count);
    [self.tableView reloadData];
}



@end
