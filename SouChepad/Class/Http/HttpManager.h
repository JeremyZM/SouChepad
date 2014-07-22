//
//  NetworkManager.h
//  MyMKNetwork
//
//  Created by zt on 14-4-16.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpService.h"

typedef void (^Success) (id obj);
typedef void (^Fail) (id obj);
typedef void (^UploadProgress)(NSString *progress);

@interface HttpManager : NSObject

// 取消网络请求
+ (void)cancelRequest:(MKNetworkOperation*)operation;

#pragma mark - 版本号更新
+(void)getOrWriteVersionNumber:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 获取各评价list
+ (void)getDictionarySuccess:(Success)success fail:(Fail)fail;



#pragma mark - 销售登陆
+(void)requestLoginWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 搜索手机号
+(void)requestSearchPhoneNumaber:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 搜索客户
+(void)requestClientWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 客户列表上拉加载更多
+(void)getOldUserParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 客户基本信息
+ (void)requestUserInfoWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 修改用户个人信息////创建无号码用户
+ (void)requestUpdtaeUser:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 销售修改预约到店时间
+ (void)requestUpdateReservationDate:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 根据vin码获取车辆的ID
+ (void)getCarInVin:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 用户信息进入接待
+ (void)requestUpdateBeginReservationByUser:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 预约客户进入接待
+ (void)requestUpdateBeginReservationById:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 销售修改预约到店时间（填写沟通）
+ (void)requestUpdateReservationDateByUser:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 沟通记录
+ (void)requestCommunicationWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 意向车辆
+ (void)requestUserIntentionWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 客户需求
+ (void)requestUserRequirementInfo:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 添加客户意向车型
+ (void)updateUserRequirementBrand:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 删除客户需求品牌车系
+ (void)delUserRequirementInfoBrand:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 我的消息
+ (void)requestMyMessageWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 获取所有车型
+ (void)getDictionaryByTypeAndLevel:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 用户强合并
+ (void)requestUserHandleByType:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 用户结束接待
+ (void)requestUserOutStore:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 修改销售个人信息
+ (void)updateSellerData:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 修改密码
+ (void)updatePassword:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;


// 上传图片，成功后返回dictionary
+ (void)requestUploadImage:(UIImage *)image imageIndex:(int)index success:(Success)success uploadProgress:(UploadProgress)uploadProgress fail:(Fail)fail;
@end
