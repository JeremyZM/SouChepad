//
//  RequireInfoModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequireInfoModel : NSObject

/** 起始年限 */
@property (copy, nonatomic) NSString *beginYear;

/** 车辆用途 */
@property (copy, nonatomic) NSString *carUsed;

/** 车体形式 */
@property (copy, nonatomic) NSString *carbody;

/** 车体形式 */
@property (copy, nonatomic) NSString *carbodyName;

/** 国别 */
@property (copy, nonatomic) NSString *country;

/** 国别 */
@property (copy, nonatomic) NSString *countryName;

/** 生成时间 */
@property (copy, nonatomic) NSString *dateCreate;

/** 删除时间 */
@property (copy, nonatomic) NSString *dateDelete;

/** 更新时间 */
@property (copy, nonatomic) NSString *dateUpdate;

/** 预算截止 */
@property (copy, nonatomic) NSString *endBudget;

/** <#Name#> */
@property (copy, nonatomic) NSString *endBudgetShow;

/** 截止年限 */
@property (copy, nonatomic) NSString *endYear;

/** 里程 */
@property (copy, nonatomic) NSString *miles;

/** 里程 */
@property (copy, nonatomic) NSString *milesName;

/** <#Name#> */
@property (copy, nonatomic) NSString *month;

/** 价格范围 */
@property (copy, nonatomic) NSString *priceRange;

/** 价格范围 */
@property (copy, nonatomic) NSString *purchaseCarBudget;

/** 预算起始 */
@property (copy, nonatomic) NSString *startBudget;

/**  */
@property (copy, nonatomic) NSString *startBudgetShow;

/** 用户 */
@property (copy, nonatomic) NSString *user;

/** 年限 */
@property (copy, nonatomic) NSString *years;

/** 年限 */
@property (copy, nonatomic) NSString *yearsName;


@end
