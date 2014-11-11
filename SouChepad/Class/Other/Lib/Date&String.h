//
//  Date&String.h
//  Athena
//
//  Created by 张艳东 on 14-9-2.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date_String : NSObject

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

@end
