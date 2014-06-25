//
//  UserVOModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-12.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserVOModel : NSObject

/** <#Name#> */
@property (copy, nonatomic) NSString *account;

/** <#Name#> */
@property (copy, nonatomic) NSString *accountName;

/** <#Name#> */
@property (copy, nonatomic) NSString *activeSession;

/** 地址code */
@property (copy, nonatomic) NSString *address;

/** 地址 */
@property (copy, nonatomic) NSString *addressName;

/** 年龄段code */
@property (copy, nonatomic) NSString *ageGroup;

/** <#Name#> */
@property (copy, nonatomic) NSString *ageGroupName;

/** 电话区号 */
@property (copy, nonatomic) NSString *areaPhone;

/** <#Name#> */
@property (copy, nonatomic) NSString *belongStore;

/** 生日 */
@property (copy, nonatomic) NSString *birthday;

/** 买家标识 */
@property (copy, nonatomic) NSString *buyer;

/** <#Name#> */
@property (copy, nonatomic) NSString *callPhone1;

/** <#Name#> */
@property (copy, nonatomic) NSString *callPhone2;

/** <#Name#> */
@property (copy, nonatomic) NSString *callPhone3;

/** <#Name#> */
@property (copy, nonatomic) NSString *callPhone4;

/** <#Name#> */
@property (copy, nonatomic) NSString *cardBank;

/** <#Name#> */
@property (copy, nonatomic) NSString *cardNumber;

/** <#Name#> */
@property (copy, nonatomic) NSString *cardUser;

/** 渠道来源 */
@property (copy, nonatomic) NSString *channel;

/** 渠道来源 */
@property (copy, nonatomic) NSString *channelName;

/** <#Name#> */
@property (copy, nonatomic) NSString *channelType;

/** 城市 */
@property (copy, nonatomic) NSString *city;

/** <#Name#> */
@property (copy, nonatomic) NSString *cityName;

/** <#Name#> */
@property (copy, nonatomic) NSString *counts;

/** 创建者 */
@property (copy, nonatomic) NSString *creator;

/** 用户标记-red，yellow,green */
@property (copy, nonatomic) NSString *crmUserTag;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateCreate;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateDelete;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateUpdate;

/** <#Name#> */
@property (copy, nonatomic) NSString *dealerCounselor;

/** 邮箱 */
@property (copy, nonatomic) NSString *email;

/** <#Name#> */
@property (copy, nonatomic) NSString *enable_name;

/** 主键id,现在系统中默认以手机号来表示 */
@property (copy, nonatomic) NSString *ID;

/** <#Name#> */
@property (copy, nonatomic) NSString *identityCard;

/** <#Name#> */
@property (copy, nonatomic) NSString *information;

/** <#Name#> */
@property (copy, nonatomic) NSString *lastLoadDate;

/** 处理人 */
@property (copy, nonatomic) NSString *leader;


/** 其他登陆账号 */
@property (copy, nonatomic) NSString *loginOther;

/** 手机登陆账号 */
@property (copy, nonatomic) NSString *loginPhone;

/** qq登陆账号 */
@property (copy, nonatomic) NSString *loginQq;

/** 微博登陆账号 */
@property (copy, nonatomic) NSString *loginWeibo;

/** 微信登陆账号 */
@property (copy, nonatomic) NSString *loginWeixin;

/**  */
@property (copy, nonatomic) NSString *name;

/** <#Name#> */
@property (copy, nonatomic) NSString *password;

/** 电话 */
@property (copy, nonatomic) NSString *phone;

/** 省份 */
@property (copy, nonatomic) NSString *province;

/** 省名称 */
@property (copy, nonatomic) NSString *provinceName;

/** QQ账号 */
@property (copy, nonatomic) NSString *qq;

/** 注册市 */
@property (copy, nonatomic) NSString *registerCity;

/** 注册省 */
@property (copy, nonatomic) NSString *registerProvince;

/** 卖家标识 */
@property (copy, nonatomic) NSString *saler;

/** 客户所归属销售ID */
@property (copy, nonatomic) NSString *sellerName;

/** 客户所归属销售名称 */
@property (copy, nonatomic) NSString *sellerNameShow;

/** 用户卖家等级 */
@property (copy, nonatomic) NSString *sellerStatus;

/** <#Name#> */
@property (copy, nonatomic) NSString *sellerType;

/** 性别code */
@property (copy, nonatomic) NSString *sex;

/** 性别名称 */
@property (copy, nonatomic) NSString *sexName;

/** 来源 */
@property (copy, nonatomic) NSString *source;

/** <#Name#> */
@property (copy, nonatomic) NSString *statusDate;

/** 用户类型:个人/公司 */
@property (copy, nonatomic) NSString *type;

/** <#Name#> */
@property (copy, nonatomic) NSString *typeName;

/** <#Name#> */
@property (copy, nonatomic) NSString *updateDate;

/** <#Name#> */
@property (copy, nonatomic) NSString *updateSqlDate;

/** <#Name#> */
@property (copy, nonatomic) NSString *userEnable;

/** 用户名称 */
@property (copy, nonatomic) NSString *userName;


/** 客户的等级code */
@property (copy, nonatomic) NSString *userStatus;

/** 客户等级 */
@property (copy, nonatomic) NSString *userStatusName;

/** 用户识别cookie */
@property (copy, nonatomic) NSString *userTag;

/** 旺旺 */
@property (copy, nonatomic) NSString *wangwang;

/** 微博 */
@property (copy, nonatomic) NSString *weibo;

/** 微信 */
@property (copy, nonatomic) NSString *weixin;

/** 微信识别码 */
@property (copy, nonatomic) NSString *weixinCode;

/** 固定电话 */
@property (copy, nonatomic) NSString *wirePhone;


@end
