//
//  EndReceiveViewController.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReservationM.h"

@class EndReceiveViewController;

@protocol EndReceiveDelegate <NSObject>

- (void)endReceiveController:(EndReceiveViewController*)endReceiveVC;

@end

@interface EndReceiveViewController : UIViewController
@property (nonatomic, strong) UserReservationM *userInfoM;
@property (nonatomic, weak) id<EndReceiveDelegate> delegate;
@end
