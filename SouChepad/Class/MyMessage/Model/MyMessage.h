//
//  MyMessage.h
//  Athena
//
//  Created by zt on 14-8-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessage : NSObject

@property (nonatomic,strong) NSString *carId;//
@property (nonatomic,strong) NSString *dateCreate;//"2014-08-06 17:34:19",
@property (nonatomic,strong) NSString *dateDelete;//
@property (nonatomic,strong) NSString *displayTime;//"昨天",
@property (nonatomic,strong) NSString *message;////"this is test!",
@property (nonatomic,strong) NSString *status;//
@property (nonatomic,strong) NSString *title;//"客户被接待",
@end
