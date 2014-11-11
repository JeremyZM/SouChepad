//
//  NetworkService.m
//  MyMKNetwork
//
//  Created by zt on 14-4-16.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "HttpService.h"
#import "SCHudManager.h"
#import "ProgressHUD.h"

// 字符串格式化
#define FormatStr(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]

//#define kServiceDomain @"app.souche.com"

static HttpService * engine;

@implementation HttpService

+(HttpService*)sharedService{
     if (engine == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            engine = [[self alloc] initWithHostName:[UserDefaults objectForKey:@"httpServerIP"]];
        });
     }
    return engine;
}



// post 请求
- (MKNetworkOperation*)requestWithApi:(NSString*)api parameters:(NSDictionary*)parameter success:(SuccessBlock)successBlock fail:(FailBlock)failBlock reload:(BOOL)reload needHud:(BOOL)needHud hudEnabled:(BOOL)hudEnabled {
    // 是否显示hud
    if (needHud) {
        if (hudEnabled) {
            
            [SCHudManager showHUD];
        }else{
            
            [ProgressHUD show:nil];
        }
    }
    
    MKNetworkOperation *operation = [engine operationWithPath:api params:parameter httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        // 请求成功后隐藏hud
        if (needHud) {
            if (hudEnabled) {
                [SCHudManager hiddenHud];
            }else{
                [ProgressHUD dismiss];
            }
        }
        
        NSString *error = [[completedOperation responseJSON] objectForKey:@"errorMessage"];
        if (error == NULL) {
            successBlock(completedOperation);
        }else{
            if ([@"100" isEqualToString:error]) {
                [ProgressHUD showError:@"登录过期,请重新登录"];
            }else{
                [ProgressHUD showError:error];
            }
            DLog(@"error:%@", error);
        }

    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {

        
        // 请求失败后隐藏hud
        if (needHud) {
            if (hudEnabled) {
                
                [SCHudManager showHudWithImage:nil title:[NSString stringWithFormat:@"%@",[error localizedDescription]]];
            }else{
            
                [ProgressHUD showError:[NSString stringWithFormat:@"%@",[error localizedDescription]]];
            }
        }
        
        //网络有问题
        if([engine isReachable] == NO){
            if (hudEnabled) {
                
                [SCHudManager showHudWithImage:nil title:@"当前网络不可用"];
            }else{
                [ProgressHUD showError:@"当前网络不可用"];
            }
        }
        failBlock(completedOperation,error);
    }];

    [engine enqueueOperation:operation forceReload:NO];
    
    [self formatUrlAndParameters:parameter path:api];
    return operation;
}

- (void)formatUrlAndParameters:(NSDictionary*)parameters path:(NSString*)path{
    //格式化url和参数
    NSString *paraString=@"";
    NSArray *keyArray = [parameters allKeys];
    int index = 0;
    for (NSString *key in keyArray) {
        NSString *value = [parameters objectForKey:key];
        paraString = FormatStr(@"%@%@=%@%@",paraString,key,value, ++index == keyArray.count ? @"" : @"&");
    }
    NSString *api = FormatStr(@"====\n%@/%@?%@\n=======", [UserDefaults objectForKey:@"httpServerIP"],path, paraString);
    DLog(@"api:%@", api);
}

// upload
- (MKNetworkOperation*)requestUploadFile:(NSData*)data api:(NSString*)api paras:(NSMutableDictionary*)paras{
//    MKNetworkEngine *engineimage = [[MKNetworkEngine alloc] initWithHostName:@"res.souche.com" ];
    MKNetworkOperation *op = [[HttpService sharedService] operationWithPath:api
                                                     params:paras
                                                 httpMethod:@"POST"];

    [op addData:data forKey:@"uploadData"];
    
    // setFreezable uploads your images after connection is restored!
    [op setFreezable:YES];
    DLog(@"%@",op);
    return op;
}
@end
