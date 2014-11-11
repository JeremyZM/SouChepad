//
//  UIView+ParentController.m
//  MaicheShenqi
//
//  Created by zt on 14-4-21.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "UIView+ParentController.h"

@implementation UIView (ParentController)
// 获取view的Controller
- (UIViewController*)viewController{
    for (UIView* next = [self superview]; next; next = next.superview){
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
