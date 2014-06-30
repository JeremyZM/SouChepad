//
//  HomeViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "HomeViewController.h"
#import "ToolViewController.h"
#import "InfoMainController.h"
#import "HttpManager.h"
#import "CustomerListCell.h"
#import "ChangeTimePopoVC.h"
#import "PopoTableViewController.h"
#import "UserReservationM.h"
#import "ProgressHUD.h"
#import "SearchVC.h"
#import "NSString+val.h"
#import "ProgressHUD.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource,PopoTableViewDelegate,UIAlertViewDelegate,ChangeTimePopoDelegate>
{
    UITableView *table;
    UIPopoverController *popoVC;
    NSInteger ratselectRow; // 等级选中的行
    NSInteger nameSelectRow; // 时间，姓名选中行
    
    NSDictionary *dataDic;   // 所有数据字典
    NSArray *userReserArray;  // 预约客户
    NSMutableArray *usertoStoreArray;  // 所有客户
    
    NSString *_seleckStr;   // 等级筛选字段
    NSString *_namSeleckStr;  // 排序字段

    NSArray *seleckArray;
    
    UIButton *icon;
    
}

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIPopoverController *timePopoVC;

@end

static NSString *CellIdentifier = @"cellID";
@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self RefreshViewControlEventValueChanged];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addHeadUI];
    [self addTableView];
}

#pragma mark - 添加UI
- (void)addHeadUI
{
    icon = [UIButton buttonWithType:UIButtonTypeCustom];
    [icon setImage:[UIImage imageNamed:@"tubiao_36"] forState:UIControlStateNormal];
    [icon.titleLabel setFont:KBoldFont18];
    icon.titleEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);
    [icon setFrame:CGRectMake(30, 30, 140, 40)];
    [icon addTarget:self action:@selector(iconShowDock) forControlEvents:UIControlEventTouchUpInside];
    [icon setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:KSellName] forState:UIControlStateNormal];
    [self.headBar addSubview:icon];
    
    
    UIButton *searchBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 500, 40)];
    [searchBut setCenter:self.headBar.center];
    [searchBut setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [searchBut setBackgroundImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [searchBut setImage:[UIImage imageNamed:@"tubiao_39"] forState:UIControlStateNormal];
    [searchBut setTitle:@"搜索手机号" forState:UIControlStateNormal];
    [searchBut addTarget:self action:@selector(toSearchUser) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:searchBut];

    
    UIButton *addBut = [[UIButton alloc] initWithFrame:CGRectMake(840, 30, 140, 40)];
    addBut.titleEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);
    [addBut setImage:[UIImage imageNamed:@"tubiao_35"] forState:UIControlStateNormal];
    [addBut setTitle:@"添加新客户" forState:UIControlStateNormal];
    [addBut.titleLabel setFont:KBoldFont18];
    [addBut addTarget:self action:@selector(addUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [addBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.headBar addSubview:addBut];
    
}



- (void)addTableView
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [table setEstimatedSectionHeaderHeight:40.0];
    [table setEstimatedRowHeight:60.0];
    [table setSeparatorColor:[UIColor hexStringToColor:KSeparatorColor]];
    // 设置table 分割线缩进
//    [table setSeparatorInset:UIEdgeInsetsMake(0, 50, 0, 50)];
    // 注册cell
    [table registerNib:[UINib nibWithNibName:@"CustomerListCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];

    [self.view addSubview:table];
    _seleckStr = @"所有等级";
    _namSeleckStr = @"按到店时间";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.refreshControl setTintColor:[UIColor hexStringToColor:KBaseColo]];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [table addSubview:self.refreshControl];
    
    [self.refreshControl beginRefreshing];
}

 // 刷新数据
- (void)RefreshViewControlEventValueChanged
{
    DLog(@"%@",KUserName);
    [HttpManager requestClientWithParamDic:@{@"userName":KUserName,@"type":@"saler"} Success:^(id obj) {
        if (obj) {
            dataDic = [NSDictionary dictionaryWithDictionary:obj];
            userReserArray = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"userreservationNew"]];
            usertoStoreArray = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"usertostore"]];
            [icon setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:KSellName] forState:UIControlStateNormal];
            [table reloadData];
        }
        [self.refreshControl endRefreshing];
        
    } fail:^(id obj) {
        [self.refreshControl endRefreshing];
    }];

}

