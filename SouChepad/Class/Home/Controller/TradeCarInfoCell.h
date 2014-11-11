//
//  TradeCarInfoCell.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGCenterLineLabel.h"
@class TradeCarInfoModel;

@interface TradeCarInfoCell : UICollectionViewCell
/**
 *  降价通知，限时特价
 */
@property (weak, nonatomic) IBOutlet UILabel *downPiceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *downPriceImage;
/**
 *  车辆图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *carImage;

/**
 *  车辆状态图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *carStatusImage;

/**
 *  标签view
 */
@property (weak, nonatomic) IBOutlet UIView *labelView;

/**
 *  标签label
 */
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;

/**
 *  等级图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *levelImage;

/**
 *  推荐图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *commendImage;

/**
 *  车辆名称
 */
@property (weak, nonatomic) IBOutlet UILabel *carNameLable;

/**
 *  搜车价
 */
@property (weak, nonatomic) IBOutlet UILabel *souchePriceLabel;

/**
 *  上牌时间
 */
@property (weak, nonatomic) IBOutlet UILabel *firstLicensePlateDateLabel;

/**
 *  交易方式
 */
@property (weak, nonatomic) IBOutlet UILabel *tradeTypeLabel;

/**
 *  成交价
 */
@property (weak, nonatomic) IBOutlet UILabel *tradePriceLabel;

/**
 *  交易状态
 */
@property (weak, nonatomic) IBOutlet UILabel *tradeStatusLabel;

/**
 *  过户销售,过户坐席,成交日期
 */
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (nonatomic, strong) TradeCarInfoModel *tradeCarInfoM;

@property (weak, nonatomic) IBOutlet TGCenterLineLabel *lineLabel;


@end
