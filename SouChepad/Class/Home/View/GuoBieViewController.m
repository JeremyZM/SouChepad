//
//  GuoBieViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-18.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "GuoBieViewController.h"
#import "CYCustomMultiSelectPickerView.h"

@interface GuoBieViewController () <CYCustomMultiSelectPickerViewDelegate>
{
    CYCustomMultiSelectPickerView *multiPickerView;
}


@end

@implementation GuoBieViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *buxian = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 80, 30)];
    [buxian setText:@"预算不限"];
    [self.view addSubview:buxian];
    
    UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(150, 30, 80, 30)];
    [swi addTarget:self action:@selector(hidePicker:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:swi];
    
    multiPickerView = [[CYCustomMultiSelectPickerView alloc] initWithFrame:CGRectMake(0,80, 320, 260)];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dic in self.entries) {
        [arrayM addObject:[dic objectForKey:@"name"]];
    }
    
    multiPickerView.backgroundColor = [UIColor clearColor];
    multiPickerView.entriesArray = arrayM;
    multiPickerView.entriesSelectedArray = _entriesSelected;
    multiPickerView.multiPickerDelegate = self;
    
    [self.view addSubview:multiPickerView];
    [multiPickerView pickerShow];
    
}

- (void)hidePicker:(UISwitch*)swit
{
    if (swit.on) {
        
        [multiPickerView setHidden:YES];
        multiPickerView.multiPickerDelegate = nil;
    }else {
        multiPickerView.multiPickerDelegate = self;
        [multiPickerView setHidden:NO];
    }
}




#pragma mark - Delegate
//获取到选中的数据
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr
{
    NSLog(@"selectedArray=%@",selectedEntriesArr);
    
    // 再次初始化选中的数据
    _entriesSelected = [NSArray arrayWithArray:selectedEntriesArr];
}

@end
