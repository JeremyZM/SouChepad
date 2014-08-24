//
//  CityPickViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CityPickViewController.h"
//#import "HZAreaPickerView.h"

@interface CityPickViewController () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *provinces, *cities;
    NSInteger a ,b;
}
@property (strong, nonatomic) UIPickerView *locatePicker;

@end

@implementation CityPickViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //加载数据
    provinces = [NSArray arrayWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"allCitys.plist"]];
    for (NSInteger i = 0; i<provinces.count; i++) {
        NSDictionary *provinDic = provinces[i];
        if ([self.hzLocat.stateCode isEqualToString:[provinDic objectForKey:@"code"]]) {
            a = i;
            cities = [NSArray arrayWithArray:[[provinces objectAtIndex:i] objectForKey:@"dic"]];
            break;
        }
    }
    
    if (self.hzLocat.stateCode== nil) {
        cities = [NSArray arrayWithArray:[[provinces objectAtIndex:0] objectForKey:@"dic"]];;
    }
    for (NSInteger j = 0; j <cities.count; j++) {
        NSDictionary *citieDic = cities[j];
        if ([self.hzLocat.cityCode isEqualToString:[citieDic objectForKey:@"code"]]) {
            b= j;
            break;
        }
    }

    self.locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, 450, 260)];
    [self.locatePicker setDelegate:self];
    [self.locatePicker setDataSource:self];
    [self.view addSubview:self.locatePicker];
//    [self.locatePicker setFrame:CGRectMake(0, 30, 450, 260)];
    [self.locatePicker setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
   [self.locatePicker selectRow:a inComponent:0 animated:NO];
    [self.locatePicker selectRow:b inComponent:1 animated:NO];
}


#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[provinces objectAtIndex:row] objectForKey:@"name"];
            break;
        case 1:
            return [[cities objectAtIndex:row] objectForKey:@"name"];
            break;
        default:
            return @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            cities = [NSArray arrayWithArray:[[provinces objectAtIndex:row] objectForKey:@"dic"]];
            [self.locatePicker selectRow:0 inComponent:1 animated:YES];
            [self.locatePicker reloadComponent:1];
            
            self.hzLocat.state = [[provinces objectAtIndex:row] objectForKey:@"name"];
            self.hzLocat.stateCode = [[provinces objectAtIndex:row] objectForKey:@"code"];
            self.hzLocat.city = [[cities objectAtIndex:0] objectForKey:@"name"];
            self.hzLocat.cityCode = [[cities objectAtIndex:0] objectForKey:@"code"];
            break;
        case 1:
            self.hzLocat.city = [[cities objectAtIndex:row] objectForKey:@"name"];
            self.hzLocat.cityCode = [[cities objectAtIndex:row] objectForKey:@"code"];
            break;
        default:
            break;
    }
    
    if ([_delegate respondsToSelector:@selector(cityPickView:HZlocation:)]) {
        [_delegate cityPickView:self HZlocation:self.hzLocat];
    }
    
}

@end
