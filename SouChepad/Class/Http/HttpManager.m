//
//  NetworkManager.m
//  MyMKNetwork
//
//  Created by zt on 14-4-16.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "HttpManager.h"
#import "HttpService.h"
#import "ProgressHUD.h"
#import "UserReservationM.h"
#import "NSObject+MJKeyValue.h"
#import "CommunListM.h"
#import "SystermMessage.h"
#import "CarBaseModel.h"
#import "TradeCarInfoModel.h"
#import "LookOrDriveCarInfoModel.h"
#import "BaseDtaModel.h"
#import "UserExtendModel.h"
#import "UserVOModel.h"
#import "SellInfoModel.h"
#import "RequireBrandsModel.h"
#import "RequireInfoModel.h"
#import "PinYin4Objc.h"
#import "ChineseString.h"
#import "UsertoStore.h"
#import "UserOperationRecordVO.h"
#import "DriveCarLastData.h"
#import "MyMessage.h"
#import "BusinessVO.h"
#import "AuthShopVO.h"
#import "CarOrderVO.h"

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

        [dic writeToFile:KallListData atomically:YES];

        NSArray *keyArray = [dic allKeys];
        for (NSString *keyStr in keyArray) {
            if ([keyStr isEqualToString:@"errorMessage"]) return;
            [[dic objectForKey:keyStr] writeToFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",keyStr]] atomically:YES];

        }
       
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:NO hudEnabled:NO];

}


#pragma mark - 获取所有省市城市
+ (void)getDictionaryByAllCityTypeAndLevel:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getDictionaryByTypeAndLevel.json" parameters:@{@"type":@"area",@"level":@"province",@"nextlevel":@"city"} success:^(MKNetworkOperation *obj) {
        NSDictionary *allCity = [obj responseJSON];
        NSArray *citysArray = [allCity objectForKey:@"items"];
        [citysArray writeToFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"allCitys.plist"] atomically:YES];
//        allCity writeToFile:<#(NSString *)#> atomically:<#(BOOL)#>
        DLog(@"%@",[obj responseJSON]);
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
        DLog(@"obj---%@",obj );
        NSDictionary *login = [obj responseJSON];
       
        success(login);
    } fail:^(MKNetworkOperation *obj,NSError*error) {
        DLog(@"errer---%@",[error localizedDescription]);
        fail(obj);
    } reload:YES needHud:YES hudEnabled:YES];
    
}

#pragma mark - 搜索所有客户
+(void)requestClientWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    NSString *url = @"pages/sellManageAction/sellToUser.json";
        [[HttpService sharedService] requestWithApi:url parameters:paramDic success:^(MKNetworkOperation *obj) {
            [ProgressHUD show:nil];
            DLog(@"obj--:%@",[obj responseJSON]);
            NSDictionary *dataDic = [obj responseJSON];
            NSDictionary *sellDic = [dataDic objectForKey:@"sell"];
            SellInfoModel *sellInfoM = [[SellInfoModel alloc] init];
            if (![sellDic isKindOfClass:[NSNull class]]) {
                [sellInfoM setKeyValues:sellDic];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.nickName forKey:KSellName];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.email forKey:KSellEmail];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.phone forKey:KSellPhone];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.address forKey:KSellAddressName];
            [[NSUserDefaults standardUserDefaults] setObject:sellInfoM.qq forKey:KSellQQ];
            [UserDefaults synchronize];
            
        NSMutableArray *reserArrayM = [NSMutableArray array];
            
        // 正在接待中...
        NSArray *userreservationInHand = [NSArray arrayWithArray:[dataDic objectForKey:@"userreservationInHand"]];
        for (NSDictionary *userReserDic in userreservationInHand) {
            UserReservationM *userReserM = [[UserReservationM alloc] init];
            [userReserM setKeyValues:userReserDic];
//            [userReserM setInHand:YES];
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

#pragma mark - 客户列表上拉加载更多
+(void)getOldUserParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/getOldUser.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if (![dataDic objectForKey:@"errorMessage"]) {
            UsertoStore *userStore = [[UsertoStore alloc] init];
            [userStore setKeyValues:dataDic];
            NSArray *usersArray = [dataDic objectForKey:@"users"];
            NSMutableArray *userArrayM = [NSMutableArray array];
            
            for (NSDictionary *user in usersArray) {
                UserReservationM *userReserM = [[UserReservationM alloc] init];
                [userReserM setKeyValues:user];
                [userArrayM addObject:userReserM];
            }
            [userStore setUsersArray:userArrayM];
            success(userStore);
        } else {
            [ProgressHUD showError:[dataDic objectForKey:@"errorMessage"]];
        }
    } fail:^(MKNetworkOperation *obj, NSError *error) {

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
        NSMutableArray *newArray = [NSMutableArray array];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        for (NSDictionary *dicItem in items) {
            NSString *status = [dicItem objectForKey:@"status"];
            if ([status isEqualToString:@"-1"]) { // 无用户
                UserReservationM *userM = [[UserReservationM alloc] init];
                [newArray addObject:userM];
//                [dataDic setObject:@[@"新客户"] forKey:@"-1"];
            } else {
                
                if ([status isEqualToString:@"1"]) { // 其他销售客户
                    NSDictionary *dicVO = [dicItem objectForKey:@"uservo"];
                    UserReservationM *userM = [[UserReservationM alloc] init];
                    userM.crmUserId= [dicVO objectForKey:@"id"];
                    userM.phone = [dicVO objectForKey:@"phone"];
                    userM.user = [dicVO objectForKey:@"sellerNameShow"];
                    [otherSell addObject:userM];
                }if ([status isEqualToString:@"2"]) { // 无归属用户/自己的客户
                    NSDictionary *dicVO = [dicItem objectForKey:@"userToStoreVO"];
                    UserReservationM *userM = [[UserReservationM alloc] init];
                    [userM setKeyValues:dicVO];
                    [myselfArray addObject:userM];
                }
            }
            
        }
        [dataDic setObject:newArray forKey:@"-1"];
        [dataDic setObject:otherSell forKey:@"1"];
        [dataDic setObject:myselfArray forKey:@"2"];
        success(dataDic);

    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:NO];

}

