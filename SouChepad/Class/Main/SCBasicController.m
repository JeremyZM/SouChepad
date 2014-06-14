//
//  SCBasicController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-19.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SCBasicController.h"

@interface SCBasicController ()

@end

@implementation SCBasicController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
//    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    CGSize size = [UIScreen mainScreen].bounds.size;
    
    _headBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, 100)];
    [_headBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_headBar setBarTintColor:[UIColor hexStringToColor:KBaseColo]];
//    [_headBar setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    [self.view addSubview:_headBar];
    
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
