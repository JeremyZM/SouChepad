//
//  LookCarRecordController.h
//  Athena
//
//  Created by 张艳东 on 14-7-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QRadioButton;
@class ASValueTrackingSlider;
@class BiaoQianView;


@interface LookCarRecordController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UITextField *nameTextF;


@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *priceSlider;


@property (weak, nonatomic) IBOutlet QRadioButton *highBut;


@property (weak, nonatomic) IBOutlet QRadioButton *middleBut;

@property (weak, nonatomic) IBOutlet QRadioButton *lowBut;

@property (strong, nonatomic) BiaoQianView *appraiseView;

@property (strong, nonatomic) UITextView *otherAppraiseTextV;


@property (nonatomic, copy) NSString *carID;

@end
