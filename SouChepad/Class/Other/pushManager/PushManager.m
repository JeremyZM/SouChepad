//
//  PushManager.m
//  Athena
//
//  Created by zt on 14-8-6.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "PushManager.h"

@implementation PushManager

// 注册推送
+ (void)registerPushNotification{
    // 注册推送
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
}

// 上传设备token
+ (void)uploadDeviceToken:(NSData*)deviceToken{
    NSString *token = [[[deviceToken description]
                        stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                       stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    DLog(@"device token: %@", token);
    // 保存token到ud中
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kUserDefaultsToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //TODO.... 调用上传接口
}
@end
