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
#import "YLImageView.h"
#import "YLGIFImage.h"

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
    
    if ([lookOrDriveCellM.isDriveCar isEqualToString:@"1"]) {
        [self.driveingBackView setHidden:NO];

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nostring)];
        [self.driveingBackView addGestureRecognizer:tapRecognizer];
        [self.driveingGIF setImage:[YLGIFImage imageNamed:@"shaohouchuli.gif"]];
    }else {
        [self.driveingBackView setHidden:YES];
    }
    
    // 车辆名称
    [_carNameLable setText:lookOrDriveCellM.carName];
    // 搜车价
    [_souchePriceLabel setText:[NSString stringWithFormat:@"%@ 万",lookOrDriveCellM.souchePrice]];
    // 上车时间
    [_firstLicensePlateDateLabel setText:[NSString stringWithFormat:@"添加：%@",lookOrDriveCellM.firstLicensePlateDate]];
    
    // 车辆等级
    if (lookOrDriveCellM.level) {
        [_levelImage setImage:[UIImage imageNamed:lookOrDriveCellM.level]];
    }else {
        [_levelImage setHidden:YES];
    }
    
//    DLog(@"%@",lookOrDriveCellM.carStatus);
    
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
    [[UIImage new] setImageWithUrl:lookOrDriveCellM.image scaleToSize:_carImage.frame.size forImageView:_carImage];
    [_carImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
    [_labelLabel setText:lookOrDriveCellM.lookORdrive];
    
    // 心里价位
    [_userPriceLabel  setText:lookOrDriveCellM.userPrice];
    
    // 满意程度
    [_satisfactionLabel setText:lookOrDriveCellM.satisfaction];
    
    // 看车评价
    [_lookRemarkLabel setText:lookOrDriveCellM.lookRemark];
//    lookcar 看车， testdrive
    // 试驾评价
    if ([lookOrDriveCellM.status isEqualToString:@"lookcar"]) {
        [_driveRemarkLabel setText:@"未试驾"];
        [_infoLabel setText:[NSString stringWithFormat:@"看车于%@",lookOrDriveCellM.day]];
    }else if ([lookOrDriveCellM.status isEqualToString:@"testdrive"]){

        [_driveRemarkLabel setText:lookOrDriveCellM.driveRemark];
        // 详细信息
        [_infoLabel setText:[NSString stringWithFormat:@"试驾于 %@    负责人 %@     试驾里程 %@公里    试驾耗时 %@分钟",lookOrDriveCellM.day,lookOrDriveCellM.seller,lookOrDriveCellM.driveMile?lookOrDriveCellM.driveMile:@"",lookOrDriveCellM.driveTime?lookOrDriveCellM.driveTime:@""]];
    }
    
    
    
    
}

- (void)nostring
{
    return;
}


@end
