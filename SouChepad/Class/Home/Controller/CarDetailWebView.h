//
//  CarDetailWebView.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SCBasicController.h"
@class CarDetailWebView;

@protocol CarDetailVCDelegate <NSObject>

- (void)dismissViewAllController:(CarDetailWebView*)carDetailVC;

@end

@interface CarDetailWebView : SCBasicController

/** 车辆ID */
@property (copy, nonatomic) NSString *carID;
@property (weak, nonatomic) id<CarDetailVCDelegate> delegate;

@end
