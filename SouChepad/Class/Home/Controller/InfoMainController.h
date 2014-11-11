//
//  InfoMainController.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//


/**
 *      用户页面，主要包括 个人信息，一些车辆，沟通记录，需求分析，客户轨迹
 *
 */

#import <UIKit/UIKit.h>
@class UserReservationM;
@class BeginBut;

@interface InfoMainController : UIViewController
@property (nonatomic, strong) UserReservationM *userInfoM;
@property (nonatomic, assign) BOOL inHand;
@property (nonatomic, strong)  BeginBut *beginBtn;
@end
