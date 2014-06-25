//
//  EndReceiveViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "EndReceiveViewController.h"

@interface EndReceiveViewController () <UITextViewDelegate>
@property (nonatomic, strong) UIScrollView *scorllView;
@end

@implementation EndReceiveViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.scorllView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.scorllView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.scorllView];
    [self.navigationController setTitle:@"填写本次接待总结"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelItemCilck)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveItemReceive)];
    NSArray *labeArray = @[@"姓名",@"手机",@"级别"];
    NSInteger i = 0;
    for (NSString *str in labeArray) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0+i*60, 60, 60)];
        [nameLabel setText:str];
        [nameLabel setFont:KFont18];
        [self.scorllView addSubview:nameLabel];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 60+i*60, self.scorllView.bounds.size.width-40, 1)];
        [lineView setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
        [lineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self.scorllView addSubview:lineView];
        i++;
    }
    UITextField *nameTextF = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 220, 60)];
    [nameTextF setPlaceholder:@"请填写客户姓名"];
    [self.scorllView addSubview:nameTextF];
    UITextField *phoneTextF = [[UITextField alloc] initWithFrame:CGRectMake(100, 60, 220, 60)];
    [phoneTextF setPlaceholder:@"请填写客户手机号"];
    [self.scorllView addSubview:phoneTextF];
    
    UIButton *jibieBut = [[UIButton alloc] initWithFrame:CGRectMake(100, 120, 220, 60)];
    [jibieBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [jibieBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [jibieBut setTitle:@"请选择" forState:UIControlStateNormal];
    [self.scorllView addSubview:jibieBut];
    
    UIView *lidianView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, self.scorllView.bounds.size.width, 200)];
    [lidianView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [lidianView setBackgroundColor:[UIColor redColor]];
    [self.scorllView addSubview:lidianView];
    
    UILabel *messgeLabel = [[UILabel alloc]  initWithFrame:CGRectMake(20, 380, 200, 60)];
    [messgeLabel setText:@"自动发短信/微信"];
    [self.scorllView addSubview:messgeLabel];
    
    UITextView *messgeTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 430, self.scorllView.bounds.size.width-40, 100)];
    [messgeTextView setFont:KFont18];
    [messgeTextView.layer setCornerRadius:5.0];
    [messgeTextView.layer setBorderWidth:1.0];
    [messgeTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [messgeTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [messgeTextView setText:[NSString stringWithFormat:@"尊敬的%@：感谢您光顾大搜车，接待中如有不周之处敬请谅解，今天和你聊的很开心，期待您的下次光临！你的搜车顾问%@：%@",@"张先生",@"陈小彬",@"18602771863"]];
    [messgeTextView setDelegate:self];
    [self.scorllView addSubview:messgeTextView];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.scorllView setContentOffset:CGPointMake(0, 200) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scorllView setContentOffset:CGPointMake(0, -44) animated:YES];
}

- (void)cancelItemCilck
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)saveItemReceive
{
    
}

@end
