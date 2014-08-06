//
//  PushManager.h
//  Athena
//
//  Created by zt on 14-8-6.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserDefaultsToken @"kUserDefaultsToken"

@interface PushManager : NSObject

// 注册推送
+ (void)registerPushNotification;
// 上传设备token
+ (void)uploadDeviceToken:(NSData*)deviceToken;
@end
