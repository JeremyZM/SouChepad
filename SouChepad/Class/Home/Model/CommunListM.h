//
//  CommunListM.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-7.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunListM : NSObject
/**
 *  沟通记录
 */
@property (nonatomic, copy) NSString *comment;

/**
 *  记录时间
 */
@property (nonatomic, copy) NSString *day;

/**
 *  记录处理人
 */
@property (nonatomic, copy) NSString *handler;

@end
