//
//  CityPickViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CityPickViewController.h"
#import "HZAreaPickerView.h"

@interface CityPickViewController () <HZAreaPickerDelegate>

@property (strong, nonatomic) HZAreaPickerView *locatePicker;

@end

@implementation CityPickViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locatePicker = [[HZAreaPickerView alloc] initWithdelegate:self HZlocation:self.hzLocat];
    [self.locatePicker setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
    [self.view addSubview:self.locatePicker];
    [self.locatePicker setFrame:CGRectMake(0, 30, 450, 260)];
}

- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if ([_delegate respondsToSelector:@selector(cityPickView:HZlocation:)]) {
        [_delegate cityPickView:self HZlocation:picker.locate];
//        [_delegate cityPickView:self state:picker.locate.state city:picker.locate.city];
    }
//    [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
}

@end
