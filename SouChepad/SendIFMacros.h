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
#define kTitleRatio 0.4

#define ratBtnTag 100  // 按等级排序按钮tag
#define nameBtnTag 101  // 按时间排序按钮tag

#define KDockW 180

#define kDockItemH 100  // DockItem栏宽
#define kDockItemW 180

#define KShowDockNotification @"ShowDockNotification"


#define KHttpBaseURL  @"manage.souche.com"

#define Khttp @"115.29.10.121:11080/soucheweb   122.224.68.242:8081/soucheweb  192.168.0.250:8088/soucheweb  121.199.21.232:10080//soucheweb "

#define KImageBaseURL @"http://res.souche.com/"

// 销售昵称
#define KSellName @"sellName"
// 邮箱
#define KSellEmail @"sellEmail"
// 电话
#define KSellPhone @"sellPhone"
// 地址
#define KSellAddressName @"sellAddressName"
// qq
#define KSellQQ @"sellQQ"




#define KUserName [[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName]
#define KUserPWD [[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsPWD]

/**
 *   18号字体
 */
#define KFont18 [UIFont systemFontOfSize:18]

/**
 *  18号粗体
 */
#define KBoldFont18  [UIFont boldSystemFontOfSize:18]

/**
 *  主色
 */
#define KBaseColo @"#ff5719"
/**
 *  主色背景黑
 */
#define KBackColo @"#262626"

/**
 *  分割线颜色
 */
#define KSeparatorColor @"#e6e6e6"

/**
 *  allListData.plist
 */
#define KallListData [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"allListData.plist"]


#define KbuyerStatusOther [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"buyerStatusOther.plist"]

#define KAllCarTypeData [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"AllCarTypeData.plist"]

/**
 *  buyerStatus
 */
#define KbuyerStatus [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"buyerStatus.plist"]
/**
 *  carCountrySimple
 */
#define KcarCountrySimple [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"carCountrySimple.plist"]

/**
 *  departureReason
 */
#define KdepartureReason [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"departureReason.plist"]

/**
 *  driveCarEvaluate
 */
#define KdriveCarEvaluate [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"driveCarEvaluate.plist"]

/**
 *  lookCarEvaluate
 */
#define KlookCarEvaluate [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"lookCarEvaluate.plist"]


/**
 *  mileageSimple
 */
#define KmileageSimple [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"mileageSimple.plist"]


/**
 *  satisfactionDegree
 */
#define KsatisfactionDegree [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"satisfactionDegree.plist"]


/**
 *  seeCarTime
 */
#define KseeCarTime [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"seeCarTime.plist"]

/**
 *  vehicleType
 */
#define KvehicleType [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"vehicleType.plist"]

#endif
