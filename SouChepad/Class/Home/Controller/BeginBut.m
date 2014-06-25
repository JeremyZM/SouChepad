//
//  BeginBut.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-24.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "BeginBut.h"

@implementation BeginBut

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setBackgroundColor:[UIColor redColor]];
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    
    [super setFrame:frame];
}


//#pragma mark - 设置按钮内部的图片
//- (void)setTitle:(NSString *)title Icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
//{
//    self.icon = icon;
//    self.selectedIcon = selectedIcon;
//    self.title = title;
//}

- (void)setTitle:(NSString *)title
{
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setIcon:(NSString *)icon
{
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setSelectedIcon:(NSString *)selectedIcon
{
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateDisabled];
}

#pragma mark 覆盖父类在highlighted时的所有操作
- (void)setHighlighted:(BOOL)highlighted {
    //    [super setHighlighted:highlighted];
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 10;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * ( 1- kTitleRatio );
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight-10;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}


@end