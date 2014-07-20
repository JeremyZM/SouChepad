//
//  UserDemandCell.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-18.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "UserDemandCell.h"

@implementation UserDemandCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setRequireBrandM:(RequireBrandsModel *)requireBrandM
{
    _requireBrandM = requireBrandM;

    if (![requireBrandM.brandName isEqualToString:@"暂无"]) {
        
        [self.brandNameLabel setText:requireBrandM.brandName];
    }else {
        [self.brandNameLabel setText:nil];
    }
    
    if (![requireBrandM.seriesName isEqualToString:@"暂无"]) {
        
        [self.seriesNameLabel setText:requireBrandM.seriesName];
    }else {
        [self.seriesNameLabel setText:nil];
    }
    
    if (![requireBrandM.colorsName isEqualToString:@"暂无"]) {
        
        [self.colorsLabel setText:requireBrandM.colorsName];
    }else {
        [self.colorsLabel setText:nil];
    }
    
    if (![requireBrandM.displacementName isEqualToString:@"暂无"]) {
        
        [self.displacementLabel setText:requireBrandM.displacementName];
    }else {
        [self.displacementLabel setText:nil];
    }

    
    if (![requireBrandM.remarks isEqualToString:@"暂无"]) {
        
        [self.remarksLabel setText:requireBrandM.remarks];
    }else {
        [self.remarksLabel setText:nil];
    }
    
    
    if (![requireBrandM.speedChangerName isEqualToString:@"暂无"]) {
        
        [self.speedChangerLabel setText:requireBrandM.speedChangerName];
    }else {
        [self.speedChangerLabel setText:nil];
    }
    
    
    
    if (![requireBrandM.dateCreateName isEqualToString:@"暂无"]) {
        
        [self.dateCreateLabel setText:requireBrandM.dateCreateName];
    }else {
        [self.dateCreateLabel setText:nil];
    }
    
    
    
}


@end
