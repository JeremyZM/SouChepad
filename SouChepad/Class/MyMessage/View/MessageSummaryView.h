//
//  SummaryView.h
//  Athena
//
//  Created by zt on 14-8-11.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageSummaryViewDelegate <NSObject>

@required
- (void)messageCellDidSelectedAtIndex:(int)index data:(id)obj;

@end

@interface MessageSummaryView : UIView

@property (nonatomic,assign) id<MessageSummaryViewDelegate> cellDelegate;
// 获取系统消息或者我的消息
- (void)requestMessageWithType:(int)type;
@end
