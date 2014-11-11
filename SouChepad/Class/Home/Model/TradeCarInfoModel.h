//
//  TradeCarInfoModel.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarBaseModel.h"

@interface TradeCarInfoModel : CarBaseModel

/** 订单编号 */
@property (copy, nonatomic) NSString *orderNumber;

/** 过户信息ID */
@property (copy, nonatomic) NSString *tradeId;

/** 交易状态 */
@property (copy, nonatomic) NSString *tradeStatus;

/** 定金 */
@property (copy, nonatomic) NSString *downPayment;

/** 成交价 */
@property (copy, nonatomic) NSString *tradePrice;

/** 过户地from */
@property (copy, nonatomic) NSString *transferMode;

/** 过户地TO */
@property (copy, nonatomic) NSString *transferTo;

/** 过户销售 */
@property (copy, nonatomic) NSString *tradeSell;

/** 过户坐席 */
@property (copy, nonatomic) NSString *tradeCC;

/** 成交日期 */
@property (copy, nonatomic) NSString *day;

/** 付款方式 */
@property (copy, nonatomic) NSString *payType;

@end
