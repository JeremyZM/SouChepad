//
//  UserReservationM.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-28.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserReservationM : NSObject
/**
 *  用户ID
 */
@property (copy, nonatomic) NSString *crmUserId;

/** 接待状态 */
@property (copy, nonatomic) NSString *reservationStatus;

/**
 *  预约时间
 */
@property (copy, nonatomic) NSString *day;

/** 预约日期 */
@property (copy, nonatomic) NSString *reservationDate;

/** 预约上下午 */
@property (copy, nonatomic) NSString *reservationTime;

/** 处理人 */
@property (copy, nonatomic) NSString *handler;

/** 电话 */
@property (copy, nonatomic) NSString *phone;

/** 性别 */
@property (copy, nonatomic) NSString *sex;
/**
 *  用户姓名
 */
@property (copy, nonatomic) NSString *user;
/**
 *  等级
 */
@property (copy, nonatomic) NSString *userLevel;

/** 预约到店ID */
@property (copy, nonatomic) NSString *reservationId;


/** 更新时间 */
@property (copy, nonatomic) NSString *updateDay;

@end
