//
//  DriveCarLastData.h
//  Athena
//
//  Created by 张艳东 on 14-7-24.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriveCarLastData : NSObject

/** 是否有过该车的试驾记录(1:有;0:无) */
@property (copy, nonatomic) NSString *isDriveCar;

/** 用户姓名 */
@property (copy, nonatomic) NSString *name;

/** 号码 */
@property (copy, nonatomic) NSString *phone;

/** 最后一次心理价位（isDriveCar :1展示） */
@property (copy, nonatomic) NSString *userPrice;

/** 车辆价格（万元） */
@property (copy, nonatomic) NSString *salerPrice;

/** 车辆里程 */
@property (copy, nonatomic) NSString *mile;

/** 驾驶证 （isDriveCar :0展示） */
@property (copy, nonatomic) NSString *drivelicense;


@end
