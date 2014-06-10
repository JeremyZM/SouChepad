//
//  LogInViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "LogInViewController.h"
#import "HttpManager.h"
#import "MainViewController.h"
#import "SCTextfield.h"
#import "ProgressHUD.h"
#import "UIColor+_6jinzhi.h"

@interface LogInViewController () <UITextFieldDelegate>
{
    UIImageView *imageView;
    SCTextfield *nameTextField;
    SCTextfield *PWDTextField;
    UIButton *logInBtn;
}
@end

@implementation LogInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor hexStringToColor:KBackColo]];
    [self addUI];
    
}

- (void)addUI
{
    UIImage *image = [UIImage imageNamed:@"log_logo"];
    UIImage *imageH = [UIImage imageNamed:@"log_logohigth"];
    imageView = [[UIImageView alloc] initWithImage:image highlightedImage:imageH];
    [imageView setBounds:CGRectMake(0, 0, 144, 144)];
    CGPoint center = self.view.center;
    [imageView setCenter:CGPointMake(center.y, center.x-250)];

    [self.view addSubview:imageView];
    
    nameTextField = [[SCTextfield alloc] init];
    [nameTextField setBounds:CGRectMake(0, 0, 300, 44)];
    [nameTextField setCenter:CGPointMake(center.y, center.x-130)];
    [nameTextField setDelegate:self];
    [nameTextField setPlaceholder:@"账号"];
//    [nameTextField setText:@"lixuanxu"];
    [nameTextField setReturnKeyType:UIReturnKeyNext];

    [nameTextField setlaybyRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(5, 5)];
    
    [self.view addSubview:nameTextField];
    
    PWDTextField = [[SCTextfield alloc] initWithFrame:CGRectMake(nameTextField.frame.origin.x, CGRectGetMaxY(nameTextField.frame), 300, 44)];
    
    [PWDTextField setReturnKeyType:UIReturnKeyJoin];
    [PWDTextField setKeyboardType:UIKeyboardTypePhonePad];
    [PWDTextField setPlaceholder:@"密码"];
//    [PWDTextField setText:@"1234567890"];
    [PWDTextField setSecureTextEntry:YES];
    [PWDTextField setDelegate:self];

    [PWDTextField setlaybyRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(5, 5)];
    UIView *div1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
    div1.backgroundColor = [UIColor lightGrayColor];
    [PWDTextField addSubview:div1];
    [self.view addSubview:PWDTextField];
    
    logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logInBtn setTitle:@"去战斗吧！神鹰！" forState:UIControlStateNormal];
    [logInBtn setTitle:@"登陆中..." forState:UIControlStateSelected];
    [logInBtn.layer setMasksToBounds:YES];
    [logInBtn.layer setCornerRadius:5];
    [logInBtn setFrame:CGRectMake(PWDTextField.frame.origin.x, CGRectGetMaxY(PWDTextField.frame)+50, 300, 44)];
    [logInBtn setBackgroundImage:[UIImage imageNamed:@"dengluanniu1_60"] forState:UIControlStateNormal];
    [logInBtn setBackgroundImage:[UIImage imageNamed:@"denglu2"] forState:UIControlStateSelected];
    [logInBtn addTarget:self action:@selector(logInClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logInBtn];
    
    
    // 在-viewDidLoad方法中注册通知，监听键盘的弹出和收回
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark 键盘显示的监听方法
-(void) keyboardWillShow:(NSNotification *) note
{

    DLog(@"%d",[[UIApplication sharedApplication] statusBarOrientation]);
    if (self.view.frame.origin.x==0) {
        CGRect frmae = self.view.frame;
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            
            frmae.origin.x += 40;
        }else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft){
            frmae.origin.x -= 40;
        }
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.view setFrame:frmae];
        }];
    }
}


#pragma mark 键盘隐藏的监听方法
-(void) keyboardWillHide:(NSNotification *) note
{
    if (self.view.frame.origin.x !=0) {
        CGRect frmae = self.view.frame;
        
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            
            frmae.origin.x -= 40;
        }else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft){
            frmae.origin.x += 40;
        }
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.view setFrame:frmae];
        }];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == nameTextField) {
        [PWDTextField becomeFirstResponder];
    }else if (textField == PWDTextField){
        [self logInClick:nil];
    }
    return YES;
}


- (void)logInClick:(UIButton*)button
{


    if (nameTextField.text.length>=6&&PWDTextField.text.length>=6) {
        [imageView setHighlighted:YES];
        [logInBtn setSelected:YES];
        [nameTextField resignFirstResponder];
        [PWDTextField resignFirstResponder];
        [HttpManager requestLoginWithParamDic:@{@"loginName":nameTextField.text,@"password":PWDTextField.text,@"type":@"saler"} Success:^(id obj) {
            NSString *isok = obj;
            if ([isok isEqualToString:@"true"]) {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:nameTextField.text forKey:userDefaultsName];
                [userDefaults setObject:PWDTextField.text forKey:userDefaultsPWD];
                [userDefaults synchronize];
                
                [NSThread sleepForTimeInterval:1.0];
                MainViewController *controller = [[MainViewController alloc]init];
                [self.view.window setRootViewController:controller];
                [logInBtn setSelected:NO];
            }else{
                [logInBtn setSelected:NO];
                [imageView setHighlighted:NO];
                [ProgressHUD showError:@"请确认账号或密码！"];
                
            }
        } fail:^(id obj) {
            [logInBtn setSelected:NO];
            [imageView setHighlighted:NO];
//            [ProgressHUD showError:@"请确认账号或密码！"];
//            [SCHudManager showHudWithImage:nil title:@"请确认账号或密码！"];
            DLog(@"errer%@",obj);
        }];
        

    }
    
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
