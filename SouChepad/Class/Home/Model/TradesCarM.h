//
//  TradesCarM.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//  成交车辆

#import "CarBaseModel.h"

@interface TradesCarM : CarBaseModel

/**
 *  成交日期
 */
@property (nonatomic, copy) NSString *day;

/**
 *  定金
 */
@property (nonatomic, copy) NSString *downPayment;


/**
 *  过户信息ID
 */
@property (nonatomic, copy) NSString *tradeId;


/**
 *  过户坐席
 */
@property (nonatomic, copy) NSString *tradeCC;

/**
 *  成交价
 */
@property (nonatomic, copy) NSString *tradePrice;

/**
 *  过户销售
 */
@property (nonatomic, copy) NSString *tradeSell;

/**
 *  交易状态
 */
@property (nonatomic, copy) NSString *tradeStatus;

/**
 *  过户地
 */
@property (nonatomic, copy) NSString *transferMode;

/**
 *  过户地
 */
@property (nonatomic, copy) NSString *transferTo;


@end
