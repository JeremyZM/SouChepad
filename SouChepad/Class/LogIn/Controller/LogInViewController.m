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
//#import "SCHudManager.h"
#import "ProgressHUD.h"

@interface LogInViewController () <UITextFieldDelegate>
{
    UIImageView *imageView;
    UITextField *nameTextField;
    UITextField *PWDTextField;
    UIButton *logInBtn;
}
@end

@implementation LogInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self addUI];
    
}

- (void)addUI
{
    UIImage *image = [UIImage imageNamed:@""];
    UIImage *imageH = [UIImage imageNamed:@""];
    imageView = [[UIImageView alloc] initWithImage:image highlightedImage:imageH];
    [imageView setBounds:CGRectMake(0, 0, 140, 140)];
    CGPoint center = self.view.center;
    [imageView setCenter:CGPointMake(center.y, center.x-250)];
    [imageView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:imageView];
    
    nameTextField = [[UITextField alloc] init];
    [nameTextField setBounds:CGRectMake(0, 0, 300, 44)];
    [nameTextField setCenter:CGPointMake(center.y, center.x-100)];
    [nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [nameTextField setDelegate:self];
    [nameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [nameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [nameTextField setFont:[UIFont systemFontOfSize:22]];
    [nameTextField setPlaceholder:@"账号"];
    
    [nameTextField setText:@"lixuanxu"];
    [nameTextField setReturnKeyType:UIReturnKeyNext];
    [nameTextField setBackgroundColor:[UIColor whiteColor]];
    //    [nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:nameTextField];
    
    PWDTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextField.frame.origin.x, CGRectGetMaxY(nameTextField.frame), 300, 44)];
    
    [PWDTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [PWDTextField setReturnKeyType:UIReturnKeyJoin];
    [PWDTextField setKeyboardType:UIKeyboardTypePhonePad];
    [PWDTextField setPlaceholder:@"密码"];
    [PWDTextField setText:@"1234567890"];
    [PWDTextField setSecureTextEntry:YES];
    [PWDTextField setDelegate:self];
    //    [PWDTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [PWDTextField setFont:[UIFont systemFontOfSize:22]];
    [PWDTextField setBackgroundColor:[UIColor whiteColor]];
    UIView *div1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
    div1.backgroundColor = [UIColor lightGrayColor];
    [PWDTextField addSubview:div1];
    [self.view addSubview:PWDTextField];
    
    logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logInBtn setTitle:@"去战斗吧！神鹰！" forState:UIControlStateNormal];
//    [logInBtn addTarget:self action:@selector(butnTouchDown:) forControlEvents:UIControlEventTouchDown];
    [logInBtn setFrame:CGRectMake(PWDTextField.frame.origin.x, CGRectGetMaxY(PWDTextField.frame)+30, 300, 44)];
    [logInBtn setBackgroundColor:[UIColor redColor]];
    [logInBtn addTarget:self action:@selector(logInClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logInBtn];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
     [imageView setBackgroundColor:[UIColor yellowColor]];
        [nameTextField resignFirstResponder];
        [PWDTextField resignFirstResponder];
        [HttpManager requestLoginWithParamDic:@{@"loginName":nameTextField.text,@"password":PWDTextField.text,@"type":@"saler"} Success:^(id obj) {
            NSString *isok = obj;
            if ([isok isEqualToString:@"true"]) {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:nameTextField.text forKey:userDefaultsName];
                [userDefaults setObject:PWDTextField.text forKey:userDefaultsPWD];
                [userDefaults synchronize];
                MainViewController *controller = [[MainViewController alloc]init];
                [self.view.window setRootViewController:controller];
            }else{
//                [SCHudManager showHudWithImage:nil title:@"请确认账号或密码！"];
                [imageView setBackgroundColor:[UIColor redColor]];
                [ProgressHUD showError:@"请确认账号或密码！"];
                
            }
        } fail:^(id obj) {
                [imageView setBackgroundColor:[UIColor redColor]];
//            [ProgressHUD showError:@"请确认账号或密码！"];
//            [SCHudManager showHudWithImage:nil title:@"请确认账号或密码！"];
            DLog(@"errer%@",obj);
        }];
        

    }
    
    
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