- (void)addUserInfo:(UIButton*)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加新客户" message:@"尽量填写客户手机号！" delegate:self cancelButtonTitle:@"取消添加" otherButtonTitles:@"添加接待", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *te = [alert textFieldAtIndex:0];
    [te setKeyboardType:UIKeyboardTypeNumberPad];
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [alertView textFieldAtIndex:0];

    if (buttonIndex==0) { // 取消添加
        
    }else if (buttonIndex==1) { // 有手机号添加接待
        if (textField.text.length>0) {
            if ([NSString phoneValidate:textField.text] ) {
                InfoMainController *infoMVC = [[InfoMainController alloc] init];
                UserReservationM *userReserM = [[UserReservationM alloc] init];
                userReserM.crmUserId = textField.text;
                [infoMVC setUserInfoM:userReserM];
                [self.navigationController pushViewController:infoMVC animated:YES];
            }

        }else
        {
            [HttpManager requestUpdtaeUser:@{@"userName":KUserName,@"userTag":@"111"} Success:^(id obj) {
                UserReservationM *newUserM = [[UserReservationM alloc] init];
                [newUserM setCrmUserId:obj];
                InfoMainController *infoMVC = [[InfoMainController alloc] init];
                
                [infoMVC setUserInfoM:newUserM];
                [self.navigationController pushViewController:infoMVC animated:YES];
            } fail:^(id obj) {
                
            }];
            
            
        }
        
    }
    
}


- (void)toSearchUser
{
    SearchVC *searchVC = [[SearchVC alloc] init];

    [self.navigationController pushViewController:searchVC animated:YES];

}


#pragma mark - 显示popo
- (void)showpopoview:(UIButton *)button
{

     NSMutableArray *arrayM = [NSMutableArray array];
    
    PopoTableViewController *popo = [[PopoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [popo setPopoTabelDelegate:self];
    popo.sortWayBtn = button;
    if (button.tag == ratBtnTag) {
//        NSArray *aarray = [NSKeyedUnarchiver unarchiveObjectWithFile:KbuyerStatus];
        NSArray *aarray = [NSArray arrayWithContentsOfFile:KbuyerStatus];

        for (NSDictionary *dataM in aarray) {
            [arrayM addObject:[dataM objectForKey:@"name"]];
        }
        [arrayM insertObject:@"所有等级" atIndex:0];
        [popo setArray:arrayM];
        popo.selectRow = ratselectRow;
    }else if(button.tag == nameBtnTag){

        [arrayM addObject:@"按到店时间"];
        [arrayM addObject:@"按更新时间"];
        [arrayM addObject:@"按姓名排序"];
        [popo setArray:arrayM];
        popo.selectRow = nameSelectRow;
    }
    popoVC = [[UIPopoverController alloc] initWithContentViewController:popo];
    
    CGRect frame = [self.view convertRect:button.frame fromView:button.superview];
    popoVC.popoverContentSize = CGSizeMake(320, arrayM.count*44);
    [popoVC presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - 筛选修改代理
- (void)PopoTableViewController:(PopoTableViewController *)popoTableVC seleckChanged:(NSString *)seleckStr andseleckRow:(NSInteger)row andselectBtn:(UIButton *)selecBtn
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"usertostore"]];
    DLog(@"%@---%d",seleckStr,row);
    if (selecBtn.tag==nameBtnTag) {
        nameSelectRow = row;
        _namSeleckStr = seleckStr;
        if (row==0) {
            
            for (UserReservationM *userM in usertoStoreArray) {
                DLog(@"%@",userM.day);
            }
            usertoStoreArray = [self changeArray:usertoStoreArray orderWithKey:@"day" ascending:NO];
 
            for (UserReservationM *userM in usertoStoreArray) {
                DLog(@"%@",userM.day);
            }
        }else if (row == 1){
            usertoStoreArray = [self changeArray:usertoStoreArray orderWithKey:@"updateDay" ascending:NO];
        }else {
            usertoStoreArray = [self changeArray:usertoStoreArray orderWithKey:@"user" ascending:NO];
        }
        
    } else if (selecBtn.tag==ratBtnTag) {//按等级筛选
        ratselectRow = row;
        _seleckStr = seleckStr;
        if (row==0) {
           usertoStoreArray = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"usertostore"]];;
        }else {
        
            usertoStoreArray = [NSMutableArray arrayWithArray:[self siftArray:arrayM orderWithKey:seleckStr]];
        }
    }
    [table reloadData];
