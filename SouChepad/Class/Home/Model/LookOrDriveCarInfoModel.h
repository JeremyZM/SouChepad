//
//  LookOrDriveCarInfoModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarBaseModel.h"

@interface LookOrDriveCarInfoModel : CarBaseModel

/** 看车试驾id */
@property (copy, nonatomic) NSString *driveAndLookId;

/** 看车试驾状态 lookcar 看车， testdrive 试驾 */
@property (copy, nonatomic) NSString *status;

/** 试驾记录 */
@property (copy, nonatomic) NSString *driveRemark;

/** 看车记录 */
@property (copy, nonatomic) NSString *lookRemark;

/** 销售 */
@property (copy, nonatomic) NSString *seller;

/** 看车试驾具体时间 */
@property (copy, nonatomic) NSString *day;

/** 心里价位 */
@property (copy, nonatomic) NSString *userPrice;

/** 满意度 */
@property (copy, nonatomic) NSString *satisfaction;

/** 试驾公里 */
@property (copy, nonatomic) NSString *driveMile;

/** 试驾开始时间 */
@property (copy, nonatomic) NSString *driveBeginTime;

/** 试驾时间 */
@property (copy, nonatomic) NSString *driveTime;

/** 看车开始时间 */
@property (copy, nonatomic) NSString *lookBeginTime;


@end
