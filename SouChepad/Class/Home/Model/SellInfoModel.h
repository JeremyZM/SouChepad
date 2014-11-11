//
//  SellInfoModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellInfoModel : NSObject

@property (copy,nonatomic) NSString *id;
/** 昵称 */
@property (copy, nonatomic) NSString *nickName;

/** 邮箱 */
@property (copy, nonatomic) NSString *email;

/** 电话 */
@property (copy, nonatomic) NSString *phone;

/** 地址 */
@property (copy, nonatomic) NSString *address;

/** QQ */
@property (copy, nonatomic) NSString *qq;

@end
