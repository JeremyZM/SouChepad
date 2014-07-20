//
//  UserDemandCell.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-18.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequireBrandsModel.h"

@interface UserDemandCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *deleteDemandCarBut;

/**
 *   车型
 */
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
/**
 *  车系
 */
@property (weak, nonatomic) IBOutlet UILabel *seriesNameLabel;



@property (weak, nonatomic) IBOutlet UILabel *displacementLabel;


/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

/**
 *  颜色
 */
@property (weak, nonatomic) IBOutlet UILabel *colorsLabel;

/**
 *  变速箱
 */
@property (weak, nonatomic) IBOutlet UILabel *speedChangerLabel;

/**
 *  添加时间
 */
@property (weak, nonatomic) IBOutlet UILabel *dateCreateLabel;

/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UILabel *remarksLabel;

/**
 *  需求
 */
@property (nonatomic, strong) RequireBrandsModel *requireBrandM;

@end
