//
//  InfoMainController.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserReservationM;

@interface InfoMainController : UIViewController
@property (nonatomic, strong) UserReservationM *userInfoM;
@property (nonatomic, assign) BOOL inHand;
@end
