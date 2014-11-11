//
//  Date&String.m
//  Athena
//
//  Created by 张艳东 on 14-9-2.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "Date&String.h"

@implementation Date_String

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}


+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:format];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

@end
