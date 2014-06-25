//
//  RequireBrandsModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequireBrandsModel : NSObject

/** <#Name#> */
@property (copy, nonatomic) NSString *brand;


/** <#Name#> */
@property (copy, nonatomic) NSString *brandName;

/** <#Name#> */
@property (copy, nonatomic) NSString *brandSeriesName;

/** 颜色 多个使用',' 分 */
@property (copy, nonatomic) NSString *colors;

/** 颜色 多个使用',' 分 */
@property (copy, nonatomic) NSString *colorsName;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateCreate;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateCreateName;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateDelete;

/** <#Name#> */
@property (copy, nonatomic) NSString *dateUpdate;

/** 排量 */
@property (copy, nonatomic) NSString *displacement;

/** 排量 */
@property (copy, nonatomic) NSString *displacementName;

/** 车连型号 */
@property (copy, nonatomic) NSString *model;

/** 车连型号 */
@property (copy, nonatomic) NSString *modelName;

/** <#Name#> */
@property (copy, nonatomic) NSString *others;

/** <#Name#> */
@property (copy, nonatomic) NSString *remarks;

/** 车系 */
@property (copy, nonatomic) NSString *series;

/** 车系 */
@property (copy, nonatomic) NSString *seriesName;

/** 来源 */
@property (copy, nonatomic) NSString *source;

/** 变速箱类型 */
@property (copy, nonatomic) NSString *speedChanger;

/** 变速箱类型 */
@property (copy, nonatomic) NSString *speedChangerName;

/** 用户 */
@property (copy, nonatomic) NSString *user;



@end
