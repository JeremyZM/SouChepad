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
@property (nonatomic, strong) UIPopoverController *timePopoVC;
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

- (IBAction)changeTime:(UIButton*)sender {
    ChangeTimePopoVC *changeTime = [[ChangeTimePopoVC alloc] init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changeTime];
    self.timePopoVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    CGRect frame = [self.superview convertRect:sender.frame fromView:sender.superview];
    self.timePopoVC.popoverContentSize = CGSizeMake(320, 300);
    [self.timePopoVC presentPopoverFromRect:frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [changeTime.datepicker addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)valuechanged:(UIDatePicker *)sender
{
    // 获得Datepicker的date值
    NSDate *date = sender.date;
    // NSDateFormatter 专门用来转换日期格式的 类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    // NSDateFormatter转换为NSString
    NSString *dateStr = [formatter stringFromDate:date];
    
    [_TimeUpdate setTitle:[NSString stringWithFormat:@"预约到店 %@",dateStr] forState:UIControlStateNormal];
    [_TimeUpdate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

@end
