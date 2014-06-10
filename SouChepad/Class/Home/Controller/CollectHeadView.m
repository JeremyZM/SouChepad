//
//  CollectHeadView.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CollectHeadView.h"

@implementation CollectHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _stateCarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 34)];
        [_stateCarLabel setFont:[UIFont systemFontOfSize:20]];
        [self addSubview:_stateCarLabel];
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
