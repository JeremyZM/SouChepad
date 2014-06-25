//
//  ChangeTimePopoVC.h
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReservationM.h"
@class ChangeTimePopoVC;

@protocol ChangeTimePopoDelegate <NSObject>

- (void)ChangeTimePopoVC:(ChangeTimePopoVC*)changeTVC changeTimeDic:(NSDictionary *)dateDic;

@end

@interface ChangeTimePopoVC : UIViewController

@property (nonatomic, strong) UIButton *dateBut;
@property (nonatomic, strong) UIDatePicker *datepicker;
@property (nonatomic, weak) id<ChangeTimePopoDelegate> delegate;
/**
 *  上午，下午，晚上
 */
@property (nonatomic, strong) UIPickerView *periodPicker;

@property (nonatomic, strong) UserReservationM *userResM;

@end
