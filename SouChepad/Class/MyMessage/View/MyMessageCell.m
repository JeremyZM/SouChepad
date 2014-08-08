//
//  MyMessageCell.m
//  Athena
//
//  Created by zt on 14-8-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MyMessageCell.h"
#import "SystermMessage.h"
#import "UIImageView+WebCache.h"
#import "MyMessage.h"
#import "SystermMessage.h"
#import "MessageType.h"

@interface MyMessageCell(){
    __weak IBOutlet UILabel *unreadFlag;
    __weak IBOutlet UILabel *title;
    __weak IBOutlet UILabel *time;
    __weak IBOutlet UILabel *subTitle;
    id message;
    int messageType;
}

@end

@implementation MyMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = LoadNibWithName(@"MyMessageCell");
        viewroundCorner(unreadFlag, [UIColor clearColor], 1, 5);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    if (selected == YES) {
        if (messageType == kSystermMessage) {
            SystermMessage *sysMsg = message;
            sysMsg.isRead = @"1";
        }else{
            MyMessage *myMsg = message;
            myMsg.status = [NSNumber numberWithInt:1];
        }
        [self markMessageStatus];
    }
}

- (void)fillValueWithMessage:(id)msg type:(int)msgType{
    message = msg;
    messageType = msgType;
    if (msgType == kSystermMessage) {
        // 系统消息
        SystermMessage *sysMsg = msg;
        title.text = strNoNull(sysMsg.title);
        time.text = strNoNull(sysMsg.dateCreate);
        subTitle.text = strNoNull(sysMsg.comment);
    }else{
        // 个人消息
        MyMessage *myMsg = msg;
        title.text = strNoNull(myMsg.title);
        time.text = strNoNull(myMsg.displayTime);
        subTitle.text = strNoNull(myMsg.message);
    }
    
    [self markMessageStatus];
}

- (void)markMessageStatus{
    if (messageType == kSystermMessage) {
        SystermMessage *sysMsg = message;
        if ([sysMsg.isRead isEqualToString:@"1"]) {
            unreadFlag.hidden = YES;
        }else{
            unreadFlag.hidden = NO;
        }
    }else{
        MyMessage *myMsg = message;
        if ([myMsg.status intValue] == 1) {
            unreadFlag.hidden = YES;
        }else{
            unreadFlag.hidden = NO;
        }
    }
}
@end
