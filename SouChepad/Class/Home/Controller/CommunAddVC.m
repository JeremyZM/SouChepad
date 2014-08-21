//
//  CommunAddVC.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CommunAddVC.h"
#import "ChangeTimePopoVC.h"
#import "HttpManager.h"
#import "ProgressHUD.h"
#import "UserVOModel.h"

@interface CommunAddVC () <ChangeTimePopoDelegate,UITextViewDelegate>
{
    UIButton *timeBut;
    UIPopoverController *timePopoVC;
    NSDictionary *requesDic;
    UITextView *content;
    
    UITextView *messgeTextView;
    UISwitch *messgeSwitch;
    UserVOModel *userVOM;
}
@property (nonatomic, strong) UIScrollView *scorllView;

@end


@implementation CommunAddVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"新增沟通记录"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelRecord:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveRecord:)];
    
    
    self.scorllView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.scorllView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.scorllView];
    
    UILabel *neir = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 24)];
//    [neir setTextAlignment:NSTextAlignmentCenter];
    [neir setText:@"沟通内容"];
    [self.scorllView addSubview:neir];
    
    content = [[UITextView alloc] initWithFrame:CGRectMake(20, neir.frame.origin.y+34, self.scorllView.bounds.size.width-40, 180)];
    [content.layer setCornerRadius:10];
    [content setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [content setFont:[UIFont systemFontOfSize:17]];
    [content.layer setBorderWidth:1.0];
    [self.scorllView addSubview:content];
    
    UILabel *shij = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(content.frame)+20, 150, 44)];
    [shij setText:@"添加预约到店日期"];
//    [shij setTextAlignment:NSTextAlignmentCenter];
    [self.scorllView addSubview:shij];
    
    UISwitch *timeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(460,CGRectGetMaxY(content.frame)+20+5, 20, 20)];
    [self.scorllView addSubview:timeSwitch];
    [timeSwitch addTarget:self action:@selector(addTimeSwitch:) forControlEvents:UIControlEventValueChanged];
    [timeSwitch sizeToFit];
    

    timeBut = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shij.frame)+20, shij.frame.origin.y, 180, 40)];
    //    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter   alloc] init];
