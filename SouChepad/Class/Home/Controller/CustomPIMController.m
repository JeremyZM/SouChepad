//
//  CustomPIMController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CustomPIMController.h"
//#import "FZInfoView.h"
#import "JBInfoView.h"
#import "HttpManager.h"
#import "FuZhuInfoView.h"
#import "UserReservationM.h"

@interface CustomPIMController ()
{
    UIScrollView *_scrollView;
//    UIView *_fuzhuTable;
    JBInfoView *_jbInfoView;
    
    FuZhuInfoView *_fuzhuView;
}
@end

@implementation CustomPIMController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 0.    UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _scrollView = scrollView;

    [self.view addSubview:scrollView];
    
    // 1.添加toolbar
    [self addToolbar];
    if (self.isNew) {
        // 添加基本信息view
        [self addBasicInfoView];
    }else{
    
        [HttpManager requestUserInfoWithParamDic:@{@"userId":self.userInfoM.crmUserId} Success:^(id obj) {
            // 添加基本信息view
            [self addBasicInfoView];
            
        } fail:^(id obj) {
            
        }];
    }

}

- (void)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:toolbar];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"基本信息",@"辅助信息",@"卖车信息"]];
    [seg setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [seg setCenter:toolbar.center];
    [seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    [seg setBounds:CGRectMake(0, 0, 330, 40)];
    [seg setSelectedSegmentIndex:0];
    [toolbar addSubview:seg];
}

- (void)segChanged:(UISegmentedControl*)seg
{
    switch (seg.selectedSegmentIndex) {
        case 0:
            // 添加基本信息view
            [self addBasicInfoView];

            break;
        case 1:
            // 3.添加辅助信息view
            [self addauxiliaryInfoView];
            
            break;
        default:
            break;
    }
}



- (void)addBasicInfoView
{
    if (_fuzhuView) {
        [_fuzhuView removeFromSuperview];
    }
    if (_jbInfoView == nil) {
        
        JBInfoView *jbInfo = [[JBInfoView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 800)];
        [jbInfo setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _jbInfoView = jbInfo;
        [_scrollView setContentSize:CGSizeMake(0, jbInfo.bounds.size.height+100)];
    }
    [_scrollView addSubview:_jbInfoView];
}

- (void)addauxiliaryInfoView
{
    if (_jbInfoView) {
        [_jbInfoView removeFromSuperview];
    }
//    if (_fuzhuTable==nil) {
//        FZInfoView *fztableView = [[FZInfoView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 800)];
//        [fztableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//        _fuzhuTable = fztableView;
//        [_scrollView setContentSize:CGSizeMake(0, fztableView.bounds.size.height)];
//    }
//    [_scrollView addSubview:_fuzhuTable];

    if (_fuzhuView==nil) {
        FuZhuInfoView *fztableView = [[FuZhuInfoView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 800)];
        [fztableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _fuzhuView = fztableView;
        [_scrollView setContentSize:CGSizeMake(0, fztableView.bounds.size.height+100)];
    }
    [_scrollView addSubview:_fuzhuView];


}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
