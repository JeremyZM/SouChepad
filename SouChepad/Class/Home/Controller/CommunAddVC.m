//
//  CommunAddVC.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CommunAddVC.h"
#import "ChangeTimePopoVC.h"

@interface CommunAddVC ()
{
    UIButton *timeBut;
    UIPopoverController *timePopoVC;
}
@end

@implementation CommunAddVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"新增沟通记录"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelRecord:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveRecord:)];
    

    
    UILabel *neir = [[UILabel alloc] initWithFrame:CGRectMake(20, 64, 60, 44)];
    [neir setTextAlignment:NSTextAlignmentCenter];
    [neir setText:@"内容"];
    [self.view addSubview:neir];
    
    UITextView *content = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(neir.frame)+20, neir.frame.origin.y, 400, 250)];
    [content.layer setCornerRadius:10];
    [content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [content setFont:[UIFont systemFontOfSize:17]];
    [content.layer setBorderWidth:1.0];
    [self.view addSubview:content];
    
    UISwitch *timeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(30,CGRectGetMaxY(content.frame)+30+5, 20, 20)];
    [self.view addSubview:timeSwitch];
    [timeSwitch addTarget:self action:@selector(addTimeSwitch:) forControlEvents:UIControlEventValueChanged];
    [timeSwitch sizeToFit];
    
    UILabel *shij = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeSwitch.frame), CGRectGetMaxY(content.frame)+30, 200, 44)];
    [shij setText:@"添加预约到店日期"];
    [shij setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:shij];
    
    timeBut = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shij.frame)+20, shij.frame.origin.y, 180, 40)];
    //    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter   alloc] init];
    [formatter  setDateFormat:@"yyyy-MM-dd"];
    [timeBut setTitle:[formatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [timeBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [timeBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [timeBut.layer setBorderWidth:1.0];
    [timeBut.layer setCornerRadius:8.0];
    [self.view addSubview:timeBut];
    [timeBut setHidden:YES];
    [timeBut addTarget:self action:@selector(showPopoChangeTime:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTimeSwitch:(UISwitch *)sw
{
    if (sw.isOn) {
        
        [timeBut setHidden:NO];
        
    }else{
        [timeBut setHidden:YES];
    }
}

- (void)showPopoChangeTime:(UIButton*)sender
{
    ChangeTimePopoVC *changeTime = [[ChangeTimePopoVC alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changeTime];
    timePopoVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    CGRect frame = [self.view convertRect:sender.frame fromView:sender.superview];
    timePopoVC.popoverContentSize = CGSizeMake(400, 300);
    [timePopoVC presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
