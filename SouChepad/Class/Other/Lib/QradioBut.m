//
//  QradioBut.m
//  Athena
//
//  Created by 张艳东 on 14-7-16.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "QradioBut.h"

#define Q_RADIO_ICON_WH                     (16.0)
#define Q_ICON_TITLE_MARGIN                 (5.0)

static NSMutableDictionary *_groupRadioDic = nil;

@implementation QradioBut

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addToGroup];
//        
//        self.exclusiveTouch = YES;
//        
//        [self setImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateSelected];
//        [self.titleLabel setFont:KFont18];
//        [self addTarget:self action:@selector(radioBtnChecked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{

}

- (void)setDelegate:(id<QradioButDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setGroupId:(NSString *)groupId
{
    _groupId = groupId;
    [self addToGroup];
    
    self.exclusiveTouch = YES;
    
    [self setImage:[UIImage imageNamed:@"button_normal.png"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"button_selected.png"] forState:UIControlStateSelected];
//    [self.titleLabel setFont:KFont18];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addTarget:self action:@selector(radioBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}


- (void)addToGroup {
    if(!_groupRadioDic){
        _groupRadioDic = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (!_gRadios) {
        _gRadios = [NSMutableArray array];
    }
    [_gRadios addObject:self];
    [_groupRadioDic setObject:_gRadios forKey:_groupId];
}

- (void)removeFromGroup {
    if (_groupRadioDic) {
        NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
        if (_gRadios) {
            [_gRadios removeObject:self];
            if (_gRadios.count == 0) {
                [_groupRadioDic removeObjectForKey:_groupId];
            }
        }
    }
}

- (void)uncheckOtherRadios {
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (_gRadios.count > 0) {
        for (QradioBut *_radio in _gRadios) {
            if (_radio.checked && ![_radio isEqual:self]) {
                _radio.checked = NO;
            }
        }
    }
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (self.selected) {
        [self uncheckOtherRadios];
    }
    
    if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)]) {
        [_delegate didSelectedRadioButton:self groupId:_groupId];
    }
}

- (void)radioBtnChecked {
    if (_checked) {
        
        //        if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)]) {
        //            [_delegate didSelectedRadioButton:self groupId:_groupId];
        //
        //        }
        
    }
    
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (self.selected) {
        [self uncheckOtherRadios];
    }
    
    if ( _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)]) {
        if (self.selected) {
            
            [_delegate didSelectedRadioButton:self groupId:_groupId];
        }else {
            [_delegate didSelectedRadioButton:nil groupId:_groupId];
        }
        
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(0, (CGRectGetHeight(contentRect) - Q_RADIO_ICON_WH)/2.0, Q_RADIO_ICON_WH, Q_RADIO_ICON_WH);
    return self.bounds;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(Q_RADIO_ICON_WH + Q_ICON_TITLE_MARGIN, 0,
//                      CGRectGetWidth(contentRect) - Q_RADIO_ICON_WH - Q_ICON_TITLE_MARGIN,
//                      CGRectGetHeight(contentRect));
    return self.bounds;
}



- (void)dealloc {
    [self removeFromGroup];
    
    _delegate = nil;
    _groupId = nil;
    
}


@end
