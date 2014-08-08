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

@interface MyMessageCell(){
    
    __weak IBOutlet UILabel *unreadFlag;
    __weak IBOutlet UILabel *title;
    __weak IBOutlet UILabel *time;
    __weak IBOutlet UILabel *subTitle;
}

@end

@implementation MyMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = LoadNibWithName(@"MyMessageCell");
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

- (void)fillValueWithMessage:(SystermMessage*)msg{
    title.text = strNoNull(msg.title);
    time.text = strNoNull(msg.dateCreate);
    subTitle.text = strNoNull(msg.comment);
}

- (void)markMessageAsRead:(BOOL)read{
    unreadFlag.hidden = read;
}
@end
