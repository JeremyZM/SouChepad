//
//  SettingViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "SettingViewController.h"
#import "LogInViewController.h"
#import "HttpManager.h"
#import "ProgressHUD.h"

@interface SettingViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView *settingTable;
    UIScrollView *detailView;
    UIView *sellInfoView;
    UIView *changePWDView;
    
    UILabel *titeLabel;
    
    UITextField *oldPWDText;
    UITextField *newPWDText;
    UITextField *confirmPWDText;
}

// 建立所有文本输入控件的数组
@property (strong, nonatomic) NSArray *textFiledArray;

// 用户选中的文本框
@property (weak, nonatomic) UITextField *selectedTextField;

@end

@implementation SettingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 80, 40)];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"tubiao_36"] forState:UIControlStateNormal];
    [self.headBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(showDockCilck) forControlEvents:UIControlEventTouchUpInside];
    
    titeLabel = [[UILabel alloc] initWithFrame:CGRectMake(630, 40, 150, 40)];
    [titeLabel setFont:[UIFont systemFontOfSize:22]];
    [titeLabel setTextColor:[UIColor whiteColor]];
    [self.headBar addSubview:titeLabel];
    
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:0 inSection:0];
    
    settingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 390, self.view.bounds.size.height-180) style:UITableViewStyleGrouped];
    [settingTable setDataSource:self];
    [settingTable setDelegate:self];
    [settingTable setBackgroundColor:[UIColor whiteColor]];
    [settingTable setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [settingTable setEstimatedRowHeight:80.0];
    [self.view insertSubview:settingTable atIndex:0];
    [settingTable selectRowAtIndexPath:indexP animated:YES scrollPosition:UITableViewScrollPositionNone];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(389, 0, 1, self.view.bounds.size.height)];
    [lineView setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
    [lineView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:lineView];
    
    UIButton *exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(55, self.view.bounds.size.height-80, 280, 40)];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"dengluanniu1_60"] forState:UIControlStateNormal];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"denglu2"] forState:UIControlStateHighlighted];
    [exitBtn setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitLogBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    
    detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(390, 100, self.view.bounds.size.width-390, self.view.bounds.size.height-100)];
    [detailView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

    [self.view addSubview:detailView];
    
    [self addSellInfoView];
    [self addChangePWDView];
    
    [self tableView:settingTable didSelectRowAtIndexPath:indexP];
    
    
    
}

- (void)exitLogBut
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"确认退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认退出", nil];
    [alert show];
    
}

// 确认退出
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    if (buttonIndex) {
        [HttpManager requestLogout];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:userDefaultsName];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:userDefaultsPWD];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSellName];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSellEmail];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSellPhone];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSellAddressName];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSellQQ];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KisExecutive];
        [self.view.window setRootViewController:[LogInViewController new]];
    }
}


- (void)showDockCilck
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KShowDockNotification object:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:22]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
//    if (indexPath.row==0) {
//        [cell.textLabel setText:@"个人资料"];
//        
//    }else
        if (indexPath.row ==0) {
        [cell.textLabel setText:@"修改密码"];
    }else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        NSString *localVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        [cell.textLabel setText:@"版本更新"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"当前版本：V%@",localVersion]];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 在双视图转场时，我们可以根据是否有父视图，来判断谁进谁出
//    
//    if (indexPath.row==0&&sellInfoView.superview==nil) {
//        // 说明subView1要转入
//        [UIView transitionFromView:changePWDView toView:sellInfoView duration:0.3f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
//            [titeLabel setText:@"个人资料"];
//            //        NSLog(@"转场完成");
//            // 每次转场后，会调整参与转场视图的父视图，因此，参与转场视图的属性，需要是强引用
//            // 转场之后，入场的视图会有两个强引用，一个是视图控制器，另一个是视图
//            
//        }];
//
//    } else
    if(indexPath.row == 0&&changePWDView.superview == nil) {
        // 说明subView2要转入
    
        [UIView transitionFromView:sellInfoView toView:changePWDView duration:0.3f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            [titeLabel setText:@"修改密码"];
            //        NSLog(@"转场完成");

            
        }];
    }else if (indexPath.row ==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pgyer.com/athena"]];
    }
}


