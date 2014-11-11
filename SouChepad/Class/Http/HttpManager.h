//
//  NetworkManager.h
//  MyMKNetwork
//
//  Created by zt on 14-4-16.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKNetworkOperation;

typedef void (^Success) (id obj);
typedef void (^Fail) (id obj);
typedef void (^UploadProgress)(NSString *progress);

@interface HttpManager : NSObject

// 取消网络请求
+ (void)cancelRequest:(MKNetworkOperation*)operation;

#pragma mark - 获取各评价list
+ (void)getDictionarySuccess:(Success)success fail:(Fail)fail;

#pragma mark - 获取所有省市城市
+ (void)getDictionaryByAllCityTypeAndLevel:(Success)success fail:(Fail)fail;


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

#pragma mark - 更新客户基本需求
+ (void)updateUserRequirementInfo:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 匹配车辆精准
+ (void)queryUserRequirementInfoCarZJ:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 匹配模糊车辆
+ (void)queryUserRequirementInfoCarMH:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


//#pragma mark - 品牌需求匹配车辆精准
//+ (void)queryUserRequirementBrandCarZJ:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;
//
//#pragma mark - 品牌需求匹配车辆模糊
//+ (void)queryUserRequirementBrandCarMH:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 最后一条看车记录
+ (void)lastCarLookOrDrive:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 保存看车记录
+ (void)saveLookCarRecord:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 最后一条试驾记录
+ (void)lastUserDriveCarByData:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 保存并开始试驾
+ (void)saveDriveCarBegin:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 结束试驾
+ (void)saveDriveCarEnd:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 添加客户意向车型
+ (void)updateUserRequirementBrand:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 删除客户需求品牌车系
+ (void)delUserRequirementInfoBrand:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;


#pragma mark - 我的消息
+ (void)requestMyMessageWithParamDic:(NSDictionary *)paramDic Success:(Success)success fail:(Fail)fail;
#pragma mark - 我的消息（销售）标记为已读
+ (void)requestMarkMyMessageAsReadWithDic:(NSDictionary*)paramDic;

#pragma mark -和系统消息
+ (void)requestSystermMessage:(NSDictionary*)dic Success:(Success)success fail:(Fail)fail;
#pragma mark - 系统消息标记为已读
+ (void)requestMarkSystermMessageAsReadWithDic:(NSDictionary*)paramDic;

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

#pragma 图片上传url
+ (void)upImageURL:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 退出登录
+ (void)requestLogout;

// 上传图片，成功后返回dictionary
+ (void)requestUploadImage:(UIImage *)image imageIndex:(int)index success:(Success)success uploadProgress:(UploadProgress)uploadProgress fail:(Fail)fail;

#pragma mark - 查看某一个客户是否回访
+ (void)userCanVisit:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 修改/添加回访日期
+ (void)addOrUpdateVisit:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 查看所有需要回访客户
+ (void)getAllVistors:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 关闭回访
+ (void)closeVisit:(NSDictionary*)paramDic Success:(Success)success fail:(Fail)fail;

#pragma mark - 下订单
+(void)createOrderWith:(NSDictionary*)dic Success:(Success)success fail:(Fail)fail;
#pragma mark - 订单详情
+ (void)requestOrderDetailWithOrderid:(NSString*)orderid success:(Success)success fail:(Fail)fail;
#pragma mark - 完成订单
+(void)requestConfirmOrder:(NSDictionary*)dic success:(Success)success fail:(Fail)fail;
#pragma mark - 获取商机
+ (void)requestBusinessInfoSuccess:(Success)success fail:(Fail)fail;
#pragma mark - 删除商机
+ (void)requestDeleteBusinessWithid:(NSString*)businessId success:(Success)success fail:(Fail)fail;
#pragma mark - 根据用户id获取用户最新的一条预约记录
+(void)requestLastUserReservationStoreWithId:(NSString*)userid success:(Success)success fail:(Fail)fail;
#pragma mark - 获取授权店信息
+ (void)requestAuthShoInfoSuccess:(Success)success fail:(Fail)fail;
#pragma mark - 通过微信url获取carid
+ (void)requestCaridWithWeixinURL:(NSString*)url success:(Success)success fail:(Fail)fail;
@end
