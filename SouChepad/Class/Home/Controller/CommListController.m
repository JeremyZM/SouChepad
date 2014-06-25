//
//  CommListController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-7.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CommListController.h"
#import "HttpManager.h"
#import "UserReservationM.h"
#import "CommunCell.h"
#import "CommunListM.h"
#import "CommHeadView.h"
#import "CommunAddVC.h"
#import "ProgressHUD.h"

@interface CommListController () <UITableViewDataSource,UITableViewDelegate,CommunAddVCDelegate>
{
    NSArray *_dataArray;
    UITableView *_tableView;
}

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
static NSString *CellIdentifier = @"communCell";
@implementation CommListController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self RefreshViewControlEventValueChanged];
    // 1.添加toolbar，添加tableview
    [self addToolbar];
    

}

- (void)addToolbar
{

    UILabel *titel = [[UILabel alloc] init];
    [titel setText:@"沟通记录"];
    [titel setTextColor:[UIColor whiteColor]];
    [titel setFont:KBoldFont18];
    [titel setCenter:self.headBar.center];
    [titel setBounds:CGRectMake(0, 0, 100, 44)];
    [titel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [self.headBar addSubview:titel];
    
    UIButton *addBut = [[UIButton alloc] initWithFrame:CGRectMake(self.headBar.bounds.size.width-180, titel.frame.origin.y, 150, 44)];
    [addBut setImage:[UIImage imageNamed:@"tubiao_35"] forState:UIControlStateNormal];
    [addBut.titleLabel setFont:KBoldFont18];
    [addBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBut setTitle:@"新增沟通记录" forState:UIControlStateNormal];
    [addBut setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [addBut addTarget:self action:@selector(addOneCommun:) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:addBut];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _tableView = tableView;
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [tableView setSeparatorColor:[UIColor hexStringToColor:KSeparatorColor]];
    [self.view insertSubview:tableView atIndex:0];
    // 注册cell
    [tableView registerNib:[UINib nibWithNibName:@"CommunCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.refreshControl setTintColor:[UIColor hexStringToColor:KBaseColo]];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];
}

- (void)addOneCommun:(UIButton*)but
{
    CommunAddVC *commAddVC = [[CommunAddVC alloc] init];
    [commAddVC setUserResM:self.userResM];
    [commAddVC setDelegate:self];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:commAddVC];
    [navVC setModalPresentationStyle:UIModalPresentationFormSheet];

    [self presentViewController:navVC animated:YES completion:^{
        
    }];
}

- (void)RefreshViewControlEventValueChanged
{
        [HttpManager requestCommunicationWithParamDic:@{@"userId":self.userResM.crmUserId} Success:^(id obj) {
            [self.refreshControl endRefreshing];
            _dataArray = [NSArray arrayWithArray:obj];
            [_tableView reloadData];
        } fail:^(id obj) {
            [self.refreshControl endRefreshing];
        }];

}

- (void)communAddVC:(CommunAddVC *)commumVC ReservationDateByUser:(NSDictionary *)dic
{
    [self RefreshViewControlEventValueChanged];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CommunCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CommunListM *communM = _dataArray[indexPath.row];
    [cell.dayLabel setText:communM.day];
    [cell.handlerLabel setText:communM.handler];
    
    CGSize size = [communM.comment boundingRectWithSize:CGSizeMake(460, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:cell.communLabel.font,NSFontAttributeName, nil]  context:nil].size;
    
    [cell.communLabel setText:communM.comment];
    
    if (size.height>60) {
        CGRect cellframe = cell.frame;
        cellframe.size.height = size.height;
        [cell setFrame:cellframe];

    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CommHeadView *head = [[[NSBundle mainBundle] loadNibNamed:@"CommHeadView" owner:self options:nil] objectAtIndex:0];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
