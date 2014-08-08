//
//  MyMessageCell.h
//  Athena
//
//  Created by zt on 14-8-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SystermMessage;

@interface MyMessageCell : UITableViewCell
- (void)fillValueWithMessage:(SystermMessage*)msg;
- (void)markMessageAsRead:(BOOL)read;
@end