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
    
    
//    UILabel *buxian = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 80, 30)];
//    [buxian setText:@"预算不限"];
//    [self.view addSubview:buxian];
//    
//    UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(150, 30, 80, 30)];
//    [swi addTarget:self action:@selector(hidePicker:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:swi];
    
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
//    [self.maxPicker selectRow:self.array.count-1 inComponent:0 animated:NO];
    [self.view addSubview:self.maxPicker];
    
    if (self.seleckBut.tag==2000) {
        [self.minPicker selectRow:[self.beginSelect integerValue] inComponent:0 animated:NO];
        if (self.endSelect&&![self.endSelect isEqualToString:@"暂无"]) {
            
            [self.maxPicker selectRow:[self.endSelect integerValue] inComponent:0 animated:NO];
        }else {
            [self.maxPicker selectRow:self.array.count-1 inComponent:0 animated:NO];
        }
    }else if (self.seleckBut.tag==2006){

        if (self.beginSelect&&!([self.beginSelect isEqualToString:@"暂无"])) {
            
            [self.minPicker selectRow:[self.beginSelect integerValue]-2005 inComponent:0 animated:NO];
        }
        if (self.endSelect&&![self.endSelect isEqualToString:@"暂无"]) {
            
            [self.maxPicker selectRow:[self.endSelect integerValue]-2005 inComponent:0 animated:NO];
        }else{
            [self.maxPicker selectRow:self.array.count-1 inComponent:0 animated:NO];
        }
    }

}


//- (void)hidePicker:(UISwitch*)swit
//{
//    if (swit.on) {
//        [self.maxPicker setHidden:YES];
//        [self.minPicker setHidden:YES];
//        [labe setHidden:YES];
//        if ([_delegate respondsToSelector:@selector(yuShuanViewController:selectCode:selectStr:)]) {
//            NSString *startBudget = [self.array objectAtIndex:[self.minPicker selectedRowInComponent:0]];
//            NSString *endBudget = [self.array objectAtIndex:[self.maxPicker selectedRowInComponent:0]];
//            [_delegate yuShuanViewController:self selectCode:[NSString stringWithFormat:@"%@-%@",startBudget,endBudget] selectStr:@"不限"];
//        }
//
//    }else {
//        [labe setHidden:NO];
//        [self.maxPicker setHidden:NO];
//        [self.minPicker setHidden:NO];
//        
//        if ([_delegate respondsToSelector:@selector(yuShuanViewController:selectCode:selectStr:)]) {
//            NSString *startBudget = [self.array objectAtIndex:[self.minPicker selectedRowInComponent:0]];
//            NSString *endBudget = [self.array objectAtIndex:[self.maxPicker selectedRowInComponent:0]];
//            [_delegate yuShuanViewController:self selectCode:[NSString stringWithFormat:@"%@-%@",startBudget,endBudget] selectStr:[NSString stringWithFormat:@"%@ - %@",startBudget,endBudget]];
//        }
//    }
//}
//

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    if (pickerView == self.maxPicker) {
//        return self.array[self.array.count-1-row];
//    }
    NSString *str;
    if (self.seleckBut.tag==2000) {
        str = [NSString stringWithFormat:@"%@",self.array[row]];
    }else if (self.seleckBut.tag == 2006){
        str = [NSString stringWithFormat:@"%@",self.array[row]];
    }
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.minPicker) {
        if (row>[self.maxPicker selectedRowInComponent:0]) {
            [self.maxPicker selectRow:row inComponent:0 animated:YES];
        }
    }else if (pickerView == self.maxPicker){
        if (row<[self.minPicker selectedRowInComponent:0]) {
            [self.minPicker selectRow:row inComponent:0 animated:YES];
        }
    }
    if ([_delegate respondsToSelector:@selector(yuShuanViewController:selectCode:selectBeginStr:selectEndStr:)]) {
        NSString *startBudget = [self.array objectAtIndex:[self.minPicker selectedRowInComponent:0]];
        self.beginSelect = startBudget;
        NSString *endBudget = [self.array objectAtIndex:[self.maxPicker selectedRowInComponent:0]];
        self.endSelect = endBudget;
        [_delegate yuShuanViewController:self selectCode:[NSString stringWithFormat:@"%@-%@",startBudget,endBudget] selectBeginStr:startBudget selectEndStr:endBudget];
//        [_delegate yuShuanViewController:self selectCode:[NSString stringWithFormat:@"%@-%@",startBudget,endBudget] selectStr:[NSString stringWithFormat:@"%@ - %@",startBudget,endBudget]];
    }
    
    
}




@end
