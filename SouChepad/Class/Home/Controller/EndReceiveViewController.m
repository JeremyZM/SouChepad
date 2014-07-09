//
//  EndReceiveViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "EndReceiveViewController.h"
#import "HttpManager.h"
#import "UserVOModel.h"
#import "ProgressHUD.h"
#import "NSString+val.h"
#import "GuoBieViewController.h"
//#import "LiChengViewController.h"
#import "PopoTableViewController.h"


@interface EndReceiveViewController () <UITextViewDelegate,PopoTableViewDelegate>
{
    UITextField *nameTextF;
    UITextField *phoneTextF;
    UIButton *jibieBut;
    UITextView *messgeTextView;
    UISwitch *messgeSwitch;
    UserVOModel *userVOM;
    UIPopoverController *popoController;
}
@property (nonatomic, strong) UIScrollView *scorllView;
@end

@implementation EndReceiveViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.scorllView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.scorllView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.scorllView];
    [self.navigationController setTitle:@"填写本次接待总结"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelItemCilck)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存并结束" style:UIBarButtonItemStyleBordered target:self action:@selector(saveItemReceive)];
    NSArray *labeArray = @[@"姓名",@"手机",@"级别"];
    NSInteger i = 0;
    for (NSString *str in labeArray) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0+i*60, 120, 60)];
        [nameLabel setText:str];
        [nameLabel setFont:KFont18];
        [self.scorllView addSubview:nameLabel];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 60+i*60, self.scorllView.bounds.size.width-40, 1)];
        [lineView setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
        [lineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self.scorllView addSubview:lineView];
        i++;
    }
    nameTextF = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 220, 60)];
    [nameTextF setPlaceholder:@"请填写客户姓名"];
    [self.scorllView addSubview:nameTextF];
    phoneTextF = [[UITextField alloc] initWithFrame:CGRectMake(130, 60, 220, 60)];
    [phoneTextF setPlaceholder:@"请填写客户手机号"];
    [self.scorllView addSubview:phoneTextF];
    
    jibieBut = [[UIButton alloc] initWithFrame:CGRectMake(130, 120, 220, 60)];
    [jibieBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [jibieBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [jibieBut setTitle:@"请选择" forState:UIControlStateNormal];
    [jibieBut addTarget:self action:@selector(jibieClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scorllView addSubview:jibieBut];
    
    UILabel *liLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 130, 60)];
    [liLabel setText:@"离店原因"];
    [self.scorllView addSubview:liLabel];
    UIView *lineliV = [[UIView alloc] initWithFrame:CGRectMake(20, 380, self.scorllView.bounds.size.width-40, 1)];
    [lineliV setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [lineliV setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
    [self.scorllView addSubview:lineliV];
    
    
    
//    UIView *lidianView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, self.scorllView.bounds.size.width, 200)];
//    [lidianView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    [lidianView setBackgroundColor:[UIColor redColor]];
//    [self.scorllView addSubview:lidianView];
    
    
    UILabel *messgeLabel = [[UILabel alloc]  initWithFrame:CGRectMake(20, 380, 200, 60)];
    [messgeLabel setText:@"自动发短信/微信"];
    [self.scorllView addSubview:messgeLabel];
    messgeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(450, 390, 30, 30)];
    [messgeSwitch setOn:YES];
    [messgeSwitch addTarget:self action:@selector(sendMessgaChangde:) forControlEvents:UIControlEventValueChanged];
    [self.scorllView addSubview:messgeSwitch];
    
    messgeTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 430, self.scorllView.bounds.size.width-40, 100)];
    [messgeTextView setFont:KFont18];
    [messgeTextView.layer setCornerRadius:5.0];
    [messgeTextView.layer setBorderWidth:1.0];
    [messgeTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [messgeTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [messgeTextView setText:[NSString stringWithFormat:@"尊敬的%@：感谢您光顾大搜车，接待中如有不周之处敬请谅解，今天和你聊的很开心，期待您的下次光临！你的搜车顾问%@：%@",@"张先生",@"陈小彬",@"18602771863"]];
    [messgeTextView setDelegate:self];
    [self.scorllView addSubview:messgeTextView];
    
    [HttpManager requestUserInfoWithParamDic:@{@"userId":self.userInfoM.crmUserId} Success:^(id obj) {
        NSDictionary *dataInfoDic = [NSDictionary dictionaryWithDictionary:obj];
        userVOM = [dataInfoDic objectForKey:@"user"];
        [nameTextF setText:userVOM.name];
        [phoneTextF setText:userVOM.phone];
        if (!([userVOM.userStatus isEqualToString:@"暂无"]||userVOM.userStatus==nil)) {
            [jibieBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [jibieBut setTitle:userVOM.userStatusName forState:UIControlStateNormal];
        }
        
    } fail:^(id obj) {
        
    }];
    
}

- (void)sendMessgaChangde:(UISwitch*)messwitch
{
    if (messgeSwitch.isOn) {
        [messgeTextView setTextColor:[UIColor blackColor]];
        [messgeTextView setUserInteractionEnabled:YES];
    }else {
        [messgeTextView setUserInteractionEnabled:NO];
        [messgeTextView setTextColor:[UIColor lightGrayColor]];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.scorllView setContentOffset:CGPointMake(0, 200) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scorllView setContentOffset:CGPointMake(0, -44) animated:YES];
}

- (void)cancelItemCilck
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)jibieClick:(UIButton*)jibieB
{
    PopoTableViewController *dengjiVC = [[PopoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [dengjiVC setPopoTabelDelegate:self];
    NSArray *aarray = [NSArray arrayWithContentsOfFile:KbuyerStatus];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dataM in aarray) {
        [arrayM addObject:[dataM objectForKey:@"name"]];
    }
    [dengjiVC setSelectRow:3];
    [dengjiVC setArray:arrayM];
    popoController = [[UIPopoverController alloc] initWithContentViewController:dengjiVC];
//    CGRect frame = [self convertRect:jibieB.frame fromView:jibieB.superview];
    popoController.popoverContentSize = CGSizeMake(320, 480);
    [popoController presentPopoverFromRect:jibieB.frame inView:self.scorllView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}


- (void)PopoTableViewController:(PopoTableViewController *)popoTableVC seleckChanged:(NSString *)seleckStr andseleckRow:(NSInteger)row andselectBtn:(UIButton *)selecBtn
{
    [jibieBut setTitle:seleckStr forState:UIControlStateNormal];
    [jibieBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [popoController dismissPopoverAnimated:YES];
}

- (void)saveItemReceive
{
    if ([NSString phoneValidate:phoneTextF.text]) {
        
        NSMutableDictionary *requDic = [NSMutableDictionary dictionary];
        [requDic setObject:self.userInfoM.crmUserId forKey:@"user"];
        [requDic setObject:nameTextF.text forKey:@"name"];
        if (KUserName) {
            [requDic setObject:KUserName forKey:@"userName"];
        }
        [requDic setObject:phoneTextF.text forKey:@"phone"];
        
        if (self.userInfoM.userLevel) {
            [requDic setObject:self.userInfoM.userLevel forKey:@"level"];
        }
        [requDic setObject:@"A"forKey:@"store"];
        [requDic setObject:@"" forKey:@"comment"];
        [requDic setObject:@"" forKey:@"remark"];
        
        
        [HttpManager requestUserOutStore:requDic Success:^(id obj) {
            NSDictionary *dicobj = [NSDictionary dictionaryWithDictionary:obj];
            if ([dicobj objectForKey:@"succeedMessage"]) {
                [ProgressHUD showSuccess:@"接待完成！"];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        } fail:^(id obj) {
            
        }];
    }

}

@end