#pragma mark - 修改用户个人信息////创建无号码用户
+ (void)requestUpdtaeUser:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateUser.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dic = [obj responseJSON];
        if ([dic objectForKey:@"errorMessage"]) {
            [ProgressHUD showError:[dic objectForKey:@"errorMessage"]];
        }else if([dic objectForKey:@"userId"]){

            success([dic objectForKey:@"userId"]);
            [ProgressHUD showSuccess:@"信息保存成功"];
        }
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];
}


#pragma mark - 用户信息进入接待
+ (void)requestUpdateBeginReservationByUser:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateBeginReservationByUser.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",obj);
        NSDictionary *dic = [obj responseJSON];
        if ([dic objectForKey:@"succeedMessage"]) {
            
            success([obj responseJSON]);
        }else{
            [ProgressHUD showError:[dic objectForKey:@"errorMessage"]];
        }
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        DLog(@"%@",obj);
        fail(nil);
    } reload:YES needHud:YES hudEnabled:YES];

}


#pragma mark - 预约客户进入接待
+ (void)requestUpdateBeginReservationById:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateBeginReservationById.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(nil);
    } reload:YES needHud:YES hudEnabled:YES];
}

#pragma mark - 客户基本信息
+ (void)requestUserInfoWithParamDic:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getUser.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *userInfoDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        NSDictionary *userVOdic = [userInfoDic objectForKey:@"user"];
        UserVOModel *userVOM = [[UserVOModel alloc] init];
        if (![userVOdic isKindOfClass:[NSNull class]])
        {
            
            [userVOM setKeyValues:userVOdic];
        }
        NSDictionary *userExtendDic = [userInfoDic objectForKey:@"userExtend"];
        
        UserExtendModel *userExtendM = [[UserExtendModel alloc] init];
        if (![userExtendDic isKindOfClass:[NSNull class]]) {
            [userExtendM setKeyValues:userExtendDic];
        }
        
        NSDictionary *dicUser = @{@"user":userVOM,@"userExtend":userExtendM};
        
        success(dicUser);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 根据vin码获取车辆的ID
+ (void)getCarInVin:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/getCarInVin.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dicObj = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([dicObj objectForKey:@"carId"]) {
            success ([dicObj objectForKey:@"carId"]);
        }else {
            [ProgressHUD showError:@"未找到该车辆信息"];
        }
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        [ProgressHUD showError:@"暂无"];
    } reload:YES needHud:YES hudEnabled:YES];
}

#pragma mark - 销售修改预约到店时间
+ (void)requestUpdateReservationDate:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateReservationDate.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *messageDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        success(messageDic);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:YES];
}

