//
//  KeyboardTool.m
//  键盘输入
//
//  Created by apple on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "KeyboardTool.h"

@implementation KeyboardTool

#pragma mark 实例化助手视图
+ (id)keyboardTool
{
    // 从XIB中加载一组平行的视图数组，然后从中找到定义好的键盘助手视图
    // 在本示例中，只有一个视图
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"KeyboardTool" owner:nil options:nil];

    return array.lastObject;
}

#pragma mark - 按钮操作
- (IBAction)clickPrev:(UIBarButtonItem *)sender
{
    [_toolDelegate keyboardTool:self buttonType:kKeyboardToolButtonPrev];
}

- (IBAction)clickNext:(id)sender
{
    [_toolDelegate keyboardTool:self buttonType:kKeyboardToolButtonNext];
}

- (IBAction)clickDone:(UIBarButtonItem *)sender
{
    [_toolDelegate keyboardTool:self buttonType:kKeyboardToolButtonDone];
}

@end
