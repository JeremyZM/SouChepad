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
#import "RequireBrandsModel.h"
#import "RequireInfoModel.h"
#import "PinYin4Objc.h"
#import "ChineseString.h"

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
                    userM.crmUserId= [dicVO objectForKey:@"phone"];
                    userM.phone = [dicVO objectForKey:@"phone"];
                    userM.user = [dicVO objectForKey:@"sellerNameShow"];
                    [otherSell addObject:userM];
                }if ([status isEqualToString:@"2"]) { // 无归属用户/自己的客户
                    NSDictionary *dicVO = [dicItem objectForKey:@"userToStoreVO"];
                    UserReservationM *userM = [[UserReservationM alloc] init];
                    [userM setKeyValues:dicVO];
                    [myselfArray addObject:userM];
                }
//                if (otherSell.count) {
                
//                }
//                if (myselfArray.count) {
                
//                }
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
        DLog(@"%@",[obj responseString]);
        if ([obj responseJSON]) {
            NSDictionary *dic = [obj responseJSON];
            [ProgressHUD showError:[dic objectForKey:@"errorMessage"]];
        }else if([obj responseString]){
//            NSString *strUrl = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *userID = [[obj responseString] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            success(userID);
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
            [ProgressHUD showError:@""];
        }
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        DLog(@"%@",obj);
    } reload:YES needHud:YES hudEnabled:YES];

}


#pragma mark - 预约客户进入接待
+ (void)requestUpdateBeginReservationById:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/updateBeginReservationById.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
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


#pragma mark - 客户需求
+ (void)requestUserRequirementInfo:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/getUserRequirementInfo.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        
        DLog(@"%@",[obj responseJSON]);
        NSDictionary *objDic = [obj responseJSON];
        // 用户需求车型列表
        NSMutableArray *reqBrandArrayM = [NSMutableArray array];
        NSArray *reqBrandsArray = [NSArray arrayWithArray:[objDic objectForKey:@"requireBrands"]];
        for (NSDictionary *reqDic in reqBrandsArray) {
            RequireBrandsModel *requBranM = [[RequireBrandsModel alloc] init];
            [requBranM setKeyValues:reqDic];
            [reqBrandArrayM addObject:requBranM];
        }
        
        // 用户 删除的 需求车型列表
        NSArray *reqDeleteBranArray = [NSArray arrayWithArray:[objDic objectForKey:@"requireBrandsDelete"]];
        NSMutableArray *reqBranDeleteArrayM = [NSMutableArray array];
        for (NSDictionary *reqDeleteDic in reqDeleteBranArray) {
            RequireBrandsModel *reqDeleteM = [[RequireBrandsModel alloc] init];
            [reqDeleteM setKeyValues:reqDeleteDic];
            [reqBranDeleteArrayM addObject:reqDeleteM];
        }
        
        // 用户基本需求
        NSDictionary *requireInfoDic = [NSDictionary dictionaryWithDictionary:[objDic objectForKey:@"requireInfo"]];
        RequireInfoModel *requireInfoModel = [[RequireInfoModel alloc] init];
        [requireInfoModel setKeyValues:requireInfoDic];
        
        
        success(@{@"requireBrands":[NSArray arrayWithArray:reqBrandArrayM],@"requireBrandsDelete":[NSArray arrayWithArray:reqBranDeleteArrayM],@"requireInfo":requireInfoModel});
        
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
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


#pragma mark - 获取所有车型
+ (void)getDictionaryByTypeAndLevel:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"pages/sellManageAction/getDictionaryByTypeAndLevel.json" parameters:paramDic success:^(MKNetworkOperation *obj) {

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dicOBJ = [obj responseJSON];
            NSArray *arr = [dicOBJ objectForKey:@"items"];
            
//            NSMutableArray *arrM = [NSMutableArray array];
//            for (NSDictionary *diccc in arr) {
//                NSString *namestr = [diccc objectForKey:@"name"];
//                
//                HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
//                [outputFormat setToneType:ToneTypeWithoutTone];
//                [outputFormat setVCharType:VCharTypeWithV];
//                [outputFormat setCaseType:CaseTypeLowercase];
//                DLog(@"%@",namestr);
//                NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:namestr withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
//                
//                DLog(@"----------%@",outputPinyin);
//                [arrM addObject:[diccc objectForKey:@"name"]];
//            }
            NSArray *carArray = [self getChineseStringArr:arr];
            
            [carArray writeToFile:KAllCarTypeData atomically:YES];
        });
        DLog(@"%@",[obj responseJSON]);
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


#pragma mark - 用户结束接待
+ (void)requestUserOutStore:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail
{
    [[HttpService sharedService] requestWithApi:@"/pages/sellManageAction/userOutStore.json" parameters:paramDic success:^(MKNetworkOperation *obj) {
        DLog(@"%@",[obj responseJSON]);
        success([obj responseJSON]);
    } fail:^(MKNetworkOperation *obj, NSError *error) {
        
    } reload:YES needHud:YES hudEnabled:YES];
    
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
