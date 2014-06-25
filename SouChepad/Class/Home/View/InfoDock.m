//
//  InfoDock.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "InfoDock.h"
#import "SCDockItem.h"

@interface InfoDock ()
{
    SCDockItem *_selectedItem; // 被选中的标签
}

@end

@implementation InfoDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加所有Item
        [self addAllInfoItems];
        
        UIView *shadowView= [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-1, 100, 1, frame.size.height)];

        [shadowView setBackgroundColor:[UIColor whiteColor]];
        [[shadowView layer] setShadowOffset:CGSizeMake(1, 1)];
        [[shadowView layer] setShadowRadius:5];
        [[shadowView layer] setShadowOpacity:1];
        [[shadowView layer] setShadowColor:[UIColor darkGrayColor].CGColor];
        
        [self addSubview:shadowView];
    }
    return self;
}

- (void)addAllInfoItems
{
    // 1.我的客户
//    [self addOneInfoTabTitle:@"" icon:@"tubiao_38" selectedIcon:@"tubiao_38" index:0];
    UIButton *backBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
    [backBut setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    [backBut setImage:[UIImage imageNamed:@"tubiao_38"] forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(InfotabClick:) forControlEvents:UIControlEventTouchUpInside];
    [backBut setTag:0];
    [self addSubview:backBut];

    // 2.我的车辆
    [self addOneInfoTabTitle:@"个人信息" icon:@"tubiao_16" selectedIcon:@"tubiao_25" index:1];
    
    // 3.意向车辆
    [self addOneInfoTabTitle:@"意向车辆" icon:@"tubiao_17" selectedIcon:@"tubiao_26" index:2];
    
    
    // 4.沟通记录
    [self addOneInfoTabTitle:@"沟通记录" icon:@"tubiao_18" selectedIcon:@"tubiao_27" index:3];
    
    // 4.逛店找车
//    [self addOneInfoTabTitle:@"逛店找车" icon:@"tubiao_19" selectedIcon:@"tubiao_28" index:4];
    
}


// 添加一个Item
- (void)addOneInfoTabTitle:(NSString *)title icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon index:(int)index
{
    SCDockItem *dockItem = [[SCDockItem alloc] initWithFrame:CGRectMake(0, kDockItemH*index, self.bounds.size.width, 100)];
        [dockItem setTitle:title Icon:icon selectedIcon:selectedIcon];
    [dockItem setTitleColor:[UIColor hexStringToColor:@"#8c8c8c"] forState:UIControlStateNormal];
    [dockItem addTarget:self action:@selector(InfotabClick:) forControlEvents:UIControlEventTouchUpInside];
    dockItem.tag = index;
    [self addSubview:dockItem];
    
    if (index==0) {
        [dockItem setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    }else{
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, dockItem.bounds.size.height-1, self.bounds.size.width, 1)];
        [lineview setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
        [dockItem addSubview:lineview];
    }
    if (index == 1) {
        [self InfotabClick:dockItem];
        
    }
    
}

#pragma mark - item被点击通知代理
- (void)InfotabClick:(SCDockItem*)dockItem
{
    // 通知代理
    if ([_delegate respondsToSelector:@selector(InfoDock:tabChangeFrom:to:)]) {
        [_delegate InfoDock:self tabChangeFrom:_selectedItem.tag to:dockItem.tag];
    }
    
    // 1.控制状态
    _selectedItem.enabled = YES;
    dockItem.enabled = NO;
    _selectedItem = dockItem;
}



@end
