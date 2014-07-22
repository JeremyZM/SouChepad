//
//  LookCarRecordController.h
//  Athena
//
//  Created by 张艳东 on 14-7-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
#import "BiaoQianView.h"

@class UserOperationRecordVO;

@interface LookCarRecordController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextF;


@property (weak, nonatomic) IBOutlet UITextField *priceTextF;


@property (weak, nonatomic) IBOutlet QRadioButton *highBut;


@property (weak, nonatomic) IBOutlet QRadioButton *middleBut;

@property (weak, nonatomic) IBOutlet QRadioButton *lowBut;

@property (weak, nonatomic) IBOutlet BiaoQianView *appraiseView;

@property (weak, nonatomic) IBOutlet UITextField *otherAppraiseTextF;

@property (nonatomic, strong) UserOperationRecordVO *userOperVO;


@end
