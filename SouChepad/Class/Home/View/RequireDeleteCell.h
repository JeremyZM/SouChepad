//
//  RequireDeleteCell.h
//  Athena
//
//  Created by 张艳东 on 14-7-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequireBrandsModel.h"

@interface RequireDeleteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *seriesNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *displacementLabel;

@property (weak, nonatomic) IBOutlet UILabel *colorsLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateDeleteLabel;

@property (nonatomic, strong) RequireBrandsModel *requireDeleteM;


@end
