//
//  LookOrDriveCarInfoCell.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-13.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LookOrDriveCarInfoModel;

@interface LookOrDriveCarInfoCell : UICollectionViewCell

/**
 *  降价通知，限时特价
 */
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
 *  心里价位
 */
@property (weak, nonatomic) IBOutlet UILabel *userPriceLabel;

/**
 *  满意度
 */
@property (weak, nonatomic) IBOutlet UILabel *satisfactionLabel;

/**
 *  看车记录
 */
@property (weak, nonatomic) IBOutlet UILabel *lookRemarkLabel;

/**
 *  试驾记录
 */
@property (weak, nonatomic) IBOutlet UILabel *driveRemarkLabel;

/**
 *  试驾公里,试驾时间,看车试驾具体时间
 */
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@property (nonatomic, strong) LookOrDriveCarInfoModel *lookOrDriveCellM;

@end
