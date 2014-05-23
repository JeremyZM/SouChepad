//
//  SendIFMacros.h
//  TravelHeNan
//
//  Created by Apple on 13-12-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SendIFMacros_h
#define SendIFMacros_h

//输出详细log,显示方法及所在的行数
// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define DLog(format, ...) do {                                              \
fprintf(stderr, ">------------------------------\n<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-----------------------------------\n");                                               \
} while (0)
#else
// 发布状态
#define DLog(...)
#endif

//当前系统版本
#define isIOS6 [[UIDevice currentDevice].systemVersion intValue]==6?1:0


#define userDefaultsName @"userDefaultsName"  //登陆账号
#define userDefaultsPWD @"userDefaultsPWD"    // 登陆密码


// 文字的高度比例
#define kTitleRatio 0.3

#define ratBtnTag 100  // 按等级排序按钮tag
#define nameBtnTag 101  // 按时间排序按钮tag

#define KDockW 200

#define kDockItemH 125  // DockItem栏宽
#define kDockItemW 200

#define KShowDockNotification @"ShowDockNotification"


#define KHttpBaseURL  @"115.29.10.121:11080/soucheweb"

#define Khttp @"115.29.10.121:11080/soucheweb 122.224.68.242:8081/soucheweb"

#endif
