//
//  MyMessage.h
//  Athena
//
//  Created by zt on 14-8-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessage : NSObject

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *carId;//
@property (nonatomic,copy) NSString *dateCreate;//"2014-08-06 17:34:19",
@property (nonatomic,copy) NSString *dateDelete;//
@property (nonatomic,copy) NSString *displayTime;//"昨天",
@property (nonatomic,copy) NSString *message;////"this is test!",
@property (nonatomic,strong) NSNumber *status;//
@property (nonatomic,copy) NSString *title;//"客户被接待",
@property (nonatomic,copy) NSString *imageURL;//图片
@end
