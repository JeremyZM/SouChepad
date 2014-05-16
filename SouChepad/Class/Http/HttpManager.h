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

#pragma mark - 销售登陆
+(MKNetworkOperation*)requestLoginWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 搜索客户
+(MKNetworkOperation *)requestClientWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 客户基本信息
+ (MKNetworkOperation*)requestUserInfoWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 沟通记录
+ (MKNetworkOperation*)requestCommunicationWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 意向车辆
+ (MKNetworkOperation *)requestUserIntentionWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 我的消息
+ (MKNetworkOperation *)requestMyMessageWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

// 上传图片，成功后返回dictionary
+ (MKNetworkOperation*)requestUploadImage:(UIImage *)image imageIndex:(int)index success:(Success)success uploadProgress:(UploadProgress)uploadProgress fail:(Fail)fail;
@end
