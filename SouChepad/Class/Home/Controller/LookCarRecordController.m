//
//  LookCarRecordController.m
//  Athena
//
//  Created by 张艳东 on 14-7-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "LookCarRecordController.h"
#import "UserOperationRecordVO.h"

@interface LookCarRecordController () <QRadioButtonDelegate>

@end

@implementation LookCarRecordController

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationItem setTitle:@"填写看车记录"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelfController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveLookCarRecord:)];
    
    [self.highBut setGroupId:@"1"];
    [self.highBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateSelected];
    [self.highBut setDelegate:self];
    
    [self.middleBut setGroupId:@"1"];
    [self.middleBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateSelected];
    [self.middleBut setDelegate:self];
    
    [self.lowBut setGroupId:@"1"];
    [self.lowBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateSelected];
    [self.lowBut setDelegate:self];
}


- (void)setUserOperVO:(UserOperationRecordVO *)userOperVO
{
    
    [self.priceTextF setText:userOperVO.userPrice];

}


- (void)dismissSelfController:(UIBarButtonItem*)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)saveLookCarRecord:(UIBarButtonItem*)item
{
    
}


@end
