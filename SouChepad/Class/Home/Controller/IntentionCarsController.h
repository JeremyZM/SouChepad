//
//  IntentionCarsController.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SCBasicController.h"
@class IntentionCarsController;
@class UserReservationM;

@protocol IntentionCarsControllerDelegat <NSObject>

- (void)intentionCarsController:(IntentionCarsController *)controller carID:(NSString *)carid;

@end

@interface IntentionCarsController : SCBasicController
@property (nonatomic, strong) UserReservationM *userReserM;
@property (nonatomic, assign) BOOL isNew;

@property (nonatomic, weak) id <IntentionCarsControllerDelegat> deleget;
@end
