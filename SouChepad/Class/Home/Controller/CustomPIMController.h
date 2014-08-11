//
//  CustomPIMController.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SCBasicController.h"

@class UserReservationM;
@interface CustomPIMController : SCBasicController
@property (nonatomic, strong) UserReservationM *userInfoM;

- (void)saveUserInfoClickt;

@end
