//
//  CommListController.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-7.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserReservationM;

@interface CommListController : UIViewController
@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, strong) UserReservationM *userResM;

@end
