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

@interface TradeCarInfoCell(){
}

@end

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
    NSString *time = strNoNull(tradeCarInfoM.day).length == 0 ? strNoNull(tradeCarInfoM.firstLicensePlateDate) : tradeCarInfoM.day;
    [_firstLicensePlateDateLabel setText:[NSString stringWithFormat:@"添加：%@",time]];
    
    // 车辆等级
    if (tradeCarInfoM.level) {
        [_levelImage setImage:[UIImage imageNamed:tradeCarInfoM.level]];
    }else {
        [_levelImage setHidden:YES];
    }
    
    // 车辆状态
    if ([tradeCarInfoM.carStatus isEqualToString:@"在售"]) {
        [_carStatusImage setHidden:YES];
        [_carNameLable setTextColor:[UIColor blackColor]];
        [_souchePriceLabel setTextColor:[UIColor redColor]];
        
    }else if ([tradeCarInfoM.carStatus isEqualToString:@"预售"]){
        [_carStatusImage setHidden:YES];
        [_levelImage setHidden:NO];
        [_levelImage setImage:[UIImage imageNamed:@"presell"]];
        [_carNameLable setTextColor:[UIColor blackColor]];
        [_souchePriceLabel setTextColor:[UIColor redColor]];
        
    }else {
        [_carStatusImage setHidden:NO];
        [_carNameLable setTextColor:[UIColor lightGrayColor]];
        [_souchePriceLabel setTextColor:[UIColor lightGrayColor]];
        [_carStatusImage setImage:[UIImage imageNamed:@"done_04"]];
    }
    
    // 降价
    if (tradeCarInfoM.downPrice) {
        [self.downPriceImage setHidden:NO];
        [self.downPiceLabel setHidden:NO];
        [self.downPiceLabel setText:tradeCarInfoM.downPrice];
    }else {
        [self.downPriceImage setHidden:YES];
        [self.downPiceLabel setHidden:YES];
    }
    
    // 车辆图片
    [[UIImage new] setImageWithUrl:tradeCarInfoM.image scaleToSize:_carImage.frame.size forImageView:_carImage];
    [_carImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
    [_lineLabel setText:[NSString stringWithFormat:@"(搜车价 %@万)",tradeCarInfoM.souchePrice]];
    [_lineLabel sizeToFit];
    /**
     *  成交，试驾看车，预约，收藏
     */
    [_labelLabel setText:tradeCarInfoM.lookORdrive];
    
    
    // 付款方式
    [_tradeTypeLabel setText:tradeCarInfoM.payType];
    
    // 成交价
    [_tradePriceLabel setText:[NSString stringWithFormat:@"%@万",tradeCarInfoM.tradePrice]];
    // 交易进度
    [_tradeStatusLabel setText:tradeCarInfoM.tradeStatus];
    // 详细信息
    [_infoLabel setText:[NSString stringWithFormat:@"成交于 %@   销售 %@",tradeCarInfoM.day,strNoNull(tradeCarInfoM.tradeSell)]];
}
@end
