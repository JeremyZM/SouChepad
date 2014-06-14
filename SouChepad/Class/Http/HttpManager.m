//
//  NetworkManager.m
//  MyMKNetwork
//
//  Created by zt on 14-4-16.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "HttpManager.h"
#import "ProgressHUD.h"
#import "UserReservationM.h"
#import "NSObject+MJKeyValue.h"
#import "CommunListM.h"
#import "MyMessage.h"
#import "CarBaseModel.h"
#import "TradeCarInfoModel.h"
#import "LookOrDriveCarInfoModel.h"
#import "BaseDtaModel.h"
#import "UserExtendModel.h"
#import "UserVOModel.h"
#import "SellInfoModel.h"

@implementation HttpManager

// 取消网络请求
+ (void)cancelRequest:(MKNetworkOperation*)operation{
    [ProgressHUD dismiss];
    [operation cancel];
}

#pragma mark - 获取各评价list
/**
 *
 *
 *  @param success
 *  @param fail
 */
+ (void)getDictionarySuccess:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getDictionary.json" parameters:nil success:^(MKNetworkOperation *obj) {
      
         DLog(@"%@",[obj responseJSON]);
        NSDictionary* dic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];

        NSArray *keyArray = [dic allKeys];
        for (NSString *keyStr in keyArray) {
            
            if ([keyStr isEqualToString:@"errorMessage"]) return;
                
            NSMutableArray *buyArrayM = [NSMutableArray array];
            NSArray *buyerStatusArray = [dic objectForKey:keyStr];
            for (NSDictionary *dic in buyerStatusArray) {
                BaseDtaModel *buyerStatusM = [[BaseDtaModel alloc] init];
                [buyerStatusM setKeyValues:dic];
                [buyArrayM addObject:buyerStatusM];
            }
            if ([keyStr isEqualToString:@"buyerStatus"]) {
                
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KbuyerStatus];
            }else if ([keyStr isEqualToString:@"carCountrySimple"]) {
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KcarCountrySimple];
            }else if ([keyStr isEqualToString:@"departureReason"]){
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KdepartureReason];
            }else if ([keyStr isEqualToString:@"driveCarEvaluate"]){
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KdriveCarEvaluate];
            }else if ([keyStr isEqualToString:@"lookCarEvaluate"]){
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KlookCarEvaluate];
            }else if ([keyStr isEqualToString:@"mileageSimple"]){
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KmileageSimple];
            }else if ([keyStr isEqualToString:@"satisfactionDegree"]){
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KsatisfactionDegree];
            
            }else if ([keyStr isEqualToString:@"seeCarTime"]){
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KseeCarTime];
            }else if ([keyStr isEqualToString:@"vehicleType"]){
                [NSKeyedArchiver archiveRootObject:buyArrayM toFile:KvehicleType];
            }
        }
        
       
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:NO hudEnabled:NO];

}



#pragma mark - 销售登陆
/**
 *  销售登陆
 *
 *  @param paramDic 请求参数
 *  @param success  成功
 *  @param fail     失败
 */
+(void)requestLoginWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/sellLogin.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"obj---%@",obj);
        NSDictionary *login = [obj responseJSON];
        NSString *isok = login[@"login"];
        success(isok);
    } fail:^(MKNetworkOperation *obj,NSError*error) {
        DLog(@"errer---%@",[error localizedDescription]);
        fail(obj);
    } reload:YES needHud:YES hudEnabled:YES];
    
}

