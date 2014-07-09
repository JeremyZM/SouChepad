//
//  SearchVC.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SearchVC.h"
#import "NSString+val.h"
#import "HttpManager.h"
#import "SearchNewUserCell.h"
#import "OtherSellUserCell.h"
#import "CustomerListCell.h"
#import "UserReservationM.h"
#import "InfoMainController.h"

@interface SearchVC () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSDictionary *searchUserDic;
    NSArray *otherSell;
    NSArray *myself;
    NSArray *newUser;
    
    UISearchBar *phoneSearch;
}
@end

static NSString *myselfCell = @"cellID";
static NSString *otherSellCell = @"otherSellUserCell";
static NSString *newUserCell = @"newUserCell";

@implementation SearchVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIView *headBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 100)];
    [headBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [headBar setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    [self.view addSubview:headBar];
    
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    phoneSearch = searchBar;
    [searchBar setFrame:CGRectMake(280, 40, 500, 40)];
//    [searchBar setText:@"13901075113"];
    searchBar.delegate = self;
    [searchBar setPlaceholder:@"搜索客户手机号"];
    [searchBar becomeFirstResponder];
    [searchBar setKeyboardType:UIKeyboardTypeNumberPad];
    [searchBar setBarTintColor:[UIColor clearColor]];
    searchBar.layer.borderWidth=0.5f;
    searchBar.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [searchBar setBarTintColor:[UIColor whiteColor]];
    [searchBar.layer setMasksToBounds:YES];
    [searchBar.layer setCornerRadius:8];
    [headBar addSubview:searchBar];
    [[UITextField appearance] setTintColor:[UIColor redColor]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont systemFontOfSize:22]];
    
    
    UIButton *backBut = [[UIButton alloc] initWithFrame:CGRectMake(20, searchBar.frame.origin.y, 80, 40)];
    [backBut setImage:[UIImage imageNamed:@"tubiao_38"] forState:UIControlStateNormal];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [headBar addSubview:backBut];
    [backBut addTarget:self action:@selector(backk) forControlEvents:UIControlEventTouchUpInside];
    
}

// 开始搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if ([NSString phoneValidate:searchBar.text]) {
        
        searchUserDic = nil;
        myself = nil;
        otherSell = nil;
        newUser = nil;
        
        [HttpManager requestSearchPhoneNumaber:@{@"contact":searchBar.text,@"userName":KUserName} Success:^(id obj) {
            
            searchUserDic = [NSDictionary dictionaryWithDictionary:obj];
//            if (![searchUserDic objectForKey:@"-1"]) {
                otherSell = [NSArray arrayWithArray:[searchUserDic objectForKey:@"1"]];
                myself = [NSArray arrayWithArray:[searchUserDic objectForKey:@"2"]];
//            }else{
                newUser = [NSArray arrayWithArray:[searchUserDic objectForKey:@"-1"]];
//            }
            
            if (_tableView==nil) {
                
                _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];
                [_tableView setDataSource:self];
                [_tableView setDelegate:self];
                [self.view addSubview:_tableView];
                [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
                // 注册cell
                [_tableView registerNib:[UINib nibWithNibName:@"CustomerListCell" bundle:nil] forCellReuseIdentifier:myselfCell];
                [_tableView registerNib:[UINib nibWithNibName:@"SearchNewUserCell" bundle:nil] forCellReuseIdentifier:newUserCell];
                [_tableView registerNib:[UINib nibWithNibName:@"OtherSellUserCell" bundle:nil] forCellReuseIdentifier:otherSellCell];
            }
            [_tableView reloadData];
            
        } fail:^(id obj) {
            
        }];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return searchUserDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)  return newUser.count;
    if (section ==1) return myself.count;
    if (section == 2) return otherSell.count;
    //    if (newUser.count!= 0) {
//        return 1;
//    }else {
//        if (myself.count!=0&&otherSell.count!=0) {
//            if (section==0) {
//                return myself.count;
//            }else if (section == 1){
//                return otherSell.count;
//            }
//        }else if (myself.count!=0&&otherSell.count==0){
//            return myself.count;
//        }else if (myself.count ==0&&otherSell.count != 0){
//            return otherSell.count;
//        }
//    }
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%@",searchUserDic);
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section==0) {
        SearchNewUserCell *newCell = [tableView dequeueReusableCellWithIdentifier:newUserCell];
        cell = newCell;
        UserReservationM *userReserM = [newUser firstObject];
        userReserM.crmUserId = phoneSearch.text;
        [newCell setUserRM:userReserM];
        [newCell.PhoneLabel setText:phoneSearch.text];
        return newCell;
    }else if (indexPath.section==1){
        UserReservationM *userM = myself[indexPath.row];
        
        CustomerListCell *myUserCell = [tableView dequeueReusableCellWithIdentifier:myselfCell];
        [myUserCell setUserReserM:userM];
        cell = myUserCell;
        [myUserCell.NameCustomer setText:userM.user];
        [myUserCell.SexCustomer setText:userM.sex];
        [myUserCell.PhoneCustomer setText:userM.phone];
        [myUserCell.GradeCustomer setText:userM.userLevel];
        [myUserCell.TimeUpdate setTitle:userM.day forState:UIControlStateNormal];
        return myUserCell;
    
    }else if (indexPath.section == 2){
        UserReservationM *userM = otherSell[indexPath.row];
        OtherSellUserCell *otherCell = [tableView dequeueReusableCellWithIdentifier:otherSellCell];
        cell = otherCell;
        [otherCell.phoneNumberLabel setText:userM.phone];
        [otherCell.sellNameLabel setText:[NSString stringWithFormat:@"是%@的客户，请与之协商",userM.user]];
        return otherCell;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InfoMainController *infoMVC = [[InfoMainController alloc] init];
    UserReservationM *userReserM=nil;
    if (indexPath.section==0) {
        SearchNewUserCell *newCell = (SearchNewUserCell*)[tableView cellForRowAtIndexPath:indexPath];
        userReserM = newCell.userRM;
    }else if (indexPath.section ==1){
        CustomerListCell *cell = (CustomerListCell*)[tableView cellForRowAtIndexPath:indexPath];
        userReserM = cell.userReserM;
    }else if (indexPath.section ==2){
        OtherSellUserCell *otherCell = (OtherSellUserCell*)[tableView cellForRowAtIndexPath:indexPath];
        userReserM = otherCell.userReserM;
    }
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [infoMVC setUserInfoM:userReserM];
    [self.navigationController pushViewController:infoMVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)backk
{
    [self.navigationController popViewControllerAnimated:YES];

}




@end
