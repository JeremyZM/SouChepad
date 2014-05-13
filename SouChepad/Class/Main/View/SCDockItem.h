//
//  SCDockItem.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCDockItem : UIButton

- (void)setTitle:(NSString *)title Icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;

@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *icon; // 普通图片
@property (nonatomic, copy) NSString *selectedIcon; // 选中图片
@end