#pragma mark - 销售修改预约到店时间（填写沟通）
+ (void)requestUpdateReservationDateByUser:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateReservationDateByUser.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",obj);
        NSDictionary *messageDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        success(messageDic);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:YES];
    
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
        NSDictionary *dicCars = [obj responseJSON];
        // 成交车辆
        NSArray *trades = [NSArray arrayWithArray:[dicCars objectForKey:@"trades"]];
        NSMutableArray *tradesCars = [NSMutableArray arrayWithCapacity:trades.count];
        for (NSDictionary *tradesDic in trades) {
            TradeCarInfoModel *tradesCarMs = [[TradeCarInfoModel alloc] init];
            [tradesCarMs setKeyValues:tradesDic];
            [tradesCarMs setLookORdrive:@"成交"];
            [tradesCars addObject:tradesCarMs];
        }

        // 搜藏车辆
        NSArray *collect = [NSArray arrayWithArray:[dicCars objectForKey:@"collect"]];
        NSMutableArray *collectCars = [NSMutableArray arrayWithCapacity:collect.count];
        for (NSDictionary *collectDic in collect) {
            BOOL needAdd = YES;//标记是否需要加入搜藏数组
            // 过滤成交车辆
            for (TradeCarInfoModel *trade in tradesCars) {
                if ([trade.carId isEqualToString:DicValueForKey(collectDic, nil, @"carId")]) {
                    needAdd = NO;
                    break;
                }
            }
            // 不需要加入搜藏数组
            if (needAdd == NO) {
                continue;
            }
            
            CarBaseModel *collectCarM = [[CarBaseModel alloc] init];
            [collectCarM setKeyValues:collectDic];
            collectCarM.image =  DicValueForKey(collectDic, nil, @"imageURL");
            [collectCarM setLookORdrive:DicValueForKey(collectDic, @"预约", @"source")];
            [collectCars addObject:collectCarM];
        }
        // 预约车辆
        NSArray *readyseecar = [NSArray arrayWithArray:DicValueForKey(dicCars, nil, @"readyseecar")];
        NSMutableArray *readyseeCars = [NSMutableArray arrayWithCapacity:readyseecar.count];
        for (NSDictionary *readyseecarDic in readyseecar) {
            CarBaseModel *readyseeCarM = [[CarBaseModel alloc] init];
            [readyseeCarM setKeyValues:readyseecarDic];
            readyseeCarM.image =  DicValueForKey(readyseecarDic, nil, @"imageURL");
            [readyseeCarM setLookORdrive:@"预约"];
            [readyseeCars addObject:readyseeCarM];
        }
        
        NSDictionary *intentionCars = @{@"collect":collectCars,@"readyseecar":readyseeCars,@"trades":tradesCars};
        
        success(intentionCars);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
    } reload:YES needHud:YES hudEnabled:NO];

}


#pragma mark - 客户需求
+ (void)requestUserRequirementInfo:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/getUserRequirementInfo.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *objDic = [obj responseJSON];
        if ([objDic objectForKey:@"errorMessage"]) {
            [ProgressHUD showError:[objDic objectForKey:@"errorMessage"]];
            return ;
        }
        // 用户需求车型列表
        NSMutableArray *reqBrandArrayM = [NSMutableArray array];
        NSArray *reqBrandsArray = [NSArray arrayWithArray:[objDic objectForKey:@"requireBrands"]];
        
        for (NSDictionary *reqDic in reqBrandsArray) {
            NSMutableDictionary *dataReqDic = [NSMutableDictionary dictionaryWithDictionary:reqDic];
            if ([dataReqDic objectForKey:@"id"]) {
                [dataReqDic setObject:[dataReqDic objectForKey:@"id"] forKey:@"_id"];
                [dataReqDic removeObjectForKey:@"id"];
//                break;
            }

            RequireBrandsModel *requBranM = [[RequireBrandsModel alloc] init];
            [requBranM setKeyValues:dataReqDic];
            [reqBrandArrayM addObject:requBranM];
        }
        
        // 用户 删除的 需求车型列表
        NSArray *reqDeleteBranArray = [NSArray arrayWithArray:[objDic objectForKey:@"requireBrandsDelete"]];
        NSMutableArray *reqBranDeleteArrayM = [NSMutableArray array];
        for (NSDictionary *reqDeleteDic in reqDeleteBranArray) {
            
            NSMutableDictionary *dataReqDic = [NSMutableDictionary dictionaryWithDictionary:reqDeleteDic];
            if ([dataReqDic objectForKey:@"id"]) {
                [dataReqDic setObject:[dataReqDic objectForKey:@"id"] forKey:@"_id"];
                [dataReqDic removeObjectForKey:@"id"];
//                break;
            }

            RequireBrandsModel *reqDeleteM = [[RequireBrandsModel alloc] init];
            [reqDeleteM setKeyValues:dataReqDic];
            [reqBranDeleteArrayM addObject:reqDeleteM];
        }
        
        // 用户基本需求
        NSDictionary *requireInfoDic ;
        if (![[objDic objectForKey:@"requireInfo"] isKindOfClass:[NSNull class]]) {
            requireInfoDic = [NSDictionary dictionaryWithDictionary:[objDic objectForKey:@"requireInfo"]];
        }
        RequireInfoModel *requireInfoModel = [[RequireInfoModel alloc] init];
        [requireInfoModel setKeyValues:requireInfoDic];
        
        
        success(@{@"requireBrands":[NSArray arrayWithArray:reqBrandArrayM],@"requireBrandsDelete":[NSArray arrayWithArray:reqBranDeleteArrayM],@"requireInfo":requireInfoModel,@"number":[NSString stringWithFormat:@"%@",[objDic objectForKey:@"number"]]});
        
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 更新客户基本需求
+ (void)updateUserRequirementInfo:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateUserRequirementInfo.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([dic objectForKey:@"errorMessage"]) {
            [ProgressHUD showError:[dic objectForKey:@"errorMessage"]];
            return ;
        }

        success (dic);
        DLog(@"%@",[obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];
}

