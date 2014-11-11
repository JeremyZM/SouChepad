//
//  CarDetailWebView.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

typedef enum {
    CarStatusTypeSelling = 0, // 在售
    CarStatusTypeSellout = 1, // 已售
    CarStatusTypePresell = 2  // 预售
} CarStatusType;


#import "SCBasicController.h"
@class CarBaseModel;

@interface CarDetailWebView : SCBasicController


/** 车辆ID */
@property (copy, nonatomic) NSString *carID;
@property (nonatomic,strong) CarBaseModel *carBaseModel;

/**
 *  是否预售车辆
 */
@property (assign, nonatomic) CarStatusType carStatusType;

@end
