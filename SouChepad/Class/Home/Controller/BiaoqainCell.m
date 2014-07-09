//
//  BiaoqainCell.m
//  Athena
//
//  Created by 张艳东 on 14-7-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "BiaoqainCell.h"

@implementation BiaoqainCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _burt = [[UIButton alloc] init];
        [_burt setUserInteractionEnabled:NO];
        //        [_burt addTarget:self action:@selector(aaaaa) forControlEvents:UIControlEventTouchUpInside];
        [_burt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_burt setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_burt setBackgroundColor:[UIColor lightGrayColor]];
        [_burt.layer setCornerRadius:3.0];
        [_burt.layer setMasksToBounds:YES];
        [self addSubview:_burt];
    }
    return self;
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
