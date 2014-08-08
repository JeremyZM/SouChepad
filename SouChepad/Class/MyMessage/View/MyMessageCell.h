//
//  MyMessageCell.h
//  Athena
//
//  Created by zt on 14-8-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MyMessage;

@interface MyMessageCell : UITableViewCell
- (void)fillValueWithMessage:(MyMessage*)msg;
- (void)markMessageAsRead:(BOOL)read;
@end