//    [table reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationLeft];
    [popoVC dismissPopoverAnimated:YES];
}


// 筛选等级
-(NSArray *)siftArray:(NSArray*)dicArray orderWithKey:(NSString *)key{

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"userLevel=%@",key];

    return [dicArray filteredArrayUsingPredicate:pre];
}


// 排序
- (NSMutableArray*) changeArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo{
        NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:yesOrNo];
    
    	NSArray *descriptors=[NSArray arrayWithObject:distanceDescriptor];
    	[dicArray sortUsingDescriptors:descriptors];
    return dicArray;

}


- (void)iconShowDock
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KShowDockNotification object:nil];
}

#pragma mark - tableview代理

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect =CGRectMake(0, 0, tableView.bounds.size.width, 60);
    UIView *oneView = [[UIView alloc] initWithFrame:rect];
    [oneView setBackgroundColor:[UIColor colorWithWhite:0.98 alpha:0.95]];
    
    UIButton *oneLabel = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 200, 60)];
    [oneLabel setTitle:[NSString stringWithFormat:@"今明预约 %d",userReserArray.count] forState:UIControlStateNormal];
    [oneLabel.titleLabel setFont:KBoldFont18];
    [oneLabel setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [oneLabel setImage:[UIImage imageNamed:@"tubiao_50"] forState:UIControlStateNormal];
    [oneLabel setImageEdgeInsets:UIEdgeInsetsMake(0, -80, 0, 0)];
    [oneLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -70, 0, 0)];
    [oneView addSubview:oneLabel];
    
    
    UIView *twoView = [[UIView alloc] initWithFrame:rect];
    [twoView setBackgroundColor:[UIColor colorWithWhite:0.98 alpha:0.95]];

    UIButton *twoLabel = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 200, 60)];
    [twoLabel setTitle:[NSString stringWithFormat:@"全部客户 %d",usertoStoreArray.count] forState:UIControlStateNormal];
    [twoLabel.titleLabel setFont:KBoldFont18];
    [twoLabel setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [twoLabel setImage:[UIImage imageNamed:@"tubiao_49"] forState:UIControlStateNormal];
    [twoLabel setImageEdgeInsets:UIEdgeInsetsMake(0, -80, 0, 0)];
    [twoLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -70, 0, 0)];

    [twoView addSubview:twoLabel];
    
//    if (usertoStoreArray.count) {
        //    ; // 等级筛选按钮
        UIButton *ratbut = [UIButton buttonWithType:UIButtonTypeCustom];
        [ratbut setFrame:CGRectMake(715, 20, 120, 30)];
        [ratbut setTitle:_seleckStr forState:UIControlStateNormal];
        [ratbut addTarget:self action:@selector(showpopoview:) forControlEvents:UIControlEventTouchUpInside];
        [ratbut setTag:ratBtnTag];
