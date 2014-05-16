//
//  SearchHeadView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-15.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SearchHeadView.h"

@implementation SearchHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = self.bounds.size;
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, 100)];
        [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self addSubview:toolbar];
        
        UILabel *gong = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 20, 20)];
        [gong setText:@"共"];
        [gong sizeToFit];
        [toolbar addSubview:gong];

        UILabel *carNumbar = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gong.frame), 30, 20, 20)];
        [carNumbar setTextColor:[UIColor redColor]];
        [carNumbar setText:self.carNumberStr];
        
        [carNumbar sizeToFit];
        [toolbar addSubview:carNumbar];
//        self.carNumbar = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gong.frame), 30, 20, 20)];
//        [self.carNumbar setTextColor:[UIColor redColor]];
//        [self.carNumbar setText:@"28"];
//        
//        [self.carNumbar sizeToFit];
//        [toolbar addSubview:self.carNumbar];
        
        UILabel *liang = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(carNumbar.frame), 30, 20, 20)];
        [liang setText:@"辆车"];
        [liang sizeToFit];
        [toolbar addSubview:liang];
        
        UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(liang.frame)+30, 30, 20, 20)];
        [xian setText:@"显示预售车"];
        [xian sizeToFit];
        [toolbar addSubview:xian];
        
        UISwitch *switchPresell = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xian.frame)+10, 30, 40, 30)];
        //    [switchPresell setTransform:CGAffineTransformMakeScale(1.2,1.2)];
        //    [switchPresell sizeToFit];
        [toolbar addSubview:switchPresell];
        
        UIButton *carTrait = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(switchPresell.frame), toolbar.frame.size.width-40, 40)];
        [carTrait setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [carTrait setTitle:@"车型特点" forState:UIControlStateNormal];
        [carTrait.layer setBorderColor:[[UIColor redColor] CGColor]];
        [carTrait.layer setBorderWidth:1];
        [carTrait.layer setCornerRadius:8];
        [toolbar addSubview:carTrait];

    }
    return self;
}

- (void)aa
{
//    UILabel *gong = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 20, 20)];
//    [gong setText:@"共"];
//    [gong sizeToFit];
//    [self addSubview:gong];
//    
//    _carNumbar = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gong.frame), 30, 20, 20)];
//    [_carNumbar setTextColor:[UIColor redColor]];
//    [_carNumbar setText:@"88"];
//    
//    [_carNumbar sizeToFit];
//    [self addSubview:_carNumbar];
//    [_carNumbar setNeedsLayout];
//    
//    
//    _liang = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_carNumbar.frame), 30, 20, 20)];
//    [_liang setText:@"辆车"];
//    [_liang sizeToFit];
//    [self addSubview:_liang];
//    [_liang setNeedsLayout];
//    
//    _xian = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_liang.frame)+30, 30, 20, 20)];
//    [_xian setText:@"显示预售车"];
//    [_xian sizeToFit];
//    [self addSubview:_xian];
//    [_xian setNeedsLayout];
//    
//    
//    _switchPresell = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_xian.frame)+10, 30, 0, 0)];
//    //    [switchPresell setTransform:CGAffineTransformMakeScale(1.2,1.2)];
//    [_switchPresell sizeToFit];
//    [self addSubview:_switchPresell];
//    [_switchPresell setNeedsLayout];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
