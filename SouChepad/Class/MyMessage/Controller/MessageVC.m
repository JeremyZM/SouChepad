//
//  MaseeageVC.m
//  Athena
//
//  Created by zt on 14-8-11.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MessageVC.h"
#import "MessageSummaryView.h"
#import "MessageType.h"
#import "MessageDetailView.h"

@interface MessageVC ()<MessageSummaryViewDelegate>{
    MessageSummaryView *msgSummaryView;
    MessageDetailView *msgDetailView;
    
    UISegmentedControl *messageTypeSegment;
}

@end

@implementation MessageVC

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated{
    if (messageTypeSegment) {
        [messageTypeSegment setSelectedSegmentIndex:0];
    }
    if (msgSummaryView) {
        [msgSummaryView cleanMessage];
    }
    [self showMessageSummaryView];
    [self showMessageDetailWihtMessage:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setNavbar];
}

// 设置导航栏
- (void)setNavbar{
    // 返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(30,(CGRectGetHeight(self.headBar.frame)-20)/2, 20, 20)];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(showDockCilck) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"tubiao_36"] forState:UIControlStateNormal];
    
    // 消息类型选择的segment
    messageTypeSegment = [[UISegmentedControl alloc] initWithItems:@[@"个人消息", @"系统消息"]];
    messageTypeSegment.frame = CGRectMake((390-210)/2, (CGRectGetHeight(self.headBar.frame)-35)/2, 210, 35);
    [[UISegmentedControl appearance] setTintColor:[UIColor whiteColor]];
    messageTypeSegment.selectedSegmentIndex = 0;
    [messageTypeSegment addTarget:self action:@selector(messageTypeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.headBar addSubview:messageTypeSegment];
    
    // 左右分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(389, 0, 1, self.view.bounds.size.height)];
    [lineView setBackgroundColor:[UIColor grayColor]];
    [lineView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:lineView];
}

// 显示侧边doc
- (void)showDockCilck{
    [[NSNotificationCenter defaultCenter] postNotificationName:KShowDockNotification object:nil];
}

// 消息类型改变监听
- (void)messageTypeChanged:(UISegmentedControl*)control{
    int messageType = control.selectedSegmentIndex == 0 ? kMyMessage : kSystermMessage;
    [msgSummaryView cleanMessage];
    [msgSummaryView requestMessageWithType:messageType];
}

// 左边消息概要table
- (void)showMessageSummaryView{
    if (msgSummaryView == nil) {
        msgSummaryView = [[MessageSummaryView alloc] initWithFrame:CGRectMake(0, 100, 390, CGRectGetHeight(self.view.frame)-100)];
        msgSummaryView.cellDelegate = self;
        [self.view addSubview:msgSummaryView];
    }
    [msgSummaryView requestMessageWithType:kMyMessage];
}

// 右边消息详情
- (void)showMessageDetailWihtMessage:(id)msg{
    CGFloat originX = CGRectGetMaxX(msgSummaryView.frame)+1;
    CGRect frame = CGRectMake(originX, 100, CGRectGetWidth(self.view.frame)-originX, CGRectGetHeight(self.view.frame)-100);
    if (msgDetailView == nil) {
        msgDetailView = [[MessageDetailView alloc] initWithMessage:msg frame:frame];
        [self.view addSubview:msgDetailView];
        [self.view bringSubviewToFront:msgDetailView];
    }else{
        msgDetailView.frame = frame;
        [msgDetailView setMessageDetail:msg];
    }
}

#pragma mark - MessageSummaryViewDelegate 处理cell点击代理
- (void)messageCellDidSelectedAtIndex:(int)index data:(id)obj{
    //显示消息详情
    [self showMessageDetailWihtMessage:obj];
}
@end