#pragma mark - 匹配车辆精准
+ (void)queryUserRequirementInfoCarZJ:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    NSString *api = nil;
    // 按品牌查找
    if ([paramDic objectForKey:@"requirementBrandId"]) {
        api = @"/pages/sellManageAction/queryUserRequirementBrandCar.json";
    }else{
        // 查找所有
        api = @"/pages/sellManageAction/queryUserRequirementInfoCar.json";
    }
    [[HttpService sharedService] requestWithApi:api parameters:paramDic success:^(MKNetworkOperation *obj) {
        NSMutableDictionary *dicobj = [NSMutableDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([dicobj objectForKey:@"errorMessage"]) {
            [ProgressHUD showError:[dicobj objectForKey:@"errorMessage"]];
            return;
        }
        
        NSArray *carArray = [dicobj objectForKey:@"items"];
        NSMutableArray *carArrayM = [NSMutableArray array];
        if (carArray.count) {
            for (NSDictionary *carDic in carArray) {
                CarBaseModel *carModel = [[CarBaseModel alloc] init];
                [carModel setKeyValues:carDic];
                [carModel setImage:DicValueForKey(carDic, nil, @"imageURL")];
                [carArrayM addObject:carModel];
            }
        }
        [dicobj setObject:carArrayM forKey:@"jz"];
        success (dicobj);
        
        DLog(@"%@",[obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {

        fail(error);
        
    } reload:YES needHud:YES hudEnabled:NO];
}


#pragma mark - 需求分析，匹配车辆
+ (void)queryUserRequirementInfoCarMH:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    NSString *api = nil;
    if ([paramDic objectForKey:@"requirementBrandId"]) {
        api = @"/pages/sellManageAction/queryUserRequirementBrandCarMH.json";
    }else {
        api = @"/pages/sellManageAction/queryUserRequirementInfoCarMH.json";
    }
    
    [[HttpService sharedService] requestWithApi:api parameters:paramDic success:^(MKNetworkOperation *obj) {
        NSDictionary *dicobj = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([dicobj objectForKey:@"errorMessage"]) {
            [ProgressHUD showError:[dicobj objectForKey:@"errorMessage"]];
            return;
        }
        NSArray *dataArray = [dicobj objectForKey:@"mh"];
        NSMutableArray *mhCarArrayM = [NSMutableArray array];
        for (NSDictionary *mhCarDic in dataArray) {
            CarBaseModel *carM = [[CarBaseModel alloc] init];
            [carM setKeyValues:mhCarDic];
            [carM setImage:DicValueForKey(mhCarDic, nil, @"imageURL")];
            [mhCarArrayM addObject:carM];
        }
        success(mhCarArrayM);
        DLog(@"%@",[obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail (error);
    } reload:YES needHud:YES hudEnabled:NO];
}


//#pragma mark - 品牌需求匹配车辆精准
//+ (void)queryUserRequirementBrandCarZJ:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
//{
//    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/queryUserRequirementBrandCarJZ.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
//        DLog(@"%@",[obj responseJSON]);
//    } fail:^(MKNetworkOperation *obj, NSError *error) {
//
//    } reload:YES needHud:YES hudEnabled:NO];
//}
//
//#pragma mark - 品牌需求匹配车辆模糊
//+ (void)queryUserRequirementBrandCarMH:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
//{
//    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/queryUserRequirementBrandCarMH.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
//        DLog(@"%@",[obj responseJSON]);
//    } fail:^(MKNetworkOperation *obj, NSError *error) {
//        
//    } reload:YES needHud:YES hudEnabled:NO];
//}

#pragma mark - 最后一条看车记录
+ (void)lastCarLookOrDrive:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/lastCarLookOrDrive.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        NSDictionary *vo = [dataDic objectForKey:@"vo"];
        UserOperationRecordVO *userOperVO = [[UserOperationRecordVO alloc] init];
        if ([vo isKindOfClass:[NSDictionary class]]) {
            
            [userOperVO setKeyValues:vo];
        }
        if ([[dataDic objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            
            [userOperVO setName:[dataDic objectForKey:@"name"]];
        }
        if ([[dataDic objectForKey:@"salerPrice"] isKindOfClass:[NSString class]]) {
            [userOperVO setSalerPrice:[dataDic objectForKey:@"salerPrice"]];
        }
        success(userOperVO);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:NO];

}



#pragma mark - 保存看车记录
+ (void)saveLookCarRecord:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/saveLookCar.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        
        NSDictionary *objDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([objDic objectForKey:@"succeedMessage"]) {
            success(objDic);
        }else{
            [ProgressHUD showError:[objDic objectForKey:@"errorMessage"]];
        }
        DLog(@"%@",[obj responseJSON]);
        
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];
}



#pragma mark - 最后一条试驾记录
+ (void)lastUserDriveCarByData:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/lastUserDriveCarByData.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        DriveCarLastData *driveCarM = [[DriveCarLastData alloc] init];
        if ([obj responseJSON]) {
            
            [driveCarM setKeyValues:dataDic];
        }
        success(driveCarM);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:NO];
    
}