// 销售个人资料
- (void)addSellInfoView
{
    if (sellInfoView==nil) {
        
        sellInfoView = [[UIView alloc] initWithFrame:detailView.bounds];
        NSArray *sellInfoArray = @[@"昵称",@"邮箱",@"电话",@"地址",@"QQ"];
        NSMutableArray *textArrayM = [NSMutableArray arrayWithCapacity:5];
        for (NSInteger i = 0;i<sellInfoArray.count;i++) {
            
            UILabel *tite = [[UILabel alloc] initWithFrame:CGRectMake(80, 40+(i*60), 100, 40)];
            [tite setFont:[UIFont systemFontOfSize:20]];
            [tite setTextAlignment:NSTextAlignmentRight];
            [tite setText:sellInfoArray[i]];
            [sellInfoView addSubview:tite];
            
            UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(200, 40+(i*60), 260, 40)];
            
            [textF.layer setBorderWidth:1.0];
            [textF.layer setBorderColor:[[UIColor hexStringToColor:KSeparatorColor] CGColor]];

            [textF setDelegate:self];
            [textF setAutocorrectionType:UITextAutocorrectionTypeNo];
            [textF.layer setCornerRadius:5.0];
            [textF setPlaceholder:[NSString stringWithFormat:@"请填写%@",sellInfoArray[i]]];
            [sellInfoView addSubview:textF];
            
            [textArrayM addObject:textF];
            if (i==0) {
                self.selectedTextField = textF;
            }
            
        }
        self.textFiledArray = [NSArray arrayWithArray:textArrayM];
        UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 40+(sellInfoArray.count*60)+40, 250, 40)];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"dengluanniu1_60"] forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"denglu2"] forState:UIControlStateHighlighted];
        [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [sellInfoView addSubview:confirmBtn];
        [confirmBtn addTarget:self action:@selector(changeSalerInfo) forControlEvents:UIControlEventTouchUpInside];
        [detailView addSubview:sellInfoView];
    }
    for (NSInteger i = 0; i<self.textFiledArray.count; i++) {
        UITextField *textF = (UITextField*)self.textFiledArray[i];
        switch (i) {
            case 0:
                [textF setText:[[NSUserDefaults standardUserDefaults] objectForKey:KSellName]];
                break;
            case 1:
                
                [textF setText:[[NSUserDefaults standardUserDefaults] objectForKey:KSellEmail]];
                break;
            case 2:
                [textF setKeyboardType:UIKeyboardTypeNumberPad];
                [textF setText:[[NSUserDefaults standardUserDefaults] objectForKey:KSellPhone]];
                break;
            case 3:
                [textF setText:[[NSUserDefaults standardUserDefaults] objectForKey:KSellAddressName]];
                break;
            case 4:
                
                [textF setText:[[NSUserDefaults standardUserDefaults] objectForKey:KSellQQ]];
                [textF setKeyboardType:UIKeyboardTypeNumberPad];
                break;
            default:
                break;
        }

    }
    [titeLabel setText:@"个人资料"];
}

- (void)changeSalerInfo
{
    NSMutableDictionary *requstDic = [NSMutableDictionary dictionary];
    [requstDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName]forKey:@"userName"];
    for (NSInteger i =0; i<self.textFiledArray.count; i++) {
        UITextField *textf = (UITextField *)self.textFiledArray[i];
        switch (i) {
            case 0:
                [requstDic setObject:textf.text forKey:@"name"];
                break;
            case 1:
                [requstDic setObject:textf.text forKey:@"email"];
                break;
            case 2:
                [requstDic setObject:textf.text forKey:@"phone"];
                break;
            case 3:
                [requstDic setObject:textf.text forKey:@"address"];
                break;
            case 4:
                [requstDic setObject:textf.text forKey:@"qq"];
                break;
            default:
                break;
        }
    }
    DLog(@"%@",requstDic);
    [HttpManager updateSellerData:requstDic Success:^(id obj) {
        NSDictionary *infoObj = [NSDictionary dictionaryWithDictionary:obj];
        if ([infoObj objectForKey:@"succeedMessage"]) {
            
            for (NSInteger i = 0; i<self.textFiledArray.count; i++) {
                UITextField *textF = (UITextField*)self.textFiledArray[i];
                switch (i) {
                    case 0:
                        [[NSUserDefaults standardUserDefaults] setObject:textF.text forKey:KSellName];
                        
                        break;
                    case 1:
                        
                        [[NSUserDefaults standardUserDefaults] setObject:textF.text forKey:KSellEmail];
                        
                        break;
                    case 2:
                        [[NSUserDefaults standardUserDefaults] setObject:textF.text forKey:KSellPhone];
                        
                        break;
                    case 3:
                        [[NSUserDefaults standardUserDefaults] setObject:textF.text forKey:KSellAddressName];
                        
                        break;
                    case 4:
                        
                        [[NSUserDefaults standardUserDefaults] setObject:textF.text forKey:KSellQQ];
                        break;
                    default:
                        break;
                }
                
            }
            [ProgressHUD showSuccess:@"修改成功"];
            [self addSellInfoView];
        }else if ([infoObj objectForKey:@"errorMessage"]){
            [ProgressHUD showError:[infoObj objectForKey:@"errorMessage"]];
            [self addSellInfoView];
        }
    } fail:^(id obj) {
        
    }];
}



