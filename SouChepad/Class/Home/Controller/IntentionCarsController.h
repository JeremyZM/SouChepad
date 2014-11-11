//
//  IntentionCarsController.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

// 需求分析

#import "SCBasicController.h"
@class IntentionCarsController;

@protocol IntentionCarsControllerDelegat <NSObject>

- (void)intentionCarsController:(IntentionCarsController *)controller carID:(NSString *)carid;

@end

@interface IntentionCarsController : SCBasicController

@property (nonatomic, weak) id <IntentionCarsControllerDelegat> deleget;
@end
