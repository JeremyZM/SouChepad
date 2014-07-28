//
//  OverDriveCarController.h
//  Athena
//
//  Created by 张艳东 on 14-7-25.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DriveCarLastData;
@class QRadioButton;
@class ASValueTrackingSlider;

@interface OverDriveCarController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UITextField *endMileTextF;

@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *priceSlider;

@property (weak, nonatomic) IBOutlet QRadioButton *highBut;

@property (weak, nonatomic) IBOutlet QRadioButton *middlingBut;

@property (weak, nonatomic) IBOutlet QRadioButton *lowBut;


/** 车辆ID */
@property (copy, nonatomic) NSString *carId;
@property (nonatomic, strong) DriveCarLastData *driveCarDataM;

@end
