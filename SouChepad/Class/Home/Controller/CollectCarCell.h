//
//  CollectCarCell.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-5.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarBaseModel.h"

@protocol CollectCarCellDelegate <NSObject>
- (void)collectCarCell:(id)cell  shoukuanXiajiaButtonClicked:(UIButton*)button;
@end

@interface CollectCarCell : UICollectionViewCell

/**
 *  降价通知，限时特价
 */
@property (weak, nonatomic) IBOutlet UIImageView *downPriceImage;
/**
 *  降价
 */
@property (weak, nonatomic) IBOutlet UILabel *downPiceLabel;
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
 * 收款下架
 */
@property (weak, nonatomic) IBOutlet UIButton *shoukuanXiajia;

@property (nonatomic, strong) CarBaseModel *carModel;

@property (nonatomic, weak) id<CollectCarCellDelegate> delegate;

// 隐藏收款下架按钮
- (void)hiddenShoukuanXiajiaButton;
@end
