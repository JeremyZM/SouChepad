//
//  CustomerListCell.m
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CustomerListCell.h"
#import "ChangeTimePopoVC.h"

@interface CustomerListCell ()

@end

@implementation CustomerListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)valuechanged:(UIDatePicker *)sender
{
    // 获得Datepicker的date值
    NSDate *date = sender.date;
    // NSDateFormatter 专门用来转换日期格式的 类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // NSDateFormatter转换为NSString
    NSString *dateStr = [formatter stringFromDate:date];
    
    [_TimeUpdate setTitle:[NSString stringWithFormat:@"预约到店 %@",dateStr] forState:UIControlStateNormal];
    [_TimeUpdate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

@end
