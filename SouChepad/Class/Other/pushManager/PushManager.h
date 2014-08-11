//
//  PushManager.h
//  Athena
//
//  Created by zt on 14-8-6.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PushManager : NSObject

#define kUserDefaultsToken @"kUserDefaultsToken"

+(PushManager*)manaer;
// 注册推送
- (void)registerPushNotificationWithOptions:(NSDictionary *)launchOptions;
// 上传设备token
- (void)uploadDeviceToken:(NSData*)deviceToken;
// 处理收到的消息
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;
// 处理收到的消息
- (void)handleRemoteNotification:(NSDictionary *)userInfo;
// 清除icon上未读消息的数字
- (void)cleanAppBage;
@end
