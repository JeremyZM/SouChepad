//
//  BaseDtaModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseDtaModel : NSObject <NSCoding>

/**  值对应 键 */
@property (copy, nonatomic) NSString *code;

/** 值 */
@property (copy, nonatomic) NSString *name;

/** 更新时间 */
@property (copy, nonatomic) NSString *updateDate;

@end
