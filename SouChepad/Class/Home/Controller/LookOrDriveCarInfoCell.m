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
    if ([lookOrDriveCellM.level isEqualToString:@"暂无"]) {
        [_levelImage setHidden:YES];
    }else {
        [_levelImage setImage:[UIImage imageNamed:lookOrDriveCellM.level]];
    }
    
    // 车辆状态
    if ([lookOrDriveCellM.carStatus isEqualToString:@"在售"]) {
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
    [_carImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageBaseURL,lookOrDriveCellM.image]] placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
    NSString*a = lookOrDriveCellM.carStatus;
    DLog(@"------af-----------------%@",a);
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
