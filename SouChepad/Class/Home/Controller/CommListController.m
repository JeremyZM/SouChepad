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

@interface CommListController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
    UITableView *_tableView;
}
@end
static NSString *CellIdentifier = @"communCell";
@implementation CommListController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.isNew) {
        [HttpManager requestCommunicationWithParamDic:@{@"userId":self.userResM.crmUserId} Success:^(id obj) {
            _dataArray = [NSArray arrayWithArray:obj];
            [_tableView reloadData];
        } fail:^(id obj) {
            
        }];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    // 1.添加toolbar，添加tableview
    [self addToolbar];
    

}

- (void)addToolbar
{
    
    CGSize size = self.view.bounds.size;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, 100)];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:toolbar];
    UILabel *titel = [[UILabel alloc] init];
    [titel setText:@"沟通记录"];
    [titel setCenter:toolbar.center];
    [titel setBounds:CGRectMake(0, 0, 100, 44)];
    [titel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [toolbar addSubview:titel];
    
    UIButton *addBut = [[UIButton alloc] initWithFrame:CGRectMake(toolbar.bounds.size.width-150, titel.frame.origin.y, 100, 44)];
    [addBut setBackgroundColor:[UIColor redColor]];
    [addBut setTitle:@"新增" forState:UIControlStateNormal];
    [addBut setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [addBut addTarget:self action:@selector(addOneCommun:) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview:addBut];
    

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _tableView = tableView;
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [self.view insertSubview:tableView atIndex:0];
    // 注册cell
    [tableView registerNib:[UINib nibWithNibName:@"CommunCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
}

- (void)addOneCommun:(UIButton*)but
{
    CommunAddVC *commAddVC = [[CommunAddVC alloc] init];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:commAddVC];
    [navVC setModalPresentationStyle:UIModalPresentationFormSheet];
//    [navVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navVC animated:YES completion:^{
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CommunCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        CommunListM *commM = _dataArray[indexPath.row];
    [cell.dayLabel setText:commM.day];
    [cell.communLabel setText:commM.comment];
    [cell.handlerLabel setText:commM.handler];
    
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
    CommunListM *communM = _dataArray[indexPath.row];
//    NSString *commentStr = communM.comment;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [communM.comment boundingRectWithSize:CGSizeMake(480, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;

    if (size.height>60) {
        return size.height;
    }
    return 60;
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
