//
//  YushuanViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-18.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "YushuanViewController.h"

@interface YushuanViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
{
    UILabel *labe;
}
@property (nonatomic, strong) UIPickerView *minPicker;
@property (nonatomic, strong) UIPickerView *maxPicker;

@end

@implementation YushuanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.minPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 80, 120, 220)];
    [self.minPicker setDelegate:self];
    [self.minPicker setDelegate:self];
    [self.view addSubview:self.minPicker];
    
    labe = [[UILabel alloc] initWithFrame:CGRectMake(150, 180, 60, 20)];
    [labe setText:@"到"];
    [self.view addSubview:labe];
    
    self.maxPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(180, 80, 120, 220)];
    [self.maxPicker setDelegate:self];
    [self.maxPicker setDataSource:self];

    [self.view addSubview:self.maxPicker];
    

    for (NSInteger i = 0 ; i<self.array.count; i++) {
        if ([self.array[i] isEqualToString:[NSString stringWithFormat:@"%@万",self.beginSelect]]) {
            [self.minPicker selectRow:i inComponent:0 animated:NO];
            break;
        }
    }
    NSInteger a = 0;
    for (NSInteger j = 0; j<self.endArray.count; j++) {
        if ([self.endArray[j] isEqualToString:[NSString stringWithFormat:@"%@万",self.endSelect]]) {
            [self.maxPicker selectRow:j inComponent:0 animated:NO];
            a = 1;
            break;
        }
    }
    if (0==a) {
        [self.maxPicker selectRow:self.endArray.count-1 inComponent:0 animated:NO];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.minPicker) {
        
        return self.array.count;
    }else if (pickerView == self.maxPicker) {
        return self.endArray.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSString *str;
    if (pickerView == self.minPicker) {
        
        str = [NSString stringWithFormat:@"%@",self.array[row]];
    }else if (pickerView == self.maxPicker) {
        str = [NSString stringWithFormat:@"%@",self.endArray[row]];
    }

    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.minPicker) {
        if (row>[self.maxPicker selectedRowInComponent:0]) {
            [self.maxPicker selectRow:row-1 inComponent:0 animated:YES];
        }
    }else if (pickerView == self.maxPicker){
        if (row<[self.minPicker selectedRowInComponent:0]) {
            [self.minPicker selectRow:row+1 inComponent:0 animated:YES];
        }
    }
    if ([_delegate respondsToSelector:@selector(yuShuanViewController:selectCode:selectBeginStr:selectEndStr:)]) {
        NSString *startBudget = [self.array objectAtIndex:[self.minPicker selectedRowInComponent:0]];
        self.beginSelect = startBudget;
        NSString *endBudget = [self.endArray objectAtIndex:[self.maxPicker selectedRowInComponent:0]];
        self.endSelect = endBudget;
        [_delegate yuShuanViewController:self selectCode:[NSString stringWithFormat:@"%@-%@",startBudget,endBudget] selectBeginStr:startBudget selectEndStr:endBudget];

    }
    
    
}




@end
