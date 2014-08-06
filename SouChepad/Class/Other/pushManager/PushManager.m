//
//  PushManager.m
//  Athena
//
//  Created by zt on 14-8-6.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "PushManager.h"
#import "APService.h"

@implementation PushManager

// 注册推送
+ (void)registerPushNotificationWithOptions:(NSDictionary *)launchOptions{
    // 注册推送
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
    // Required
    [APService setupWithOption:launchOptions];
}

// 上传设备token
+ (void)uploadDeviceToken:(NSData*)deviceToken{
    NSString *token = [[[deviceToken description]
                        stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                       stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    DLog(@"device token: %@", token);
    // 极光注册
    [APService registerDeviceToken:deviceToken];
    // 保存token到ud中
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kUserDefaultsToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //TODO.... 调用上传接口
}

// 处理收到的消息
+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    [APService handleRemoteNotification:userInfo];
}

// 处理收到的消息
+ (void)handleRemoteNotification:(NSDictionary *)userInfo{
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
}
@end