#pragma mark - 保存并开始试驾
+ (void)saveDriveCarBegin:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/saveDriveCarBegin.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([dic objectForKey:@"succeedMessage"]) {
            success(dic);
        }else {
            [ProgressHUD showError:[dic objectForKey:@"errorMessage"]];
        }
        DLog(@"%@",[obj responseJSON]);
        
    } fail:^(MKNetworkOperation *obj, NSError *error) {

    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 结束试驾
+ (void)saveDriveCarEnd:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/saveDriveCarEnd.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([dic objectForKey:@"succeedMessage"]) {
            success(dic);
        }else {
            [ProgressHUD showError:[dic objectForKey:@"errorMessage"]];
        }
        DLog(@"%@",[obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];


}


#pragma mark - 添加客户意向车型
+ (void)updateUserRequirementBrand:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateUserRequirementBrand.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];

}


#pragma mark - 删除客户需求品牌车系
+ (void)delUserRequirementInfoBrand:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/delUserRequirementInfoBrand.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];

}


#pragma mark - 我的消息
+ (void)requestMyMessageWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    NSString *api = @"pages/sellManageAction/getSalerMessageByType.json";
    [[HttpService sharedService]
                              requestWithApi:api parameters:paramDic success:^(MKNetworkOperation *obj) {
                                  DLog(@"%@",[obj responseJSON]);
                                  NSDictionary *dataDic = [obj responseJSON];
                                  NSArray *array = [dataDic objectForKey:@"salerMessage"];
                                  NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
                                  for (NSDictionary *dic in array) {
                                      MyMessage *myMessage = [[MyMessage alloc] init];
                                      [myMessage setKeyValues:dic];
                                      [arrayM addObject:myMessage];
                                  }
                                  success(arrayM);
                              } fail:^(MKNetworkOperation *obj, NSError *error) {
                                  fail([error localizedDescription]);
                              } reload:YES needHud:NO hudEnabled:NO];
}

