//
//  UserOperationRecordVO.h
//  Athena
//
//  Created by 张艳东 on 14-7-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserOperationRecordVO : NSObject

/** 车辆价格 */
@property (copy, nonatomic) NSString *salerPrice;

/** 客户姓名 */
@property (copy, nonatomic) NSString *name;

/** 用户id */
@property (copy, nonatomic) NSString *user;

/** 操作员 */
@property (copy, nonatomic) NSString *operationUser;

/** 车辆id */
@property (copy, nonatomic) NSString *carId;

/** 操作结果 */
@property (copy, nonatomic) NSString *outcome;

/** 满意程度 */
@property (copy, nonatomic) NSString *satisfaction;

/** 备注 */
@property (copy, nonatomic) NSString *remarks;

/** lookcar 看车， testdrive 试驾 */
@property (copy, nonatomic) NSString *type;

/** 用户心里价位 */
@property (copy, nonatomic) NSString *userPrice;

/** 开始试驾时间 */
@property (copy, nonatomic) NSString *driveBeginTime;

/** 结束试驾时间 */
@property (copy, nonatomic) NSString *driveEndTime;

/** 开始公里数 */
@property (copy, nonatomic) NSString *beginMile;

/** 结束公里数 */
@property (copy, nonatomic) NSString *endMile;


@end
