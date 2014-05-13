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

//#define kServiceDomain @"app.souche.com"

static HttpService * engine;

@implementation HttpService

+(HttpService*)sharedService{
     if (engine == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            engine = [[self alloc] initWithHostName:KHttpBaseURL];
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
    successBlock(completedOperation);
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
    return operation;
}

// upload
- (MKNetworkOperation*)requestUploadFile:(NSData*)data api:(NSString*)api paras:(NSMutableDictionary*)paras{
    MKNetworkOperation *op = [[HttpService sharedService] operationWithPath:api
                                                                        params:paras
                                                                    httpMethod:@"POST"];
    [op addData:data forKey:@"uploadData"];
    
    // setFreezable uploads your images after connection is restored!
    [op setFreezable:YES];
    return op;
}
@end
