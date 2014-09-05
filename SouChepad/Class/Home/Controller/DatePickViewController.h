//
//  DatePickViewController.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DatePickViewController;

@protocol DatePickerVCdelegate <NSObject>

- (void)datePickerVC:(DatePickViewController *)datePickVC  dateStr:(NSString *)datestr;

@end

@interface DatePickViewController : UIViewController

@property (nonatomic, strong) NSDate *datesele;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, weak) id<DatePickerVCdelegate>delegate;

@end
