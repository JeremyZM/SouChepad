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
//#import "UsertoStore.h"
#import "ProgressHUD.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource,PopoTableViewDelegate,UISearchBarDelegate>
{
    UITableView *table;
    UISearchBar *search;
    UIPopoverController *popoVC;
    UIView *backView;  // 蒙版
    NSInteger ratselectRow; // 等级选中的行
    NSInteger nameSelectRow; // 时间，姓名选中行
    
    NSDictionary *dataDic;   // 所有数据字典
    NSArray *userReserArray;  // 预约客户
    NSArray *usertoStoreArray;  // 所有客户
    
    NSString *_seleckStr;   // 等级筛选字段
    NSString *_namSeleckStr;  // 排序字段
}
@end

static NSString *CellIdentifier = @"cellID";
@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    


    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [HttpManager requestClientWithParamDic:@{@"userName":@"lixuanxu",@"type":@"saler"} Success:^(id obj) {
        if (obj) {
            dataDic = [NSDictionary dictionaryWithDictionary:obj];
            userReserArray = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"userreservation"]];
            usertoStoreArray = [NSArray arrayWithArray:[dataDic objectForKey:@"usertostore"]];
//            [self addTableView];
            [table reloadData];
        }
        
        
    } fail:^(id obj) {
        
    }];
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
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIView *headBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.height, 100)];
    [headBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:headBar];
    
    UIButton *icon = [UIButton buttonWithType:UIButtonTypeCustom];
    [icon setFrame:CGRectMake(10, 30, 120, 50)];
    [icon setBackgroundColor:[UIColor blueColor]];
    [icon addTarget:self action:@selector(iconShowDock) forControlEvents:UIControlEventTouchUpInside];
    [icon setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forState:UIControlStateNormal];
    [headBar addSubview:icon];
    
    search = [[UISearchBar alloc] init];
    [search setBounds:CGRectMake(0, 0, 500, 40)];
    [search setCenter:headBar.center];
    [search setDelegate:self];
    [search setPlaceholder:@"搜索预约号或手机号码"];
    [headBar addSubview:search];
    search.layer.borderWidth=0.5f;
    search.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [search setBarTintColor:[UIColor whiteColor]];
    [search.layer setMasksToBounds:YES];
    [search.layer setCornerRadius:8];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont systemFontOfSize:22]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myKeyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    UIButton *addBut = [[UIButton alloc] initWithFrame:CGRectMake(820, 30, 180, 40)];
    [addBut setTitle:@"添加新客户" forState:UIControlStateNormal];
    [addBut addTarget:self action:@selector(addUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [addBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBut.layer.borderWidth=1.0f;
    addBut.layer.borderColor=[[UIColor whiteColor] CGColor];
    [addBut.layer setMasksToBounds:YES];
    [addBut.layer setCornerRadius:8];
    
    [headBar addSubview:addBut];
    
}

- (void)addTableView
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [table setEstimatedSectionHeaderHeight:40.0];
    [table setEstimatedRowHeight:60.0];
    // 注册cell
    [table registerNib:[UINib nibWithNibName:@"CustomerListCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];

    [self.view addSubview:table];
    
    _seleckStr = @"所有等级";
    _namSeleckStr = @"按姓名排序";
}

- (void)addUserInfo:(UIButton*)button
{
    InfoMainController *infoMVC = [[InfoMainController alloc] init];
    [infoMVC setIsNew:YES];
    [self.navigationController pushViewController:infoMVC animated:YES];
}

#pragma mark - 键盘将要消失
- (void) myKeyboardWillHideHandler:(NSNotification *)notification {
    [self handleBackgroundTap:nil];
}

#pragma mark - 搜索条代理
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //    UIImage *imge = [table screenshot];
    //    imge = [imge applyBlurWithRadius:3.0 tintColor:nil saturationDeltaFactor:1.5 maskImage:nil];
    //
    //    UIImageView *backimage = [[UIImageView alloc] initWithImage:imge];
    //    [table addSubview:backimage];
    //    [backimage setUserInteractionEnabled:YES];
    
    backView = [[UIView alloc] initWithFrame:table.frame];
    //    [backView addSubview:backimage];
    [backView setBackgroundColor:[UIColor blackColor]];
    [backView setAlpha:0.2];
    [self.view addSubview:backView];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [backView addGestureRecognizer:tapRecognizer];
    
}

-(void)handleBackgroundTap:(UITapGestureRecognizer *)sender{
    [search resignFirstResponder];
    [backView removeFromSuperview];
}


#pragma mark - 显示popo
- (void)showpopoview:(UIButton *)button
{
    PopoTableViewController *popo = [[PopoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [popo setPopoTabelDelegate:self];
    popo.sortWayBtn = button;
    if (button.tag == ratBtnTag) {
        popo.selectRow = ratselectRow;
    }else if(button.tag == nameBtnTag){
        popo.selectRow = nameSelectRow;
    }
    popoVC = [[UIPopoverController alloc] initWithContentViewController:popo];
    
    CGRect frame = [self.view convertRect:button.frame fromView:button.superview];
    popoVC.popoverContentSize = CGSizeMake(320, 240);
    [popoVC presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - 筛选修改代理
- (void)PopoTableViewController:(PopoTableViewController *)popoTableVC seleckChanged:(NSString *)seleckStr andseleckRow:(NSInteger)row andselectBtn:(UIButton *)selecBtn
{
    if (selecBtn.tag==nameBtnTag) {
        nameSelectRow = row;
        _namSeleckStr = seleckStr;
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:usertoStoreArray];
        usertoStoreArray = [self changeArray:arrayM orderWithKey:@"day" ascending:YES];
        
    } else if (selecBtn.tag==ratBtnTag) {//按等级筛选
        ratselectRow = row;
        _seleckStr = seleckStr;
        usertoStoreArray = [self siftArray:usertoStoreArray orderWithKey:@"C级"];
    }

    [table reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

//    [selecBtn setTitle:seleckStr forState:UIControlStateNormal];
    [popoVC dismissPopoverAnimated:YES];
}


// 筛选等级
-(NSArray *)siftArray:(NSArray*)dicArray orderWithKey:(NSString *)key{

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"userLevel=%@",key];
    NSArray *array = [dicArray filteredArrayUsingPredicate:pre];

    return array;
}


// 排序
- (NSMutableArray*) changeArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo{
        NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:yesOrNo];
    	NSMutableArray *descriptors=[[NSMutableArray alloc]initWithObjects:&distanceDescriptor count:1];
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
    CGRect rect =CGRectMake(0, 0, tableView.bounds.size.width, 40);
    UIToolbar *oneView = [[UIToolbar alloc] initWithFrame:rect];
    //    UIView *oneView = [[UIView alloc] initWithFrame:rect];
    [oneView setBarTintColor:[UIColor lightGrayColor]];
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    [oneLabel setText:[NSString stringWithFormat:@"今日预约%d",userReserArray.count]];
    [oneView addSubview:oneLabel];
    
    UIToolbar *twoView = [[UIToolbar alloc] initWithFrame:rect];
    [twoView setBarTintColor:[UIColor lightGrayColor]];
    //    UIView *twoView = [[UIView alloc] initWithFrame:rect];
    UILabel *twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    [twoLabel setText:[NSString stringWithFormat:@"全部客户%d",usertoStoreArray.count]];
    [twoView addSubview:twoLabel];
    
    //    ; // 等级筛选按钮
    UIButton *ratbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [ratbut setFrame:CGRectMake(735, 0, 120, 40)];
    [ratbut setTitle:_seleckStr forState:UIControlStateNormal];
    [ratbut addTarget:self action:@selector(showpopoview:) forControlEvents:UIControlEventTouchUpInside];
    [ratbut setTag:ratBtnTag];
    [twoView addSubview:ratbut];
    [ratbut setBackgroundColor:[UIColor redColor]];
    
    //    ; // 时间筛选按钮
    UIButton *nameBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [nameBut setTag:nameBtnTag];
    [nameBut setFrame:CGRectMake(CGRectGetMaxX(ratbut.frame)+20, 0, 120, 40)];
    [nameBut setTitle:_namSeleckStr forState:UIControlStateNormal];
    [nameBut addTarget:self action:@selector(showpopoview:) forControlEvents:UIControlEventTouchUpInside];
    [twoView addSubview:nameBut];
    [nameBut setBackgroundColor:[UIColor redColor]];
    
    
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
        [cell.GradeCustomer setText:userReserM.userLevel];
        [cell.TimeUpdate setTitle:userReserM.day forState:UIControlStateNormal];
        [cell.TimeUpdate setEnabled:YES];
    }else if (indexPath.section == 1){
        
        // 接待过的客户
        UserReservationM *usertoStore = usertoStoreArray[indexPath.row];
        [cell.NameCustomer setText:usertoStore.user];
        [cell.SexCustomer setText:usertoStore.sex];
        [cell.PhoneCustomer setText:usertoStore.phone];
        [cell.GradeCustomer setText:usertoStore.userLevel];
        [cell.TimeUpdate setTitle:usertoStore.day forState:UIControlStateNormal];
        [cell.TimeUpdate setEnabled:NO];
    }
   
    return cell;
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
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 30;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