#pragma mark - 我的消息（销售）标记为已读
+ (void)requestMarkMyMessageAsReadWithDic:(NSDictionary*)paramDic{
    NSString *api = @"pages/sellManageAction/updateSalerMessageIsRead.json";
    [[HttpService sharedService]
     requestWithApi:api parameters:paramDic success:^(MKNetworkOperation *obj) {
         DLog(@"我的消息 标记为已读:%@",obj);
     }fail:^(MKNetworkOperation *obj, NSError *error) {
         DLog(@"我的消息 标记失败:%@",error);
     } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark -  获取系统消息
+ (void)requestSystermMessage:(NSDictionary*)dic Success:(Success)success fail:(Fail)fail{
    NSString *api = @"pages/sellManageAction/getSellHint.json";
    [[HttpService sharedService] requestWithApi:api parameters:dic success:^(MKNetworkOperation *obj) {
            DLog(@"%@",[obj responseJSON]);
            NSDictionary *dataDic = [obj responseJSON];
            NSArray *array = [dataDic objectForKey:@"baseHint"];
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dic in array) {
                SystermMessage *myMessage = [[SystermMessage alloc] init];
                [myMessage setKeyValues:dic];
                [arrayM addObject:myMessage];
            }
            success(arrayM);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:NO hudEnabled:NO];
}

#pragma mark - 系统消息标记为已读
+ (void)requestMarkSystermMessageAsReadWithDic:(NSDictionary*)paramDic{
    NSString *api = @"pages/sellManageAction/saveReadHint.json";
    [[HttpService sharedService]
     requestWithApi:api parameters:paramDic success:^(MKNetworkOperation *obj) {
         
     }fail:^(MKNetworkOperation *obj, NSError *error) {
         
     } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 获取所有车型
+ (void)getDictionaryByTypeAndLevel:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getDictionaryByTypeAndLevel.json" parameters:paramDic success:^(MKNetworkOperation *obj) {

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dicOBJ = [obj responseJSON];
            NSArray *arr = [dicOBJ objectForKey:@"items"];
            NSArray *carArray = [self getChineseStringArr:arr];
            
            [carArray writeToFile:KAllCarTypeData atomically:YES];
        });
//        DLog(@"%@",[obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail([error localizedDescription]);
        DLog(@"%@",[error localizedDescription]);
    } reload:YES needHud:NO hudEnabled:NO];
}


+ (NSMutableArray *)getChineseStringArr:(NSArray *)arrToSort {
    
    NSMutableArray *_sectionHeadsKeys = [NSMutableArray array];
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++) {
        ChineseString *chineseString=[[ChineseString alloc]init];
        NSDictionary *dicc = [arrToSort objectAtIndex:i];
        chineseString.string=[NSString stringWithString:[dicc objectForKey:@"name"]];
        chineseString.dic = dicc;
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            //join the pinYin
            NSString *pinYinResult = [NSString string];
            HanyuPinyinOutputFormat *format = [[HanyuPinyinOutputFormat alloc] init];
            
            NSString *nameStr = [[PinyinHelper toHanyuPinyinStringWithNSString:chineseString.string  withHanyuPinyinOutputFormat:format withNSString:@""] uppercaseString];
            for(int j = 0;j < nameStr.length; j++) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",[nameStr characterAtIndex:j]] uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin = pinYinResult;
        } else {
            chineseString.pinYin = @"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex= NO;  //flag to check
    NSMutableArray *TempArrForGrouping = nil;
    
    for(int index = 0; index < [chineseStringsArray count]; index++)
    {
        ChineseString *chineseStr = (ChineseString *)[chineseStringsArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr= [strchar substringToIndex:1];
        //sr containing here the first character of each string
        if(![_sectionHeadsKeys containsObject:[sr uppercaseString]])//here I'm checking whether the character already in the selection header keys or not
        {
            [_sectionHeadsKeys addObject:[sr uppercaseString]];
            TempArrForGrouping = [[NSMutableArray alloc] initWithObjects:nil];
            checkValueAtIndex = NO;
        }
        if([_sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:chineseStr.dic];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:@{@"key":sr,@"car":TempArrForGrouping}];
                checkValueAtIndex = YES;
            }
        }
    }
    return arrayForArrays;
}


#pragma mark - 用户强合并
+ (void)requestUserHandleByType:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/userHandleByType.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",obj);
        NSDictionary *objDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([objDic objectForKey:@"userId"]) {

            success([objDic objectForKey:@"userId"]);
        }else{
            [ProgressHUD showError:[objDic objectForKey:@"errorMessage"]];
        }

    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];
}

