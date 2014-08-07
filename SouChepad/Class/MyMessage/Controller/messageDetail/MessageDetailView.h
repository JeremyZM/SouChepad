//
//  SCWebViewController.h
//  TestUIWebView
//
//  Created by zt on 14-8-7.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDetailView.h"

@interface MessageDetailView : UIView
- (id)initWithMessage:(id)message frame:(CGRect)frame;
- (void)setMessageDetail:(id)message;
@end
