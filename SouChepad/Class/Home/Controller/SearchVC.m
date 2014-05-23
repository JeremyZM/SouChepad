//
//  SearchVC.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC () <UISearchBarDelegate>
{
    UITableView *tableView;
}
@end

@implementation SearchVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [searchBar setBounds:CGRectMake(0, 0, 500, 40)];
    [searchBar setCenter:self.headBar.center];
    searchBar.delegate = self;
    [searchBar setPlaceholder:@"搜索消息"];
    [searchBar becomeFirstResponder];
    [searchBar setKeyboardType:UIKeyboardTypeNumberPad];
    [searchBar setBarTintColor:[UIColor clearColor]];
    searchBar.layer.borderWidth=0.5f;
    searchBar.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [searchBar setBarTintColor:[UIColor whiteColor]];
    [searchBar.layer setMasksToBounds:YES];
    [searchBar.layer setCornerRadius:8];
    [self.headBar addSubview:searchBar];
    
    
    UIButton *backBut = [[UIButton alloc] initWithFrame:CGRectMake(10, searchBar.frame.origin.y, 100, 40)];
    [backBut setBackgroundColor:[UIColor yellowColor]];
    [self.headBar addSubview:backBut];
    [backBut addTarget:self action:@selector(backk) forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
//    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)backk
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
