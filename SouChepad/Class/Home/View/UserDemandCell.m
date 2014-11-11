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
    
    [self.brandNameLabel setText:requireBrandM.brandName];
    
    [self.seriesNameLabel setText:requireBrandM.seriesName];
        
    [self.colorsLabel setText:requireBrandM.colorsName];
    
//    [self.countLabel setText:[NSString stringWithFormat:@"(%@)",requireBrandM.countCar]];
    
    [self.displacementLabel setText:requireBrandM.displacementName];
        
    [self.remarksLabel setText:requireBrandM.remarks];
    
    [self.speedChangerLabel setText:requireBrandM.speedChangerName];
    
    [self.dateCreateLabel setText:requireBrandM.dateCreateName];
    
}


@end
