//
//  ChangeTimePopoVC.m
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "ChangeTimePopoVC.h"

@interface ChangeTimePopoVC ()

@end

@implementation ChangeTimePopoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView* popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    popoverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:popoverView];
    //创建 UIDatePicker 控件
    self.datepicker = [[UIDatePicker alloc] initWithFrame:popoverView.bounds];

//    UIDatePicker *datepicker = [[UIDatePicker alloc] init]; // 不用设置大小

//    [datepicker setBackgroundColor:[UIColor whiteColor]];
//    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
//    [formate setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
//    [formate setDateFormat:@"yyyy-MM-dd HH"];

//    NSDate *enddate = [formate dateFromString:self.tickm.endDate];
    [self.datepicker setMinimumDate:[NSDate date]];
//    [datepicker setMaximumDate:enddate];
    
    [self.datepicker setDatePickerMode:UIDatePickerModeDateAndTime]; // 设置模式
    // 设置 时区
    [self.datepicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [popoverView addSubview:self.datepicker];
}


@end
