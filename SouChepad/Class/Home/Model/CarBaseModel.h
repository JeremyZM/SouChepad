//
//  CarBaseModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-5.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarBaseModel : NSObject

/** 车辆ID */
@property (copy, nonatomic,readonly) NSString *carId;

/** 车架号 */
@property (copy, nonatomic,readonly) NSString *vin;

/** 搜车价 */
@property (copy, nonatomic,readonly) NSString *souchePrice;

/** 车辆名称 */
@property (copy, nonatomic,readonly) NSString *carName;

/** 首次上牌时间 */
@property (copy, nonatomic,readonly) NSString *firstLicensePlateDate;

/** 下订单时间 **/
@property (copy,nonatomic) NSString *day;

/** 车辆图片 */
@property (copy, nonatomic) NSString *image;

/** 车辆状态 */
@property (copy, nonatomic,readonly) NSString *carStatus;

/** 标签 */
@property (copy, nonatomic,readonly) NSString *label;

/** 降价 */
@property (copy, nonatomic,readonly) NSString *downPrice;

/** 等级 */
@property (copy, nonatomic,readonly) NSString *level;

/** 看车or试驾 */
@property (copy, nonatomic) NSString *lookORdrive;

/** 订单号*/
@property (copy, nonatomic) NSString *orderid;

@end
