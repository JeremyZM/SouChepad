//
//  LimitSearchView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-15.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "LimitSearchView.h"

@implementation LimitSearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setBarTintColor:[UIColor yellowColor]];
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(200, 300, 100, 100)];
        [but addTarget:self action:@selector(hidLimitView) forControlEvents:UIControlEventTouchUpInside];
        [but setBackgroundColor:[UIColor redColor]];
        [self addSubview:but];
        self.searchBut = but;
    }
    return self;
}

- (void)hidLimitView
{
    CGRect frme = self.frame;
    frme.origin.y -= frme.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        [self setFrame:frme];
    } completion:^(BOOL finished) {
        if ([_limitDelegate respondsToSelector:@selector(limitSearch:withDic:)]) {
            [_limitDelegate limitSearch:self withDic:@{}];
        }
    }];
}

@end
