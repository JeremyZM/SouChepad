//
//  ChangeTimePopoVC.m
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "ChangeTimePopoVC.h"

@interface ChangeTimePopoVC () <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *periodArray;
    NSString *perStr;
}
@end

@implementation ChangeTimePopoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"修改范围 两周内"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(saveChangdeDate:)];
    
    UIView* popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    popoverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:popoverView];
    //创建 UIDatePicker 控件
    self.datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];

    
//    UIDatePicker *datepicker = [[UIDatePicker alloc] init]; // 不用设置大小

//    [datepicker setBackgroundColor:[UIColor whiteColor]];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
//    [formate setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    [formate setDateFormat:@"yyyy-MM-dd"];
    NSDate *nowdate = [NSDate date];
    if (self.userResM) {
       nowdate = [formate dateFromString:self.userResM.reservationDate];
        
    }
    [self.datepicker setDate:nowdate];
    [self.datepicker setMinimumDate:nowdate];
    
    NSDate *maxDate = [nowdate dateByAddingTimeInterval:60*60*24*14];
    [self.datepicker setMaximumDate:maxDate];
    
    [self.datepicker setDatePickerMode:UIDatePickerModeDate]; // 设置模式
    // 设置 时区
    [self.datepicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [popoverView addSubview:self.datepicker];
    
    periodArray = @[@"上午",@"下午",@"晚上"];
    /**/
    self.periodPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(280, 0, 120, 300)];
    [self.periodPicker setDataSource:self];
    [self.periodPicker setDelegate: self];
    [popoverView addSubview:self.periodPicker];
    [self.periodPicker selectRow:0 inComponent:0 animated:NO];
    if (self.userResM) {
        if ([self.userResM.reservationTime isEqualToString:@"morning"]) {
            [self.periodPicker selectRow:0 inComponent:0 animated:NO];
        }else if ([self.userResM.reservationTime isEqualToString:@"afternoon"]){
            [self.periodPicker selectRow:1 inComponent:0 animated:NO];
        }else if ([self.userResM.reservationTime isEqualToString:@"night"]){
            [self.periodPicker selectRow:2 inComponent:0 animated:NO];
        }
    }
    perStr = @"上午";
}


- (void)saveChangdeDate:(UIBarButtonItem*)saveItem
{
    NSDate *changedate = self.datepicker.date;
    
}

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [periodArray count];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [periodArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    perStr = periodArray[row];
}

@end
