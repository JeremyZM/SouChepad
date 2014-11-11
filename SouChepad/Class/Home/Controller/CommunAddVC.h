//
//  CommunAddVC.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReservationM.h"
@class CommunAddVC;
@class BusinessVO;

@protocol CommunAddVCDelegate <NSObject>

- (void)communAddVC:(CommunAddVC*)commumVC ReservationDateByUser:(NSDictionary *)dic;

@end

@interface CommunAddVC : UIViewController


@property (nonatomic, strong) UserReservationM *userResM;
@property (nonatomic, weak) id<CommunAddVCDelegate> delegate;
@end