// 修改密码
- (void)addChangePWDView
{
    if (changePWDView == nil) {
        
        changePWDView = [[UIView alloc] initWithFrame:detailView.bounds];
        NSArray *changePWDArray = @[@"原密码",@"新密码",@"确认新密码"];
        for (NSInteger i = 0; i<changePWDArray.count; i++) {
            UILabel *tite = [[UILabel alloc] initWithFrame:CGRectMake(80, 40+(i*60), 100, 40)];
            [tite setFont:[UIFont systemFontOfSize:20]];
            [tite setTextAlignment:NSTextAlignmentRight];
            [tite setText:changePWDArray[i]];
            [changePWDView addSubview:tite];
            
            UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(200, 40+(i*60), 260, 40)];
            [textF.layer setBorderWidth:1.0];
            [textF.layer setBorderColor:[[UIColor hexStringToColor:KSeparatorColor] CGColor]];
            [textF setAutocorrectionType:UITextAutocorrectionTypeNo];
            [textF.layer setCornerRadius:5.0];
            [textF setPlaceholder:[NSString stringWithFormat:@"请填写%@",changePWDArray[i]]];
            [changePWDView addSubview:textF];
            if (i==0) {
                oldPWDText = textF;
            }else if (i==1){
                newPWDText = textF;
            }else if(i==2){
                confirmPWDText = textF;
            }
            
        }
        UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 40+(changePWDArray.count*60)+40, 250, 40)];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"dengluanniu1_60"] forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"denglu2"] forState:UIControlStateHighlighted];
        [confirmBtn addTarget:self action:@selector(updatePassword) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [changePWDView addSubview:confirmBtn];
    }
}

- (void)updatePassword
{
    if (![oldPWDText.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsPWD]]) {
        [ProgressHUD showError:@"原密码错误！"];
        return;
    }
    if (newPWDText.text.length>=6&&[newPWDText.text isEqualToString:confirmPWDText.text]) {
        
        [HttpManager updatePassword:@{@"userName":[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName], @"oldPassword":oldPWDText.text, @"newPassword":newPWDText.text, @"confirmPassword":confirmPWDText.text} Success:^(id obj) {
                [[NSUserDefaults standardUserDefaults] setObject:newPWDText.text forKey:userDefaultsPWD];
                [ProgressHUD showSuccess:@"修改成功！"];
                [oldPWDText setText:nil];
                [newPWDText setText:nil];
                [confirmPWDText setText:nil];
        } fail:^(id obj) {
        }];
    }else{
        [ProgressHUD showError:@"请填写完整，并密码不少于6位"];
    }
    
}





#pragma mark textField代理方法
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 记录当前选中的文本框
    self.selectedTextField = textField;
    NSUInteger index = [self.textFiledArray indexOfObject:textField];
    // 如果是数组中第一个文本框，禁用上一个按钮
    // 如果是数组中最后一个文本框，禁用下一个按钮
    if (index) {
        [detailView setContentOffset:CGPointMake(0, index*25) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [detailView setContentOffset:CGPointZero animated:YES];
}

@end