#pragma mark - 用户结束接待
+ (void)requestUserOutStore:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/userOutStore.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *objDic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        if ([objDic objectForKey:@"errorMessage"]) {

            [ProgressHUD showError:[objDic objectForKey:@"errorMessage"]];
        }else{
            success([obj responseJSON]);
        }

    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];
}


#pragma mark - 修改销售个人信息
+ (void)updateSellerData:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateSellerData.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
        [ProgressHUD showSuccess:@""];
    } fail:^(MKNetworkOperation *obj, NSError *error) {

    } reload:YES needHud:YES hudEnabled:YES];
}


#pragma mark - 修改密码
+ (void)updatePassword:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updatePassword.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        
        success(dic);
        DLog(@"%@",[obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];

}


#pragma 图片上传url
+ (void)upImageURL:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/upImage.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dic = [obj responseJSON];
        
        success (dic);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
        fail(error);
    } reload:YES needHud:NO hudEnabled:NO];

}


#pragma mark - 退出登录
+ (void)requestLogout{
    NSString *api = @"/pages/sellManageAction/logout.json";
    NSDictionary *dic = @{@"userName":[UserDefaults objectForKey:userDefaultsName]};
    [[HttpService sharedService] requestWithApi:api parameters:dic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];
}

// 上传测试
+ (void)requestUploadImage:(UIImage *)image imageIndex:(int)index success:(Success)success uploadProgress:(UploadProgress)uploadProgress fail:(Fail)fail{
    NSString *path = @"pages/carUpImageAction/uploadImage.upload";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d", index] forKey:@"pic"];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    DLog(@"%u",data.length/1024);

//    NSData *dataaa = UIImagePNGRepresentation(image);
//    DLog(@"%ld",(unsigned long)dataaa.length);
    
    
    MKNetworkOperation *op = [[HttpService sharedService] requestUploadFile:data
                                                                        api:path
                                                                      paras:dic];
    // 上传
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        NSDictionary *xmlString = [completedOperation responseJSON];
        DLog(@"%@", xmlString);
        success(xmlString);
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        DLog(@"%@=====%@",errorOp,error);
        fail(error);
    }];
    
    // 进度
    [op onUploadProgressChanged:^(double progress) {
        NSString *strProgress = [NSString stringWithFormat:@"%.0f", progress*100.0];
//        DLog(@"Upload file progress: %f", progress);
        uploadProgress(strProgress);
    }];
    
    [[HttpService sharedService] enqueueOperation:op];
    
}

