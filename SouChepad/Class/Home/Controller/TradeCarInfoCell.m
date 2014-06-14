//
//  TradeCarInfoCell.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "TradeCarInfoCell.h"
#import "TradeCarInfoModel.h"
#import "UIImageView+WebCache.h"

@implementation TradeCarInfoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTradeCarInfoM:(TradeCarInfoModel *)tradeCarInfoM
{
    _tradeCarInfoM = tradeCarInfoM;
    // 车辆名称
    [_carNameLable setText:tradeCarInfoM.carName];
    // 搜车价
    [_souchePriceLabel setText:[NSString stringWithFormat:@"%@ 万",tradeCarInfoM.souchePrice]];
    // 上车时间
    [_firstLicensePlateDateLabel setText:[NSString stringWithFormat:@"上牌：%@",tradeCarInfoM.firstLicensePlateDate]];
    
    // 车辆等级
    if ([tradeCarInfoM.level isEqualToString:@"暂无"]) {
        [_levelImage setHidden:YES];
    }else {
        [_levelImage setImage:[UIImage imageNamed:tradeCarInfoM.level]];
    }
    
    // 车辆状态
    if ([tradeCarInfoM.carStatus isEqualToString:@"在售"]) {
        [_carStatusImage setHidden:YES];
        [_carNameLable setTextColor:[UIColor blackColor]];
        [_souchePriceLabel setTextColor:[UIColor redColor]];
        
    }else {
        [_carStatusImage setHidden:NO];
        [_carNameLable setTextColor:[UIColor lightGrayColor]];
        [_souchePriceLabel setTextColor:[UIColor lightGrayColor]];
        [_carStatusImage setImage:[UIImage imageNamed:@"done_04"]];
    }

    
    
    
    // 车辆图片
    [_carImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageBaseURL,tradeCarInfoM.image]] placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
    NSString*a = tradeCarInfoM.carStatus;
    DLog(@"------af-----------------%@",a);
    
    /**
     *  成交，试驾看车，预约，收藏
     */
    [_labelLabel setText:tradeCarInfoM.lookORdrive];
    
    
    // 付款方式
    [_tradeTypeLabel setText:tradeCarInfoM.transferMode];
    
    // 成交价
    [_tradePriceLabel setText:tradeCarInfoM.tradePrice];
    // 过户地
    [_transferToLabel setText:tradeCarInfoM.transferTo];
    // 交易进度
    [_tradeStatusLabel setText:tradeCarInfoM.tradeStatus];
    // 详细信息
    [_infoLabel setText:[NSString stringWithFormat:@"成交于 %@   销售 %@    坐席 %@",tradeCarInfoM.day,tradeCarInfoM.tradeSell,tradeCarInfoM.tradeCC]];

    
}


@end