//    [formatter  setDateFormat:@"yyyy-MM-dd"];
    [timeBut setTitle:@"请选择" forState:UIControlStateNormal];
    [timeBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [timeBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [timeBut.layer setBorderWidth:1.0];
    [timeBut.layer setCornerRadius:8.0];
    [self.scorllView addSubview:timeBut];
    [timeBut setHidden:YES];
    [timeBut addTarget:self action:@selector(showPopoChangeTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *messgeLabel = [[UILabel alloc]  initWithFrame:CGRectMake(20, CGRectGetMaxY(timeBut.frame)+30, 200, 60)];
    [messgeLabel setText:@"自动发短信/微信"];
    [self.scorllView addSubview:messgeLabel];
    messgeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(460, CGRectGetMaxY(timeBut.frame)+40, 30, 30)];
//    [messgeSwitch setOn:YES];
    [messgeSwitch addTarget:self action:@selector(sendMessgaChangde:) forControlEvents:UIControlEventValueChanged];
    [self.scorllView addSubview:messgeSwitch];
    
    messgeTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(messgeSwitch.frame)+10, self.scorllView.bounds.size.width-40, 170)];
    [messgeTextView setFont:KFont18];
    [messgeTextView.layer setCornerRadius:5.0];
    [messgeTextView.layer setBorderWidth:1.0];
    [messgeTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [messgeTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [messgeTextView setDelegate:self];
    [self.scorllView addSubview:messgeTextView];
    
    [HttpManager requestUserInfoWithParamDic:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        NSDictionary *dataInfoDic = [NSDictionary dictionaryWithDictionary:obj];
        userVOM = [dataInfoDic objectForKey:@"user"];

        NSString *messgeStr;
        if (userVOM.name) {
            messgeStr = [NSString stringWithFormat:@"%@，您好：我是大搜车（北京门店）销售顾问%@，首先感谢您对大搜车的关注，从即日起，我很荣幸的成为您的贴身销售顾问，随时为您提供购车帮助。我的电话是%@。大搜车（北京门店的地址）：海淀区远大路1号，世纪金源购物中心东区北广场（西顶路火器营路口）。您可搭乘地铁10号线至长春桥站，A口出来后前行20米，再向西侧走200米即到。",userVOM.name,[[NSUserDefaults standardUserDefaults] objectForKey:KSellName],[[NSUserDefaults standardUserDefaults] objectForKey:KSellPhone]];
           
        }else {
             messgeStr = [NSString stringWithFormat:@"您好：我是大搜车（北京门店）销售顾问%@，首先感谢您对大搜车的关注，从即日起，我很荣幸的成为您的贴身销售顾问，随时为您提供购车帮助。我的电话是%@。大搜车（北京门店的地址）：海淀区远大路1号，世纪金源购物中心东区北广场（西顶路火器营路口）。您可搭乘地铁10号线至长春桥站，A口出来后前行20米，再向西侧走200米即到。",[[NSUserDefaults standardUserDefaults] objectForKey:KSellName],[[NSUserDefaults standardUserDefaults] objectForKey:KSellPhone]];
        }
        if (userVOM.phone) {
//            [messgeSwitch setOn:YES];
            [self sendMessgaChangde:messgeSwitch];
        }else
        {
            [messgeSwitch setOn:NO];
            [self sendMessgaChangde:messgeSwitch];
        }
        [messgeTextView setText:messgeStr];
        
    } fail:^(id obj) {
        
    }];
    
    requesDic = [NSDictionary dictionary];
}

- (void)addTimeSwitch:(UISwitch *)sw
{
    if (sw.isOn) {
        
        [timeBut setHidden:NO];
        
    }else{
        [timeBut setHidden:YES];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == messgeTextView) {
        
        [self.scorllView setContentOffset:CGPointMake(0, 200) animated:YES];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == messgeTextView) {
        
        [self.scorllView setContentOffset:CGPointZero animated:YES];
    }
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

- (void)showPopoChangeTime:(UIButton*)sender
{
    ChangeTimePopoVC *changeTime = [[ChangeTimePopoVC alloc] init];
    [changeTime setUserResM:self.userResM];
    [changeTime setDelegate:self];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changeTime];
    timePopoVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    CGRect frame = [self.view convertRect:sender.frame fromView:sender.superview];
    timePopoVC.popoverContentSize = CGSizeMake(400, 300);
    [timePopoVC presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)ChangeTimePopoVC:(ChangeTimePopoVC *)changeTVC changeTimeDic:(NSDictionary *)dateDic
{
    requesDic = [NSDictionary dictionaryWithDictionary:dateDic];
    NSString *tim = nil;

    if ([[requesDic objectForKey:@"reservationTime"] isEqualToString:@"morning"]) {
        tim = @"上午";
    }else if ([[requesDic objectForKey:@"reservationTime"] isEqualToString:@"afternoon"]) {
        tim = @"下午";
    }else {
        tim = @"晚上";
    }
    
    [timeBut setTitle:[NSString stringWithFormat:@"%@  %@",[requesDic objectForKey:@"reservationDate"],tim] forState:UIControlStateNormal];
    [timePopoVC dismissPopoverAnimated:YES];
}


#pragma mark - 取消记录
- (void)cancelRecord:(UIBarButtonItem*)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 保存记录
- (void)saveRecord:(UIBarButtonItem *)item
{
    if (content.text.length>0) {
        NSMutableDictionary *commDateDic = [NSMutableDictionary dictionary];
        [commDateDic removeAllObjects];
        
        [commDateDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
        [commDateDic setObject:KUserName forKey:@"userName"];
        [commDateDic setObject:content.text forKey:@"comment"];
        [commDateDic setObject:@"A" forKey:@"store"];
        if (!timeBut.hidden&&[requesDic objectForKey:@"reservationDate"]) {
                [commDateDic setObject:[requesDic objectForKey:@"reservationDate"] forKey:@"reservationDate"];
                [commDateDic setObject:[requesDic objectForKey:@"reservationTime"] forKey:@"reservationTime"];
            
        }
        
        if (messgeSwitch.isOn && userVOM.phone) {
            [commDateDic setObject:@"1" forKey:@"isSendSMS"];
            [commDateDic setObject:userVOM.phone forKey:@"phoneSMS"];
            [commDateDic setObject:messgeTextView.text forKey:@"messageSMS"];
        }
//        if ([requesDic allKeys].count) {
//            
//            commDateDic = @{@"user":self.userResM.crmUserId,@"reservationDate":[requesDic objectForKey:@"reservationDate"],@"reservationTime":[requesDic objectForKey:@"reservationTime"],@"userName":KUserName,@"comment":content.text,@"store":@"A"};
//        }else
//        {
//            commDateDic = @{@"user":self.userResM.crmUserId,@"reservationDate":@"",@"reservationTime":@"",@"userName":KUserName,@"comment":content.text,@"store":@"A"};
//            
//        }
        
        [HttpManager requestUpdateReservationDateByUser:commDateDic Success:^(id obj) {
            if ([obj objectForKey:@"succeedMessage"]) {
                if ([_delegate respondsToSelector:@selector(communAddVC:ReservationDateByUser:)]) {
                    [_delegate communAddVC:self ReservationDateByUser:commDateDic];
                }
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];

            }else
            {
                [ProgressHUD showError:[obj objectForKey:@"errorMessage"]];
            }
            
        } fail:^(id obj) {
            
        }];
    }else {
        [ProgressHUD showError:@"请填写沟通内容"];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
