//
//  DriveCarRecordController.h
//  Athena
//
//  Created by 张艳东 on 14-7-24.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DriveCarLastData;

@interface DriveCarRecordController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *startMileTextF;

@property (weak, nonatomic) IBOutlet UIImageView *drivingLicenseImage;


/** 车辆ID */
@property (copy, nonatomic) NSString *carId;
@property (nonatomic, strong) DriveCarLastData *driveCarDataM;

@end
