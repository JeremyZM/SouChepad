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

static PushManager *_mamager;

+(PushManager*)manaer{
    if (_mamager == nil) {
        _mamager = [[PushManager alloc] init];
    }
    return _mamager;
}

- (id)init{
    self = [super init];
    if (self) {
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        
        [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
        [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
        [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
        [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
        [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
    }
    return self;
}

// 注册推送
- (void)registerPushNotificationWithOptions:(NSDictionary *)launchOptions{
    // 注册推送
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
    // Required
    [APService setupWithOption:launchOptions];
}

// 上传设备token
- (void)uploadDeviceToken:(NSData*)deviceToken{
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
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    [APService handleRemoteNotification:userInfo];
}

// 处理收到的消息
- (void)handleRemoteNotification:(NSDictionary *)userInfo{
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送消息" message:content delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
    
}

// 清除icon上未读消息的数字
- (void)cleanAppBage{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


#pragma mark -

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"已注册:%@", notification);
}

- (void)networkDidLogin:(NSNotification *)notification {
    [UserDefaults setObject:[APService registrationID] forKey:@"jpushid"];
    syncUserDefaults;
    NSLog(@"已登录 ：%@" , [APService registrationID]);
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    
//    [_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
//    
//    [dateFormatter release];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


@end
