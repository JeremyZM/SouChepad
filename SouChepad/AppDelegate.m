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


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    DLog(@"%@--%@",[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName],[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsPWD]);
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

@end
