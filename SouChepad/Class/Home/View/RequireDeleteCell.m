//
//  RequireDeleteCell.m
//  Athena
//
//  Created by 张艳东 on 14-7-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "RequireDeleteCell.h"

@implementation RequireDeleteCell

- (void)awakeFromNib
{
    
}

- (void)setRequireDeleteM:(RequireBrandsModel *)requireDeleteM
{
    _requireDeleteM = requireDeleteM;
    [self.brandNameLabel setText:requireDeleteM.brandName];
    [self.seriesNameLabel setText:requireDeleteM.seriesName];
    [self.displacementLabel setText:requireDeleteM.displacementName];
    [self.colorsLabel setText:requireDeleteM.colorsName];
    [self.dateDeleteLabel setText:requireDeleteM.dateDelete];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
