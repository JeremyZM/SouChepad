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
#import "UIImage+Utility.h"




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
    NSString *date = strNoNull(carModel.day).length == 0 ? strNoNull(carModel.firstLicensePlateDate) : strNoNull(carModel.day);
    [_firstLicensePlateDateLabel setText:[NSString stringWithFormat:@"添加：%@", date]];
    
    // 车辆等级
    if (carModel.level) {
        [_levelImage setImage:[UIImage imageNamed:carModel.level]];
    }else {
        [_levelImage setHidden:YES];
    }
    
//    DLog(@"%@",carModel.carStatus);
    [_shoukuanXiajia setHidden:NO];
    // 车辆状态
    if ([carModel.carStatus isEqualToString:@"在售"]) {
        [_carStatusImage setHidden:YES];
        [_carNameLable setTextColor:[UIColor blackColor]];
        [_souchePriceLabel setTextColor:[UIColor redColor]];
        
    }else if ([carModel.carStatus isEqualToString:@"预售"]){
        [_carStatusImage setHidden:YES];
        [_levelImage setHidden:NO];
        [_levelImage setImage:[UIImage imageNamed:@"presell"]];
        [_carNameLable setTextColor:[UIColor blackColor]];
        [_souchePriceLabel setTextColor:[UIColor redColor]];
        
    }else {
        [_carStatusImage setHidden:NO];
        [_shoukuanXiajia setHidden:YES];
        [_carNameLable setTextColor:[UIColor lightGrayColor]];
        [_souchePriceLabel setTextColor:[UIColor lightGrayColor]];
        [_carStatusImage setImage:[UIImage imageNamed:@"done_04"]];
    }
    
    // 车辆图片
    [_carImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    UIImage *img = [UIImage new];
    [img setImageWithUrl:carModel.image scaleToSize:_carImage.frame.size forImageView:_carImage];
    
    // 降价
    [self.downPriceImage setImage:[UIImage imageNamed:@"标准车辆卡片小图标_18"]];
    
    if (carModel.downPrice) {
        [self.downPriceImage setHidden:NO];
        [self.downPiceLabel setHidden:NO];
        [self.downPiceLabel setText:carModel.downPrice];
    }else {
        [self.downPriceImage setHidden:YES];
        [self.downPiceLabel setHidden:YES];

    }
    
//    DLog(@"------af-----------------%@",a);
    [_labelLabel setText:carModel.lookORdrive];
}

// * 收款下架
- (IBAction)shoukuanXiajiaAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectCarCell:shoukuanXiajiaButtonClicked:)]) {
        [self.delegate collectCarCell:self shoukuanXiajiaButtonClicked:(UIButton*)sender];
    }
}

// 隐藏收款下架按钮
- (void)hiddenShoukuanXiajiaButton{
    _shoukuanXiajia.hidden = YES;
}
@end
