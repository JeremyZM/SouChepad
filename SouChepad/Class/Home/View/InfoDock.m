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
    }
    return self;
}

- (void)addAllInfoItems
{
    // 1.我的客户
    [self addOneInfoTabTitle:@"返回" icon:@"" selectedIcon:@"" index:0];
    
    // 2.我的车辆
    [self addOneInfoTabTitle:@"个人信息" icon:@"" selectedIcon:@"" index:1];
    
    // 3.意向车辆
    [self addOneInfoTabTitle:@"意向车辆" icon:@"" selectedIcon:@"" index:2];
    
    
    // 4.沟通记录
    [self addOneInfoTabTitle:@"沟通记录" icon:@"" selectedIcon:@"" index:3];
    
    // 4.逛店找车
    [self addOneInfoTabTitle:@"逛店找车" icon:@"" selectedIcon:@"" index:4];

}


// 添加一个Item
- (void)addOneInfoTabTitle:(NSString *)title icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon index:(int)index
{
    SCDockItem *dockItem = [[SCDockItem alloc] initWithFrame:CGRectMake(0, kDockItemH*index, self.bounds.size.width, kDockItemH)];
    [dockItem setTitle:title Icon:icon selectedIcon:selectedIcon];
    [dockItem addTarget:self action:@selector(InfotabClick:) forControlEvents:UIControlEventTouchUpInside];
    dockItem.tag = index;
    [self addSubview:dockItem];
    
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
