//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities;
}

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;



-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (id)initWithdelegate:(id<HZAreaPickerDelegate>)delegate HZlocation:(HZLocation *)locate
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.delegate = delegate;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        _locate = locate;
        //加载数据
        provinces = [NSArray arrayWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"allCitys.plist"]];
        
        for (NSInteger i = 0; i<provinces.count; i++) {
            NSDictionary *provinDic = provinces[i];
            if ([self.locate.stateCode isEqualToString:[provinDic objectForKey:@"code"]]) {
                [self.locatePicker selectRow:i inComponent:0 animated:NO];
                cities = [[provinces objectAtIndex:i] objectForKey:@"dic"];
                break;
            }
        }
        if (self.locate.stateCode== nil) {
            cities = [[provinces objectAtIndex:0] objectForKey:@"dic"];
        }
        for (NSInteger j = 0; j <cities.count; j++) {
            NSDictionary *citieDic = cities[j];
            if ([self.locate.cityCode isEqualToString:[citieDic objectForKey:@"code"]]) {
                [self.locatePicker selectRow:j inComponent:1 animated:NO];
                break;
            }
        }
                [self.locatePicker selectRow:3 inComponent:1 animated:NO];
        
//        self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"name"];
//        self.locate.stateCode = [[provinces objectAtIndex:0] objectForKey:@"code"];
//        self.locate.city = [[cities objectAtIndex:0] objectForKey:@"name"];
//        self.locate.cityCode = [[cities objectAtIndex:0] objectForKey:@"code"];
    }
        
    return self;
    
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
            cities = [[provinces objectAtIndex:row] objectForKey:@"dic"];
            [self.locatePicker selectRow:0 inComponent:1 animated:YES];
            [self.locatePicker reloadComponent:1];
            
            self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"name"];
            self.locate.stateCode = [[provinces objectAtIndex:row] objectForKey:@"code"];
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"name"];
            self.locate.cityCode = [[cities objectAtIndex:0] objectForKey:@"code"];
            break;
        case 1:
            self.locate.city = [[cities objectAtIndex:row] objectForKey:@"name"];
            self.locate.cityCode = [[cities objectAtIndex:row] objectForKey:@"code"];
            break;
        default:
            break;
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }

}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
