//
//  BusinessCell.h
//  Athena
//
//  Created by zt on 14-10-21.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@protocol BusinessCellDelegate <NSObject>
@required
- (void)businessDidLoad:(NSString*)totalItem;
@end

@interface BusinessCell : UITableViewCell

@property (nonatomic,strong) SwipeView *swipeView;

@property (nonatomic,weak) id<BusinessCellDelegate> delegate;

- (void)requestBusinessInfo;
@end
