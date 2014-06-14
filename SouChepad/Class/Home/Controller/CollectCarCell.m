//
//  CollectCarCell.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-5.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CollectCarCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+LK.h"





@implementation CollectCarCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCarModel:(CarBaseModel *)carModel
{
    _carModel = carModel;
    // 车辆名称
    [_carNameLable setText:carModel.carName];
    // 搜车价
    [_souchePriceLabel setText:[NSString stringWithFormat:@"%@ 万",carModel.souchePrice]];
    // 上车时间
    [_firstLicensePlateDateLabel setText:[NSString stringWithFormat:@"上牌：%@",carModel.firstLicensePlateDate]];
    
    // 车辆等级
    if ([carModel.level isEqualToString:@"暂无"]) {
        [_levelImage setHidden:YES];
    }else {
        [_levelImage setImage:[UIImage imageNamed:carModel.level]];
    }
    
    // 车辆状态
    if ([carModel.carStatus isEqualToString:@"在售"]) {
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
    [_carImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageBaseURL,carModel.image]] placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
    NSString*a = carModel.carStatus;
    DLog(@"------af-----------------%@",a);
    [_labelLabel setText:carModel.lookORdrive];
}

@end
