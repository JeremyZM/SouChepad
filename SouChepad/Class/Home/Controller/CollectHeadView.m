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
        [self setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
        _stateCarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 34)];
        [_stateCarLabel setFont:[UIFont systemFontOfSize:20]];
        [_stateCarLabel setTextColor:[UIColor hexStringToColor:KBaseColo]];
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
