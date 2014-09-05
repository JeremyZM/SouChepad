//
//  DatePickViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "DatePickViewController.h"

@interface DatePickViewController ()
@property (nonatomic, strong) UIDatePicker *datepicker;

@end

@implementation DatePickViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建 UIDatePicker 控件
    self.datepicker = [[UIDatePicker alloc] init];
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-MM-dd"];
    [self.datepicker setDatePickerMode:UIDatePickerModeDate]; // 设置模式
    // 设置 时区
    if (self.minDate) {
        [self.datepicker setMinimumDate:self.minDate];
    }
    if (self.maxDate) {
        [self.datepicker setMaximumDate:self.maxDate];
    }
    
    [self.datepicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [self.datepicker addTarget:self action:@selector(datePickerChinagd:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datepicker];
    if (self.datesele) {
        [self.datepicker setDate:self.datesele];
    }
}

- (void)datePickerChinagd:(UIDatePicker*)datepick
{
    if ([_delegate respondsToSelector:@selector(datePickerVC:dateStr:)]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置格式
        [formatter setDateFormat:@"yyyy-MM-dd"];
        // NSDateFormatter转换为NSString
        NSString *dateStr = [formatter stringFromDate:datepick.date];
        [_delegate datePickerVC:self dateStr:dateStr];
    }
    
}

@end
