//
//  SCTextfield.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-4.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SCTextfield.h"

@implementation SCTextfield

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setFont:[UIFont systemFontOfSize:22]];
        [self setBackgroundColor:[UIColor whiteColor]];
        [[UITextField appearance] setTintColor:[UIColor redColor]];
    }
    return self;
}


- (void)setlaybyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    CAShapeLayer *shLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    [shLayer setPath:path.CGPath];
    [self.layer setMask:shLayer];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , 15 , 0 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , 15 , 0 );
}

@end
