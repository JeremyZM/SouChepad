//
//  SCDock.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SCDock.h"
#import "SCDockItem.h"

@interface SCDock ()
{
    SCDockItem *_selectedItem; // 被选中的标签
}

@end

@implementation SCDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 添加所有Item
        [self addAllItems];
    }
    return self;
}

#pragma mark -  添加所有Item
- (void)addAllItems
{
    // 1.我的客户
    [self addOneTabTitle:@"我的客户" icon:@"tubiao_03" selectedIcon:@"tubiao_10" index:0];
    
    
    // 2.我的消息
    [self addOneTabTitle:@"我的消息" icon:@"tubiao_04" selectedIcon:@"tubiao_11" index:1];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:KisExecutive]) {
        // 3.我的车辆
        [self addOneTabTitle:@"回访报表" icon:@"tubiao_05" selectedIcon:@"tubiao_12" index:2];        
    }
 
    // 4.工具
//    [self addOneTabTitle:@"服务工具" icon:@"tubiao_06" selectedIcon:@"tubiao_13" index:3];
    
//    [self addOneTabTitle:@"知识话术" icon:@"tubiao_07" selectedIcon:@"tubiao_14" index:4];
    
    // 5.设置
    [self addOneTabTitle:@"设置" icon:@"tubiao_08" selectedIcon:@"tubiao_15" index:5];
    

}

// 添加一个Item
- (void)addOneTabTitle:(NSString *)title icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon index:(int)index
{
    SCDockItem *dockItem = [[SCDockItem alloc] initWithFrame:CGRectMake(0, kDockItemH*index+50, KDockW, kDockItemH)];
    [dockItem setTitle:title Icon:icon selectedIcon:selectedIcon];
    [dockItem addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
    dockItem.tag = index;
    [self addSubview:dockItem];
    
    if (index == 0) {
        [self tabClick:dockItem];
    }

}

#pragma mark - item被点击通知代理
- (void)tabClick:(SCDockItem*)dockItem
{
    // 通知代理
    if ([_delegate respondsToSelector:@selector(SCDock:tabChangeFrom:to:)]) {
        [_delegate SCDock:self tabChangeFrom:_selectedItem.tag to:dockItem.tag];
    }
    
    // 1.控制状态
    _selectedItem.enabled = YES;
    dockItem.enabled = NO;
    _selectedItem = dockItem;
}

@end
