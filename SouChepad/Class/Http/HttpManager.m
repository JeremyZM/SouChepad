//
//  NetworkManager.m
//  MyMKNetwork
//
//  Created by zt on 14-4-16.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "HttpManager.h"
//#import "SCHudManager.h"
#import "ProgressHUD.h"
//#import "UsertoStore.h"
#import "UserReservationM.h"
#import "NSObject+MJKeyValue.h"
#import "CommunListM.h"
#import "MyMessage.h"

@implementation HttpManager

// 取消网络请求
+ (void)cancelRequest:(MKNetworkOperation*)operation{
    [ProgressHUD dismiss];
    [operation cancel];
}


#pragma mark - 销售登陆
+(MKNetworkOperation*)requestLoginWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    MKNetworkOperation *op = [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/sellLogin.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"obj---%@",obj);
        NSDictionary *login = [obj responseJSON];
        NSString *isok = login[@"login"];
        success(isok);
    } fail:^(MKNetworkOperation *obj,NSError*error) {
        DLog(@"errer---%@",[error localizedDescription]);
        fail(obj);
    } reload:YES needHud:YES hudEnabled:YES];
    
    return op;
}

#pragma mark - 搜索所有客户
+(MKNetworkOperation *)requestClientWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail{
    NSString *url = @"pages/sellManageAction/sellToUser.json";
    MKNetworkOperation *op = [[HttpService sharedService] requestWithApi:url parameters:paramDic success:^(MKNetworkOperation *obj) {
        [ProgressHUD show:nil];
        DLog(@"obj--:%@",[obj responseJSON]);
        NSDictionary *dataDic = [obj responseJSON];
        NSArray *reservation = [NSArray arrayWithArray:[dataDic objectForKey:@"userreservation"]];
        NSMutableArray *reserArrayM = [NSMutableArray arrayWithCapacity:reservation.count];
        for (NSDictionary *userReserDic in reservation) {
           UserReservationM *userReserM = [[UserReservationM alloc] init];
            [userReserM setKeyValues:userReserDic];
            [reserArrayM addObject:userReserM];
        }
        NSArray *usertostore = [NSArray arrayWithArray:[dataDic objectForKey:@"usertostore"]];
        NSMutableArray *storeM = [NSMutableArray arrayWithCapacity:usertostore.count];
        for (NSDictionary *usertostoreDic in usertostore) {
            UserReservationM *usertostoreM = [[UserReservationM alloc] init];
            [usertostoreM setKeyValues:usertostoreDic];
            [storeM addObject:usertostoreM];
        }
        
        NSDictionary *ModelDataDic = @{@"userreservation":reserArrayM,@"usertostore":storeM};
        [ProgressHUD dismiss];
        success(ModelDataDic);
    } fail:^(MKNetworkOperation *obj,NSError *error) {
        DLog(@"error--:%@",[error localizedDescription]);
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
    
    return op;
}

#pragma mark - 客户基本信息
+ (MKNetworkOperation*)requestUserInfoWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    MKNetworkOperation *op = [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getToStoreUser.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:NO];

    return op;
}

#pragma mark - 沟通记录
+ (MKNetworkOperation *)requestCommunicationWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    MKNetworkOperation *op = [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getUserCommunication.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dataDic = [obj responseJSON];
        NSArray *array = [dataDic objectForKey:@"communication"];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            CommunListM *communM = [[CommunListM alloc] init];
            [communM setKeyValues:dic];
            [arrayM addObject:communM];
        }
        success(arrayM);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:NO];
    
    return op;
}

#pragma mark - 意向车辆
+ (MKNetworkOperation *)requestUserIntentionWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    MKNetworkOperation *op = [[HttpService sharedService]
    requestWithApi:@"pages/sellManageAction/getUserCar.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:NO];
    return op;
}

#pragma mark - 我的消息
+ (MKNetworkOperation *)requestMyMessageWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    MKNetworkOperation *op = [[HttpService sharedService]
                              requestWithApi:@"pages/sellManageAction/getSellHint.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
                                  DLog(@"%@",[obj responseJSON]);
                                  
                                  NSDictionary *dataDic = [obj responseJSON];
                                  NSArray *array = [dataDic objectForKey:@"baseHint"];
                                  NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
                                  for (NSDictionary *dic in array) {
                                      MyMessage *myMessage = [[MyMessage alloc] init];
                                      [myMessage setKeyValues:dic];
                                      [arrayM addObject:myMessage];
                                  }
                                  success(arrayM);
                              } fail:^(MKNetworkOperation *obj, NSError *error) {
                                  fail([error localizedDescription]);
                              } reload:YES needHud:YES hudEnabled:NO];
    return op;
}


// 上传测试
+ (MKNetworkOperation *)requestUploadImage:(UIImage *)image imageIndex:(int)index success:(Success)success uploadProgress:(UploadProgress)uploadProgress fail:(Fail)fail{
    NSString *path = @"pages/app/yushou/carAction/uploadImage.upload";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d", index] forKey:@"pic"];
    
    NSData *data = UIImagePNGRepresentation(image);
    MKNetworkOperation *op = [[HttpService sharedService] requestUploadFile:data
                                                                        api:path
                                                                      paras:dic];
    // 上传
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        NSString *xmlString = [completedOperation responseString];
        DLog(@"%@", xmlString);
        success(xmlString);
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        fail(error);
    }];
    
    // 进度
    [op onUploadProgressChanged:^(double progress) {
        NSString *strProgress = [NSString stringWithFormat:@"%.2f", progress*100.0];
        DLog(@"Upload file progress: %@", strProgress);
        uploadProgress(strProgress);
    }];
    
    [[HttpService sharedService] enqueueOperation:op];
    
    return op;
}
@end
