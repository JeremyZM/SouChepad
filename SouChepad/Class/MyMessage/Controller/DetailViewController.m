//
//  DetailViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+LK.h"
#import "MessageDetailView.h"

@interface DetailViewController ()
{
    MessageDetailView *msgView;
}
@end

@implementation DetailViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor hexStringToColor:KBaseColo]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setMessageM:(MyMessage *)messageM
{
    CGRect frame = self.view.bounds;
    frame.origin.y = 66;
    frame.size.height -= 66;
    
    if (msgView == nil) {
        msgView = [[MessageDetailView alloc] initWithMessage:messageM frame:frame];
        msgView.frame = self.view.bounds;
        [self.view addSubview:msgView];
    }else{
        [msgView setMessageDetail:messageM];
    }
}
@end
