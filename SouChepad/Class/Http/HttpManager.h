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

#pragma mark - 获取各评价list
+ (void)getDictionarySuccess:(Success)success fail:(Fail)fail;



#pragma mark - 销售登陆
+(void)requestLoginWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 搜索手机号
/**
 *  搜索手机号
 *
 *  @param paramDic 手机号和销售id
 *  @param success  成功
 *  @param fail     失败
 */
+(void)requestSearchPhoneNumaber:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 搜索客户
+(void)requestClientWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 客户基本信息
+ (void)requestUserInfoWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 沟通记录
+ (void)requestCommunicationWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 意向车辆
+ (void)requestUserIntentionWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 我的消息
+ (void)requestMyMessageWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

// 上传图片，成功后返回dictionary
+ (void)requestUploadImage:(UIImage *)image imageIndex:(int)index success:(Success)success uploadProgress:(UploadProgress)uploadProgress fail:(Fail)fail;
@end
