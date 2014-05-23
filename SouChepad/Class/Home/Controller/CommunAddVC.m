//
//  CommunAddVC.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CommunAddVC.h"

@interface CommunAddVC ()

@end

@implementation CommunAddVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"新增沟通记录"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelRecord:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveRecord:)];
    
    
    UILabel *shij = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+44, 60, 44)];
    [shij setText:@"时间"];
    [shij setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:shij];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shij.frame)+30, 20+44, 300, 44)];
//    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter   alloc] init];
    [formatter  setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    [timeLabel setText:[formatter stringFromDate:[NSDate date]]];
    [timeLabel setTextColor:[UIColor redColor]];
    [self.view addSubview:timeLabel];
    
    UILabel *neir = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(shij.frame), 60, 44)];
    [neir setTextAlignment:NSTextAlignmentCenter];
    [neir setText:@"内容"];
    [self.view addSubview:neir];
    
    UITextView *content = [[UITextView alloc] initWithFrame:CGRectMake(timeLabel.frame.origin.x, neir.frame.origin.y, 300, 280)];
//    [content setDataDetectorTypes:UIDataDetectorTypeAll];
//    [content setEditable:NO];
//    [content setAttributedText:[[NSAttributedString alloc]initWithString:@"My phone number is +8602980000000.\r\n"
//                                "My personal web site www.xxxxxx.com.\r\n"
//                                "My E-mail address is XXXXX@gmail.com.\r\n""I was born in 1900-01-01."]];

    [content.layer setCornerRadius:10];
    [content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [content setFont:[UIFont systemFontOfSize:17]];
    [content.layer setBorderWidth:1.0];
    [self.view addSubview:content];
}

#pragma mark - 取消记录
- (void)cancelRecord:(UIBarButtonItem*)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 保存记录
- (void)saveRecord:(UIBarButtonItem *)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