#pragma mark - 搜索所有客户
+(void)requestClientWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail{
    NSString *url = @"pages/sellManageAction/sellToUser.json";
        [[HttpService sharedService] requestWithApi:url parameters:paramDic success:^(MKNetworkOperation *obj) {
            [ProgressHUD show:nil];
            DLog(@"obj--:%@",[obj responseJSON]);
            NSDictionary *dataDic = [obj responseJSON];
            NSDictionary *sellDic = [dataDic objectForKey:@"sell"];
            SellInfoModel *sellInfoM = [[SellInfoModel alloc] init];
            [sellInfoM setKeyValues:sellDic];
            
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.name forKey:KSellName];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.email forKey:KSellEmail];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.phone forKey:KSellPhone];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.addressName forKey:KSellAddressName];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.qq forKey:KSellQQ];
            
            
        NSMutableArray *reserArrayM = [NSMutableArray array];
            
        // 正在接待中...
        NSArray *userreservationInHand = [NSArray arrayWithArray:[dataDic objectForKey:@"userreservationInHand"]];
        for (NSDictionary *userReserDic in userreservationInHand) {
            UserReservationM *userReserM = [[UserReservationM alloc] init];
            [userReserM setKeyValues:userReserDic];
            [reserArrayM addObject:userReserM];
        }
            
        // 今日预约
        NSArray *reservation = [NSArray arrayWithArray:[dataDic objectForKey:@"userreservationNew"]];

        for (NSDictionary *userReserDic in reservation) {
           UserReservationM *userReserM = [[UserReservationM alloc] init];
            [userReserM setKeyValues:userReserDic];
            [reserArrayM addObject:userReserM];
        }
        
        // 接待完成
        NSArray *userreservationFinish = [NSArray arrayWithArray:[dataDic objectForKey:@"userreservationFinish"]];
        
        for (NSDictionary *userReserDic in userreservationFinish) {
            UserReservationM *userReserM = [[UserReservationM alloc] init];
            [userReserM setKeyValues:userReserDic];
            [reserArrayM addObject:userReserM];
        }
            
            
        // 历史接待
        NSArray *usertostore = [NSArray arrayWithArray:[dataDic objectForKey:@"usertostore"]];
        NSMutableArray *storeM = [NSMutableArray arrayWithCapacity:usertostore.count];
        for (NSDictionary *usertostoreDic in usertostore) {
            UserReservationM *usertostoreM = [[UserReservationM alloc] init];
            [usertostoreM setKeyValues:usertostoreDic];
            [storeM addObject:usertostoreM];
        }
        
        NSDictionary *ModelDataDic = @{@"userreservationNew":reserArrayM,@"usertostore":storeM};
        [ProgressHUD dismiss];
        success(ModelDataDic);
    } fail:^(MKNetworkOperation *obj,NSError *error) {
        DLog(@"error--:%@",[error localizedDescription]);
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
    
}

#pragma mark - 搜索手机号
/**
 *  搜索手机号
 *
 *  @param paramDic 手机号和销售id
 *  @param success  成功
 *  @param fail     失败
 */
+(void)requestSearchPhoneNumaber:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/queryUsersByContact.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
                DLog(@"%@",[obj responseJSON]);
        NSDictionary *dicObj = [obj responseJSON];
        NSArray *items = [dicObj objectForKey:@"items"];
        NSMutableArray *otherSell = [NSMutableArray array];
        NSMutableArray *myselfArray = [NSMutableArray array];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        for (NSDictionary *dicItem in items) {
            NSString *status = [dicItem objectForKey:@"status"];
            if ([status isEqualToString:@"-1"]) { // 无用户
                [dataDic setObject:@[@"无用户"] forKey:@"-1"];
            } else {
                
                if ([status isEqualToString:@"1"]) { // 其他销售客户
                    NSDictionary *dicVO = [dicItem objectForKey:@"uservo"];
                    [otherSell addObject:dicVO];
                }if ([status isEqualToString:@"2"]) { // 无归属用户/自己的客户
                    NSDictionary *dicVO = [dicItem objectForKey:@"userToStoreVO"];
                    UserReservationM *userM = [[UserReservationM alloc] init];
                    [userM setKeyValues:dicVO];
                    [myselfArray addObject:userM];
                }
                if (otherSell.count) {
                    
                    [dataDic setObject:otherSell forKey:@"1"];
                }
                if (myselfArray.count) {
                    
                    [dataDic setObject:myselfArray forKey:@"2"];
                }
            }
        }
        
        success(dataDic);

    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:NO];

}



