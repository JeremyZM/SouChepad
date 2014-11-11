//
//  HZLocation.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZLocation : NSObject





@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;

/** 省 code */
@property (copy, nonatomic) NSString *stateCode;
/** 市 code */
@property (copy, nonatomic) NSString *cityCode;

@end
