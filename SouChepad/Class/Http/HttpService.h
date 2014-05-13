//
//  NetworkService.h
//  MyMKNetwork
//
//  Created by zt on 14-4-16.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^SuccessBlock) (MKNetworkOperation *obj);
typedef void (^FailBlock) (MKNetworkOperation *obj,NSError *error);

@interface HttpService : MKNetworkEngine


+(HttpService*)sharedService;

//  所有api都需要同此方法来请求
//  api：            接口的具体地址，不包括域名
//  parameter：      接口需要的所有参数
//  successBlock:   请求成功后的回调
//  failBlock:      请求失败的回调
//  reload:         是否需要禁用缓存，yes：即使有缓存也不实用，每次都重新加载；NO：启用缓存
//  needHud:        请的时候是否需要显示hud
- (MKNetworkOperation*)requestWithApi:(NSString*)api parameters:(NSDictionary*)parameter success:(SuccessBlock)successBlock fail:(FailBlock)failBlock reload:(BOOL)reload needHud:(BOOL)needHud hudEnabled:(BOOL)hudEnabled;

// 上传文件
// data:
// path:
//
//
- (MKNetworkOperation*)requestUploadFile:(NSData*)data api:(NSString*)api paras:(NSMutableDictionary*)paras;
@end