#pragma mark - 查看某一个客户是否回访
+ (void)userCanVisit:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/canVisit.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 修改/添加沟通回访日期
+ (void)addOrUpdateVisit:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/addOrUpdateVisit.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 查看所有需要回访客户
+ (void)getAllVistors:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getVistorsBySaler.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[obj responseJSON]];
        NSArray *items = [dic objectForKey:@"items"];
        NSMutableArray *itemsArrayM = [NSMutableArray arrayWithCapacity:items.count];
        for (NSDictionary *itemDic in items) {
            NSArray *keysArray = [itemDic allKeys];
            for (NSInteger i = 0; i<keysArray.count; i++) {
                if ([[itemDic objectForKey:keysArray[i]] isKindOfClass:[NSNull class]]) {

                    
                }
            }
            NSDictionary *userv = [itemDic objectForKey:@"user"];
            UserVOModel *userVo = [[UserVOModel alloc] init];
            if (![userv isKindOfClass:[NSNull class]]) {
                
                [userVo setKeyValues:userv];
            }
            if (![[itemDic objectForKey:@"visit_time"] isKindOfClass:[NSNull class]]) {
                [userVo setVisit_time:[itemDic objectForKey:@"visit_time"]];
            }
            if (![[itemDic objectForKey:@"userid"] isKindOfClass:[NSNull class]]) {
                
                [userVo setUserid:[itemDic objectForKey:@"userid"]];
            }
            if (![[itemDic objectForKey:@"userStatusName"] isKindOfClass:[NSNull class]]) {
                
                [userVo setUserStatusName:[itemDic objectForKey:@"userStatusName"]];
            }
            [itemsArrayM addObject:userVo];
        }
        
        success(itemsArrayM);
        
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 关闭回访
+ (void)closeVisit:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/closeVisit.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 下订单
+ (void)createOrderWith:(NSDictionary *)dic Success:(Success)success fail:(Fail)fail{
    // [keyStr isEqualToString:@"errorMessage"]
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/createOrder.json" parameters:dic success:^(MKNetworkOperation *obj) {
        [ProgressHUD showSuccess:@"下订单成功"];
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 订单详情
+ (void)requestOrderDetailWithOrderid:(NSString*)orderid success:(Success)success fail:(Fail)fail{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/orderDetail.json" parameters:@{@"orderid": orderid} success:^(MKNetworkOperation *obj) {
        DLog(@"order detail:%@", obj.responseJSON);
        NSDictionary *dic = obj.responseJSON;
        if (dic == nil || [dic isKindOfClass:[NSNull class]]) {
            success(nil);
        }else{
            CarOrderVO *vo = [CarOrderVO new];
            [vo setKeyValues:dic];
            success(vo);
        }
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 完成订单
+(void)requestConfirmOrder:(NSDictionary*)dic success:(Success)success fail:(Fail)fail{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/confirmOrder.json" parameters:dic success:^(MKNetworkOperation *obj) {
        [ProgressHUD showSuccess:@"订单完成"];
        success(nil);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        fail(error);
    } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 获取商机
+ (void)requestBusinessInfoSuccess:(Success)success fail:(Fail)fail{
    [[HttpService sharedService] requestWithApi:@"pages/salerBusinessAction/querySellBusinessOnIpad.json"
                                     parameters:NULL
                                        success:^(MKNetworkOperation *obj) {
                                            NSMutableArray *array = [NSMutableArray array];
                                            for (NSDictionary *dic in [[obj responseJSON] objectForKey:@"items"]) {
                                                BusinessVO *vo = [BusinessVO new];
                                                [vo setKeyValues:[dic objectForKey:@"crmUserSellBusinessVO"]];
                                                vo.tags = [dic objectForKey:@"tagsName"];
                                                [array addObject:vo];
                                            }
                                            success(array);
                                        } fail:^(MKNetworkOperation *obj, NSError *error) {
                                            fail(error);
                                        } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 删除商机
+ (void)requestDeleteBusinessWithid:(NSString*)businessId success:(Success)success fail:(Fail)fail{
    [[HttpService sharedService] requestWithApi:@"pages/salerBusinessAction/deleteSellBusiness.json"
                                     parameters:@{@"SellBusinessId": businessId}
                                        success:^(MKNetworkOperation *obj) {
                                            success(nil);
                                        } fail:^(MKNetworkOperation *obj, NSError *error) {
                                            fail(error);
                                        } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 根据用户id获取用户最新的一条预约记录
+(void)requestLastUserReservationStoreWithId:(NSString*)userid success:(Success)success fail:(Fail)fail{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getUserLastUserReservationStore.json"
                                     parameters:@{@"userid": userid}
                                        success:^(MKNetworkOperation *obj) {
                                            UserReservationM *vo = [UserReservationM new];
                                            [vo setKeyValues:obj.responseJSON];
                                            success(obj);
                                        } fail:^(MKNetworkOperation *obj, NSError *error) {
                                            fail(error);
                                        } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 获取授权店信息
+ (void)requestAuthShoInfoSuccess:(Success)success fail:(Fail)fail{
    [[HttpService sharedService] requestWithApi:@"pages/paikeAction/getAuthShopInfo.json"
                                     parameters:nil
                                        success:^(MKNetworkOperation *obj) {
                                            AuthShopVO *vo = [AuthShopVO new];
                                            [vo setKeyValues:obj.responseJSON];
                                            success(vo);
                                        } fail:^(MKNetworkOperation *obj, NSError *error) {
                                            fail(error);
                                        } reload:YES needHud:YES hudEnabled:NO];
}

#pragma mark - 通过微信url获取carid
+ (void)requestCaridWithWeixinURL:(NSString*)url success:(Success)success fail:(Fail)fail{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"wx.souche.com"];
    NSDictionary *dic = @{@"url": url};
    NSString *api = @"api/qrcode/getCarId.do";
    MKNetworkOperation *operation = [engine operationWithPath:api
                                                       params:dic httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *messeage  = DicValueForKey(completedOperation.responseJSON, nil, @"msg");
        if ([messeage isEqualToString:@"OK"]) {
            NSString *carid = DicValueForKey(completedOperation.responseJSON, nil, @"carId");
            success(carid);
        }else{
            [ProgressHUD showError:messeage];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [ProgressHUD showError:FormatStr(@"%@",error)];
    }];
    [[HttpService sharedService] formatUrlAndParameters:dic path:api];
    [engine enqueueOperation:operation forceReload:NO];
}
@end
