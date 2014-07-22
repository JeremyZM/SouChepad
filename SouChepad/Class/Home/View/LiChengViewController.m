//
//  LiChengViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-18.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "LiChengViewController.h"

@interface LiChengViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSInteger _row;
}
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation LiChengViewController



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
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, 0,0)];
    [self.pickerView setDataSource:self];
    [self.pickerView setDelegate:self];
    [self.view addSubview:self.pickerView];
}

//- (void)hidePicker:(UISwitch*)swit
//{
//    [self.pickerView setHidden:swit.on];
//    
//    if (swit.on) {
//        if ([_delegate respondsToSelector:@selector(liChengViewController:selectBut:selectDic:)]) {
//            [_delegate liChengViewController:self selectBut:self.selectButton selectDic:@{@"name":@"不限"}];
//        }
//    }else {
//        if ([_delegate respondsToSelector:@selector(liChengViewController:selectBut:selectDic:)]) {
//            NSDictionary *dic = self.dataArray[_row];
//            [_delegate liChengViewController:self selectBut:self.selectButton selectDic:dic];
//        }
//    }
//
//}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *dic = self.dataArray[row];
    
    return [dic objectForKey:@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _row = row;
    if ([_delegate respondsToSelector:@selector(liChengViewController:selectBut:selectDic:)]) {
        
        NSDictionary *dic = self.dataArray[row];
        [_delegate liChengViewController:self selectBut:self.selectButton selectDic:dic];
    }
}

@end
