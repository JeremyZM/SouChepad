//
//  ChangeTimePopoVC.h
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReservationM.h"

@interface ChangeTimePopoVC : UIViewController

@property (nonatomic, strong) UIButton *dateBut;
@property (nonatomic, strong) UIDatePicker *datepicker;

/**
 *  上午，下午，晚上
 */
@property (nonatomic, strong) UIPickerView *periodPicker;

@property (nonatomic, strong) UserReservationM *userResM;

@end
