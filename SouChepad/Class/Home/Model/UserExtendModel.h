//
//  UserExtendModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-12.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserExtendModel : NSObject

/** 车辆品牌名称 */
@property (copy, nonatomic) NSString *brandName;

/** 购买时间 */
@property (copy, nonatomic) NSString *buyTime;

/** 已有车辆品牌 */
@property (copy, nonatomic) NSString *carBrand;

/** 已有车辆系列 */
@property (copy, nonatomic) NSString *carSeris;

/** 是否有指标1 有，0 无 */
@property (copy, nonatomic) NSString *carTarget;

/** 指标到期时间 */
@property (copy, nonatomic) NSString *carTargetEndDate;

/** 车辆用途 */
@property (copy, nonatomic) NSString *carUsed;

/** 合同，多个使用,分割 */
@property (copy, nonatomic) NSString *contract;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateCreate;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateDelete;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateUpdate;

/** 行驶证 */
@property (copy, nonatomic) NSString *drivelicense;
/** <#Name#> */
@property (copy, nonatomic) NSString *drivelicenseURL;

/** <#Name#> */
@property (copy, nonatomic) NSString *ID;

/** 身份证反面 */
@property (copy, nonatomic) NSString *idcardBack;
/** <#Name#> */
@property (copy, nonatomic) NSString *idcardBackURL;

/** 身份证正面 */
@property (copy, nonatomic) NSString *idcardFront;
/** <#Name#> */
@property (copy, nonatomic) NSString *idcardFrontURL;

/** 外迁地 - 辅助购买信息 */
@property (copy, nonatomic) NSString *insureAddr;

/** 本市，外迁- 辅助购买记录 */
@property (copy, nonatomic) NSString *insureType;

/** 是否拥有车辆 */
@property (copy, nonatomic) NSString *isHaveCar;

/** 是否卖车 */
@property (copy, nonatomic) NSString *isSellCar;

/** 分期，全款-辅助购买记录 */
@property (copy, nonatomic) NSString *payType;

/** 首次上牌时间 */
@property (copy, nonatomic) NSString *registerTime;

/** 备注 */
@property (copy, nonatomic) NSString *remark;

/** 车辆系列名称 */
@property (copy, nonatomic) NSString *seriesName;


/** 过户省 code */
@property (copy, nonatomic) NSString *insureProvince;
/** 过户省 */
@property (copy, nonatomic) NSString *insureProvinceName;

/** 过户市code */
@property (copy, nonatomic) NSString *insureCity;
/** 过户市 */
@property (copy, nonatomic) NSString *insureCityName;



@end