#pragma mark - 客户基本信息
+ (void)requestUserInfoWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getUser.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *userInfoDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        NSDictionary *userVOdic = [userInfoDic objectForKey:@"user"];
        UserVOModel *userVOM = [[UserVOModel alloc] init];
        [userVOM setKeyValues:userVOdic];
        NSDictionary *userExtendDic = [userInfoDic objectForKey:@"userExtend"];
        UserExtendModel *userExtendM = [[UserExtendModel alloc] init];
        [userExtendM setKeyValues:userExtendDic];
        
        NSDictionary *dicUser = @{@"user":userVOM,@"userExtend":userExtendM};
        
        success(dicUser);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:NO];


}

#pragma mark - 沟通记录
+ (void)requestCommunicationWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getUserCommunication.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
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
    
}

#pragma mark - 意向车辆
+ (void)requestUserIntentionWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService]
    requestWithApi:@"pages/sellManageAction/getUserCar.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dicCars = [obj responseJSON];
        // 搜藏车辆
        NSArray *collect = [NSArray arrayWithArray:[dicCars objectForKey:@"collect"]];
        NSMutableArray *collectCars = [NSMutableArray arrayWithCapacity:collect.count];
        for (NSDictionary *collectDic in collect) {
            CarBaseModel *collectCarM = [[CarBaseModel alloc] init];
            [collectCarM setKeyValues:collectDic];
            [collectCarM setLookORdrive:@"收藏"];
            [collectCars addObject:collectCarM];
        }
        // 预约车辆
        NSArray *readyseecar = [NSArray arrayWithArray:[dicCars objectForKey:@"readyseecar"]];
        NSMutableArray *readyseeCars = [NSMutableArray arrayWithCapacity:readyseecar.count];
        for (NSDictionary *readyseecarDic in readyseecar) {
            CarBaseModel *readyseeCarM = [[CarBaseModel alloc] init];
            [readyseeCarM setKeyValues:readyseecarDic];
            [readyseeCarM setLookORdrive:@"预约"];
            [readyseeCars addObject:readyseeCarM];
        }
        
        // 试驾 看车
        NSArray *drive = [NSArray arrayWithArray:[dicCars objectForKey:@"drive"]];
        NSArray *lookcar = [NSArray arrayWithArray:[dicCars objectForKey:@"lookcar"]];
        NSMutableArray *driveCars = [NSMutableArray arrayWithCapacity:(readyseecar.count+lookcar.count)];
        for (NSDictionary *driveDic in drive) {
            LookOrDriveCarInfoModel *driveCarM = [[LookOrDriveCarInfoModel alloc] init];
            [driveCarM setKeyValues:driveDic];
            [driveCarM setLookORdrive:@"试驾"];
            [driveCars addObject:driveCarM];
        }
        for (NSDictionary *lookcarDic in lookcar) {
            LookOrDriveCarInfoModel *lookCarM = [[LookOrDriveCarInfoModel alloc] init];
            [lookCarM setKeyValues:lookcarDic];
            [lookCarM setLookORdrive:@"看车"];
            [driveCars addObject:lookCarM];
        }
        
        // 成交车辆
        NSArray *trades = [NSArray arrayWithArray:[dicCars objectForKey:@"trades"]];
        NSMutableArray *tradesCars = [NSMutableArray arrayWithCapacity:trades.count];
        for (NSDictionary *tradesDic in trades) {
            TradeCarInfoModel *tradesCarMs = [[TradeCarInfoModel alloc] init];
            [tradesCarMs setKeyValues:tradesDic];
            [tradesCarMs setLookORdrive:@"成交"];
            [tradesCars addObject:tradesCarMs];
        }
        NSDictionary *intentionCars = @{@"collect":collectCars,@"readyseecar":readyseeCars,@"drive":driveCars,@"trades":tradesCars};
        
        success(intentionCars);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:NO];

}

#pragma mark - 我的消息
+ (void)requestMyMessageWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService]
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
}





// 上传测试
+ (void)requestUploadImage:(UIImage *)image imageIndex:(int)index success:(Success)success uploadProgress:(UploadProgress)uploadProgress fail:(Fail)fail{
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
    
}
@end
