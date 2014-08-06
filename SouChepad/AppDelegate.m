//
//  AppDelegate.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "MainViewController.h"
#import "HttpManager.h"
#import "PushManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 注册推送
    [PushManager registerPushNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [MobClick startWithAppkey:@"53d1b05856240b994d00c6fe" reportPolicy:REALTIME   channelId:nil];
    [MobClick setLogEnabled:YES];
    
    [HttpManager getOrWriteVersionNumber:nil Success:^(id obj) {
        
        NSDictionary *verDic = obj;
        NSString *localVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        NSString *versID = [verDic objectForKey:@"versionNumber"];
        NSString *commentInfo = [verDic objectForKey:@"comment"];
        if (![versID isEqualToString:localVersion])
        {
            UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本V%@！！",versID] message:commentInfo delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即更新", nil];
            [createUserResponseAlert show];
        }
        
    } fail:^(id obj) {
        
    }];
    
       DLog(@"%@--%@",[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName],[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsPWD]);
    DLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"httpServerIP"]);
    BOOL islog = !([[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName]==nil) && !([[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsPWD] == nil);
    
    if (islog) {
        // 已经登陆
        MainViewController *mainVC = [[MainViewController alloc] init];
        [self.window setRootViewController:mainVC];

    } else {
        // 未登陆
        LogInViewController *logInVC = [[LogInViewController alloc]init];
        [self.window setRootViewController:logInVC];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 0)
    {
        NSString *iTunesLink = @"http:app.souche.com/app/athena";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 推送代理
// 注册token 成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [PushManager uploadDeviceToken:deviceToken];
}

// 注册token 失败
-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    NSLog(@"注册失败，无法获取设备ID, 具体错误: %@", error);
}

// 搜到推送消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveRemoteNotification" object:nil];
    DLog(@"%@", userInfo);
}
@end