//        [ratbut setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
        [ratbut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
        [ratbut.layer setBorderWidth:1.0];
        [ratbut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
        [ratbut.layer setCornerRadius:5];
        [twoView addSubview:ratbut];
    
        //    ; // 时间筛选按钮
        UIButton *nameBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [nameBut setTag:nameBtnTag];
        [nameBut setFrame:CGRectMake(CGRectGetMaxX(ratbut.frame)+20, 20, 120, 30)];
        [nameBut setTitle:_namSeleckStr forState:UIControlStateNormal];
        [nameBut addTarget:self action:@selector(showpopoview:) forControlEvents:UIControlEventTouchUpInside];
        [nameBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
        [nameBut.layer setBorderWidth:1.0];
        [nameBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
        [nameBut.layer setCornerRadius:5];
        
        [twoView addSubview:nameBut];
//    }
    
    
    return section?twoView:oneView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return section?usertoStoreArray.count:userReserArray.count;
}

- (CustomerListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.section ==0) {
        
        // 预约客户
        UserReservationM *userReserM = userReserArray[indexPath.row];
        [cell.NameCustomer setText:userReserM.user];
        [cell.SexCustomer setText:userReserM.sex];
        [cell.PhoneCustomer setText:userReserM.phone];
        [cell.GradeCustomer setText:[NSString stringWithFormat:@"来自 %@",userReserM.handler]];
        [cell.TimeUpdate setTitle:userReserM.day forState:UIControlStateNormal];
        
        [cell.TimeUpdate addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.TimeUpdate setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
        [cell.TimeUpdate setTag:(900+indexPath.row)];
        if ([userReserM.day isEqualToString:@"正在接待"]) {
            [cell.TimeUpdate setEnabled:NO];
        }else{
        
            [cell.TimeUpdate setEnabled:YES];
        }
    }else if (indexPath.section == 1){
        
        // 接待过的客户
        UserReservationM *usertoStore = usertoStoreArray[indexPath.row];
        [cell.NameCustomer setText:usertoStore.user];
        [cell.SexCustomer setText:usertoStore.sex];
        [cell.PhoneCustomer setText:usertoStore.phone];
        [cell.GradeCustomer setText:usertoStore.userLevel];
        [cell.TimeUpdate setTitle:[NSString stringWithFormat:@"上次到店 %@",usertoStore.day] forState:UIControlStateNormal];
        [cell.TimeUpdate setEnabled:NO];
        [cell.TimeUpdate setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    }
   
    return cell;
}


#pragma mark - 修改预约日期
- (void)changeTime:(UIButton*)sender {
    ChangeTimePopoVC *changeTime = [[ChangeTimePopoVC alloc] init];
    [changeTime setUserResM:userReserArray[sender.tag-900]];
    [changeTime setDelegate:self];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changeTime];
    self.timePopoVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    CGRect frame = [self.view convertRect:sender.frame fromView:sender.superview];
    self.timePopoVC.popoverContentSize = CGSizeMake(400, 300);
    [self.timePopoVC presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)ChangeTimePopoVC:(ChangeTimePopoVC *)changeTVC changeTimeDic:(NSDictionary *)dateDic
{
    [self.timePopoVC dismissPopoverAnimated:YES];
    [HttpManager requestUpdateReservationDate:dateDic Success:^(id obj) {
        
        if ([obj objectForKey:@"succeedMessage"]) {
            [self viewDidAppear:YES];
        }else
        {
            [ProgressHUD showError:[obj objectForKey:@"errorMessage"]];
        }
    } fail:^(id obj) {
        
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InfoMainController *infoMVC = [[InfoMainController alloc] init];
    if (indexPath.section==0) {
        
        infoMVC.userInfoM =userReserArray[indexPath.row];
    }else if (indexPath.section == 1){
        infoMVC.userInfoM = usertoStoreArray[indexPath.row];
    }
    [self.navigationController pushViewController:infoMVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
