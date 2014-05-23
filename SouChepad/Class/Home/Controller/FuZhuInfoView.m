//
//  FuZhuInfoView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-6.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "FuZhuInfoView.h"
#import "KeyboardTool.h"


@interface FuZhuInfoView()<KeyboardToolDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_fzInfoTable;
    NSArray *_dataArray;
    
    NSInteger ratselectRow; // 等级选中的行
    NSInteger nameSelectRow; // 时间，姓名选中行
    
    UIPopoverController *popoVC;
    
    UIPickerView  *_languagePicker;
}

// 键盘工具自定义视图
@property (strong, nonatomic) KeyboardTool *keyboardTool;

// 建立所有文本输入控件的数组
@property (strong, nonatomic) NSMutableArray *textFiledArray;

// 用户选中的文本框
@property (weak, nonatomic) UITextField *selectedTextField;
@end

@implementation FuZhuInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _fzInfoTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_fzInfoTable setDelegate:self];
        [_fzInfoTable setDataSource:self];
        [_fzInfoTable setScrollEnabled:NO];
        [_fzInfoTable setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self addSubview:_fzInfoTable];
        
        self.keyboardTool = [KeyboardTool keyboardTool];
        [self.keyboardTool setToolDelegate:self];
        
        self.textFiledArray = [NSMutableArray array];
        
        UIPickerView *languagePicker = [[UIPickerView alloc] init];
        [languagePicker setDelegate:self];
        [languagePicker setDataSource:self];
        [languagePicker setShowsSelectionIndicator:YES];
        [languagePicker setBackgroundColor:[UIColor whiteColor]];
        _languagePicker = languagePicker;
        
        _dataArray = @[@"来源",@"QQ",@"微信",@"邮箱",@"座机",@"生日",@"年龄段",@"身份证",@"所在地",@"优惠信息",@"证件上传"];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.textLabel setText:_dataArray[indexPath.row]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
    UITextField *IDCardNumberF = [self addTextField];

    [cell.contentView addSubview:IDCardNumberF];
    [self.textFiledArray addObject:IDCardNumberF];
    return cell;
}

- (void)keyboardTool:(KeyboardTool *)keyboard buttonType:(KeyboardToolButtonType)buttonType
{
    /**
     上一个&下一个文本控件的切换
     */
    if (kKeyboardToolButtonDone == buttonType) {
        // 关闭键盘
        [self hideKeyboard];
    } else {
        // 1. 获取当前选中的文本控件
        // 2. 获取当前空间在数组中的索引
        NSUInteger index = [self.textFiledArray indexOfObject:self.selectedTextField];
        
        if (kKeyboardToolButtonNext == buttonType) {
            index++;
        } else {
            index--;
        }
        
        UITextField *textField = self.textFiledArray[index];
        
        [textField becomeFirstResponder];
    }
}


- (void)hideKeyboard
{
    
    [UIView animateWithDuration:0.25f animations:^{
        [self endEditing:YES];
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark textField代理方法
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 记录当前选中的文本框
    self.selectedTextField = textField;
    
    NSUInteger index = [self.textFiledArray indexOfObject:textField];
    
    if (index==	0||index==5) {
        [textField setInputView:_languagePicker];
    }
    
    // 如果是数组中第一个文本框，禁用上一个按钮
    self.keyboardTool.prevButton.enabled = (index != 0);
    // 如果是数组中最后一个文本框，禁用下一个按钮
    self.keyboardTool.nextButton.enabled = (index != self.textFiledArray.count - 1);
}


#pragma mark -
// 设置数据列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 50;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"111111";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    
    
}

/*
 - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
 {
 return 2;
 }
 - (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
 {
 if (component == kProvinceComponent) {
 return [self.provinces count];
 }
 return [self.cities count];
 }
 #pragma mark Picker Delegate Methods
 - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 
 if (component == kProvinceComponent) {
 return [self.provinces objectAtIndex:row];
 }
 return [self.cities objectAtIndex:row];
 }
 - (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
 {
 if (component == kProvinceComponent) {
 NSString *selectedState = [self.provinces objectAtIndex:row];
 NSArray *array = [provinceCities objectForKey:selectedState];
 self.cities = array;
 [picker selectRow:0 inComponent:kCityComponent animated:YES];
 [picker reloadComponent:kCityComponent];
 }
 }
 - (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
 {
 if (component == kCityComponent) {
 return 150;
 }
 return 140;
 }

 
 */


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITextField*)addTextField
{
    UITextField *textf = [[UITextField alloc] initWithFrame:CGRectMake(150, 0, 600, 60)];
    [textf setDelegate:self];
    [textf setInputAccessoryView:self.keyboardTool];
    [textf setPlaceholder:@"请填写"];
    [textf setFont:[UIFont systemFontOfSize:22]];
    return textf;
}


@end
