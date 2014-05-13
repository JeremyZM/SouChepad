//
//  FZInfoView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-5.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "FZInfoView.h"
#import "PopoTableViewController.h"
#import "KeyboardTool.h"

@interface FZInfoView () <UITableViewDataSource,UITableViewDelegate,PopoTableViewDelegate,KeyboardToolDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
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

@implementation FZInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    
    switch (indexPath.row) {
        case 0:
            self.laiyuanB = [self addChooseBut];
            [self.laiyuanB setTag:800];
            [cell.contentView addSubview:self.laiyuanB];
            break;
        case 1:
            self.QQF = [self addTextField];
            [self.QQF setTag:801];
            [cell.contentView addSubview:self.QQF];
            [self.textFiledArray addObject:self.QQF];
            break;
        case 2:
            self.weixinF = [self addTextField];
            [self.weixinF setTag:802];
            [cell.contentView addSubview:self.weixinF];
            [self.textFiledArray addObject:self.weixinF];
            break;
        case 3:
            self.mailF = [self addTextField];
            [self.mailF setTag:803];
            [cell.contentView addSubview:self.mailF];
            [self.textFiledArray addObject:self.mailF];
            break;
        case 4:
            self.TelF = [self addTextField];
            [self.TelF setTag:804];
            [cell.contentView addSubview:self.TelF];
            [self.textFiledArray addObject:self.TelF];
            break;
        case 5:
            self.birthdayB = [self addChooseBut];
            [self.birthdayB setTag:805];
            [cell.contentView addSubview:self.birthdayB];
            break;
        case 6:
            self.ageB = [self addChooseBut];
            [self.ageB setTag:806];
            [cell.contentView addSubview:self.ageB];
            break;
        case 7:
            self.IDCardNumberF = [self addTextField];
            [self.IDCardNumberF setTag:807];
            [cell.contentView addSubview:self.IDCardNumberF];
            [self.textFiledArray addObject:self.IDCardNumberF];
            break;
        case 8:
            self.addressB = [self addChooseBut];
            [self.addressB setTag:808];
            [cell.contentView addSubview:self.addressB];
            break;
        case 9:
            
            break;
        case 10:
            
            break;
            
            default:
            break;
    }
    
    
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
    
    if (index==	2) {
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
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"111111";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    

    
    
}




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

- (UIButton*)addChooseBut
{
    UIButton *source = [UIButton buttonWithType:UIButtonTypeCustom];
    [source setFrame:CGRectMake(150, 15, 100, 30)];
    [source.layer setBorderWidth:1.0];
    [source.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [source.layer setCornerRadius:10.0];
    [source setTitle:@"请选择" forState:UIControlStateNormal];
    [source setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [source addTarget:self action:@selector(choosePopoClick:) forControlEvents:UIControlEventTouchUpInside];
    return source;
}

- (void)choosePopoClick:(UIButton*)but
{
    PopoTableViewController *popo = [[PopoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [popo setPopoTabelDelegate:self];
    popo.sortWayBtn = but;
    if (but.tag == 806) {
        popo.selectRow = ratselectRow;
    }else if(but.tag == 800){
         popo.selectRow = nameSelectRow;
    }
    popoVC = [[UIPopoverController alloc] initWithContentViewController:popo];
    
    CGRect frame = [self convertRect:but.frame fromView:but.superview];
    popoVC.popoverContentSize = CGSizeMake(320, 240);
    [popoVC presentPopoverFromRect:frame inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)PopoTableViewController:(PopoTableViewController *)popoTableVC seleckChanged:(NSString *)seleckStr andseleckRow:(NSInteger)row andselectBtn:(UIButton *)selecBtn
{
    if (selecBtn.tag==800) {
        nameSelectRow = row;

    } else if (selecBtn.tag==806) {//按等级筛选
        ratselectRow = row;
    
    }
    [selecBtn setTitle:seleckStr forState:UIControlStateNormal];
    [selecBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selecBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [popoVC dismissPopoverAnimated:YES];
}

@end
