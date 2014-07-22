//
//  LookOrDriveCarInfoCell.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "LookOrDriveCarInfoCell.h"
#import "LookOrDriveCarInfoModel.h"
#import "UIImageView+WebCache.h"


@implementation LookOrDriveCarInfoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setLookOrDriveCellM:(LookOrDriveCarInfoModel *)lookOrDriveCellM
{
    _lookOrDriveCellM = lookOrDriveCellM;
    
    // 车辆名称
    [_carNameLable setText:lookOrDriveCellM.carName];
    // 搜车价
    [_souchePriceLabel setText:[NSString stringWithFormat:@"%@ 万",lookOrDriveCellM.souchePrice]];
    // 上车时间
    [_firstLicensePlateDateLabel setText:[NSString stringWithFormat:@"上牌：%@",lookOrDriveCellM.firstLicensePlateDate]];
    
    // 车辆等级
    if (lookOrDriveCellM.level) {
        [_levelImage setImage:[UIImage imageNamed:lookOrDriveCellM.level]];
    }else {
        [_levelImage setHidden:YES];
    }
    
    // 车辆状态
    if ([lookOrDriveCellM.carStatus isEqualToString:@"在售"]) {
        [_carStatusImage setHidden:YES];
        [_carNameLable setTextColor:[UIColor blackColor]];
        [_souchePriceLabel setTextColor:[UIColor redColor]];
        
    }else if ([lookOrDriveCellM.carStatus isEqualToString:@"预售"]){
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
    if (lookOrDriveCellM.downPrice) {
        [self.downPriceImage setHidden:NO];
        [self.downPiceLabel setHidden:NO];
        [self.downPiceLabel setText:lookOrDriveCellM.downPrice];
    }else {
        [self.downPriceImage setHidden:YES];
        [self.downPiceLabel setHidden:YES];
    }
    
    // 车辆图片
    [_carImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageBaseURL,lookOrDriveCellM.image]] placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
    [_labelLabel setText:lookOrDriveCellM.lookORdrive];
    
    // 心里价位
    [_userPriceLabel  setText:lookOrDriveCellM.userPrice];
    
    // 满意程度
    [_satisfactionLabel setText:lookOrDriveCellM.satisfaction];
    
    // 看车评价
    [_lookRemarkLabel setText:lookOrDriveCellM.lookRemark];
    
    // 试驾评价
    [_driveRemarkLabel setText:lookOrDriveCellM.driveRemark];
    
    // 详细信息
    [_infoLabel setText:[NSString stringWithFormat:@"试驾于 %@    负责人 %@  试驾里程%@公里   试驾耗时 %@",lookOrDriveCellM.day,lookOrDriveCellM.seller,lookOrDriveCellM.driveMile,lookOrDriveCellM.driveTime]];
    
}


@end
