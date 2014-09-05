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
#import "PopoTableViewController.h"
#import "DatePickViewController.h"
#import "Date&String.h"

@interface CommunAddVC () <ChangeTimePopoDelegate,UITextViewDelegate,PopoTableViewDelegate,DatePickerVCdelegate>
{
    UIButton *timeBut;
    UIPopoverController *timePopoVC;
    NSDictionary *requesDic;
    UITextView *content;
    
    UITextView *messgeTextView;
    UISwitch *messgeSwitch;
    UserVOModel *userVOM;
    UIButton *phoneNumBut;
    
    UIButton *huifangBut;
    UISwitch *huifangSw;
    BOOL isHuifang;
}
@property (nonatomic, strong) UIScrollView *scorllView;

@end


@implementation CommunAddVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HttpManager userCanVisit:@{@"salerId": KUserName,@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if (![[dic objectForKey:@"date"] isKindOfClass:[NSNull class]]) {
            isHuifang = YES;
            [huifangSw setOn:YES];
            [huifangBut setHidden:NO];
            [huifangBut setTitle:[dic objectForKey:@"date"] forState:UIControlStateNormal];
        }
    } fail:^(id obj) {
        
    }];
    
    [HttpManager requestUserInfoWithParamDic:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        NSDictionary *dataInfoDic = [NSDictionary dictionaryWithDictionary:obj];
        userVOM = [dataInfoDic objectForKey:@"user"];
        
        NSString *messgeStr;
        if (userVOM.name) {
            messgeStr = [NSString stringWithFormat:@"%@，您好：我是大搜车（北京门店）销售顾问%@，首先感谢您对大搜车的关注，从即日起，我很荣幸的成为您的贴身销售顾问，随时为您提供购车帮助。我的电话是%@。大搜车（北京门店的地址）：海淀区远大路1号，世纪金源购物中心东区北广场（西顶路火器营路口）。您可搭乘地铁10号线至长春桥站，A口出来后前行20米，再向西侧走200米即到。",userVOM.name,[[NSUserDefaults standardUserDefaults] objectForKey:KSellName],[[NSUserDefaults standardUserDefaults] objectForKey:KSellPhone]];
            
        }else {
            messgeStr = [NSString stringWithFormat:@"您好：我是大搜车（北京门店）销售顾问%@，首先感谢您对大搜车的关注，从即日起，我很荣幸的成为您的贴身销售顾问，随时为您提供购车帮助。我的电话是%@。大搜车（北京门店的地址）：海淀区远大路1号，世纪金源购物中心东区北广场（西顶路火器营路口）。您可搭乘地铁10号线至长春桥站，A口出来后前行20米，再向西侧走200米即到。",[[NSUserDefaults standardUserDefaults] objectForKey:KSellName],[[NSUserDefaults standardUserDefaults] objectForKey:KSellPhone]];
        }
        [messgeTextView setText:messgeStr];
        
    } fail:^(id obj) {
        
    }];

}


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
    
    content = [[UITextView alloc] initWithFrame:CGRectMake(20, neir.frame.origin.y+34, self.scorllView.bounds.size.width-40, 80)];
    [content.layer setCornerRadius:10];
    [content setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [content setFont:[UIFont systemFontOfSize:17]];
    [content.layer setBorderWidth:1.0];
    [self.scorllView addSubview:content];
    
    UILabel *huif = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(content.frame)+40, 150, 24)];
    [huif setText:@"我来回访"];
    [self.scorllView addSubview:huif];
    
    huifangSw = [[UISwitch alloc] initWithFrame:CGRectMake(460,CGRectGetMaxY(content.frame)+30+5, 20, 20)];
    [self.scorllView addSubview:huifangSw];
    [huifangSw addTarget:self action:@selector(huifangTimeSw:) forControlEvents:UIControlEventValueChanged];
    [huifangSw setOn:NO];
    [huifangSw sizeToFit];
    
    huifangBut = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huif.frame)+20, huif.frame.origin.y-10, 200, 40)];
    
    [huifangBut setTitle:@"请选择" forState:UIControlStateNormal];
    [huifangBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [huifangBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [huifangBut.layer setBorderWidth:1.0];
    [huifangBut.layer setCornerRadius:8.0];
    [self.scorllView addSubview:huifangBut];
    [huifangBut setHidden:YES];
    [huifangBut addTarget:self action:@selector(showPopohuifangTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *shij = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(huifangBut.frame)+30, 150, 44)];
    [shij setText:@"添加预约到店日期"];
//    [shij setTextAlignment:NSTextAlignmentCenter];
    [self.scorllView addSubview:shij];
    
    UISwitch *timeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(460,CGRectGetMaxY(huifangBut.frame)+30+5, 20, 20)];
    [self.scorllView addSubview:timeSwitch];
    [timeSwitch addTarget:self action:@selector(addTimeSwitch:) forControlEvents:UIControlEventValueChanged];
    [timeSwitch sizeToFit];
    

    timeBut = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shij.frame)+20, shij.frame.origin.y, 200, 40)];

    [timeBut setTitle:@"请选择" forState:UIControlStateNormal];
    [timeBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [timeBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [timeBut.layer setBorderWidth:1.0];
    [timeBut.layer setCornerRadius:8.0];
    [self.scorllView addSubview:timeBut];
    [timeBut setHidden:YES];
    [timeBut addTarget:self action:@selector(showPopoChangeTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *messgeLabel = [[UILabel alloc]  initWithFrame:CGRectMake(20, CGRectGetMaxY(timeBut.frame)+30, 150, 60)];
    [messgeLabel setText:@"自动发短信/微信"];
    [self.scorllView addSubview:messgeLabel];
    messgeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(460, CGRectGetMaxY(timeBut.frame)+40, 30, 30)];
    [messgeSwitch setOn:NO];
    [messgeSwitch addTarget:self action:@selector(sendMessgaChangde:) forControlEvents:UIControlEventValueChanged];
    [self.scorllView addSubview:messgeSwitch];
    
    phoneNumBut = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(messgeLabel.frame)+20, messgeLabel.frame.origin.y+10, 200, 40)];
    [phoneNumBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [phoneNumBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [phoneNumBut.layer setBorderWidth:1.0];
    [phoneNumBut.layer setCornerRadius:8.0];
    [self.scorllView addSubview:phoneNumBut];
    [phoneNumBut setHidden:YES];
    [phoneNumBut addTarget:self action:@selector(showUserPhone:) forControlEvents:UIControlEventTouchUpInside];
    
    
    messgeTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(messgeSwitch.frame)+20, self.scorllView.bounds.size.width-40, 170)];
    [messgeTextView setFont:KFont18];
    [messgeTextView.layer setCornerRadius:5.0];
    [messgeTextView.layer setBorderWidth:1.0];
    [messgeTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [messgeTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [messgeTextView setDelegate:self];
    [self.scorllView addSubview:messgeTextView];
    [messgeTextView setUserInteractionEnabled:NO];
    [messgeTextView setTextColor:[UIColor lightGrayColor]];
    
    requesDic = [NSDictionary dictionary];
}

- (void)huifangTimeSw:(UISwitch*)swit
{
    if (swit.isOn) {
        
        [huifangBut setHidden:NO];
        
    }else{
        [huifangBut setHidden:YES];
    }
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
        
        [self.scorllView setContentOffset:CGPointMake(0, 250) animated:YES];
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
    if (userVOM.phone) {
        
        if (messgeSwitch.isOn) {
            [phoneNumBut setHidden:NO];
            [phoneNumBut setTitle:userVOM.phone forState:UIControlStateNormal];
            [messgeTextView setTextColor:[UIColor blackColor]];
            [messgeTextView setUserInteractionEnabled:YES];
        }else {
            [phoneNumBut setHidden:YES];
            [messgeTextView setUserInteractionEnabled:NO];
            [messgeTextView setTextColor:[UIColor lightGrayColor]];
        }
    }else{
        [messwitch setOn:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该客户暂无手机号" message:@"请到个人信息添加" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

- (void)showUserPhone:(UIButton *)phoneBut
{
    NSMutableArray *phoneArray = [NSMutableArray array];
    [phoneArray addObject:userVOM.phone];
    if (userVOM.callPhone1) {
        [phoneArray addObject:userVOM.callPhone1];
    }
    if (userVOM.callPhone2) {
        [phoneArray addObject:userVOM.callPhone2];
    }
    if (userVOM.callPhone3) {
        [phoneArray addObject:userVOM.callPhone3];
    }
    if (userVOM.callPhone4) {
        [phoneArray addObject:userVOM.callPhone4];
    }
    PopoTableViewController *phoneTVC = [[PopoTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [phoneTVC setPopoTabelDelegate:self];
    [phoneTVC setArray:phoneArray];
    for (NSInteger i = 0; i<phoneArray.count; i++) {
        if ([phoneBut.titleLabel.text isEqualToString:phoneArray[i]]) {
            [phoneTVC setSelectRow:[NSString stringWithFormat:@"%d",i]];
        }
    }
//    [phoneTVC setSelectRow:phoneBut.titleLabel.text];
    [phoneTVC setSortWayBtn:phoneBut];
    timePopoVC = [[UIPopoverController alloc] initWithContentViewController:phoneTVC];
    CGRect frame = [self.view convertRect:phoneBut.frame fromView:phoneBut.superview];
    timePopoVC.popoverContentSize = CGSizeMake(400, 60*phoneArray.count+44);
    [timePopoVC presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)PopoTableViewController:(PopoTableViewController *)popoTableVC seleckChanged:(NSString *)seleckStr andseleckRow:(NSInteger)row andselectBtn:(UIButton *)selecBtn
{
    [selecBtn setTitle:seleckStr forState:UIControlStateNormal];
    [timePopoVC dismissPopoverAnimated:YES];
}


- (void)showPopohuifangTime:(UIButton*)huifang
{
    DatePickViewController *huifagDatePick = [[DatePickViewController alloc] init];
    [huifagDatePick setDelegate:self];
    [huifagDatePick setMinDate:[NSDate date]];
    [huifagDatePick setMaxDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*7]];
    NSDate *date = [Date_String dateFromString:huifang.titleLabel.text format:@"yyyy-MM-dd"];
    if (date) {
        [huifagDatePick setDatesele:date];
    }
    
    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
    [tishi setTextAlignment:NSTextAlignmentCenter];
    [tishi setText:@"选择范围一周内"];
    [tishi setTextColor:[UIColor grayColor]];
    [tishi setFont:[UIFont systemFontOfSize:20]];
    [huifagDatePick.view addSubview:tishi];
    
    timePopoVC = [[UIPopoverController alloc] initWithContentViewController:huifagDatePick];
    CGRect frame = [self.view convertRect:huifang.frame fromView:huifang.superview];
    timePopoVC.popoverContentSize = CGSizeMake(320, 260);
    [timePopoVC presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)datePickerVC:(DatePickViewController *)datePickVC dateStr:(NSString *)datestr
{
    [huifangBut setTitle:datestr forState:UIControlStateNormal];
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
    if (!content.text.length>0) {
        [ProgressHUD showError:@"请填写沟通内容"];
        return;
    }
    if (isHuifang) {
        [HttpManager closeVisit:@{@"salerId": KUserName,@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
            if ([obj objectForKey:@"errorMessage"]) {
                [ProgressHUD showError:[obj objectForKey:@"errorMessage"]];
                return;
            }else {
                [self addOrUpdateVisit];
            }
        } fail:^(id obj) {
            [ProgressHUD showError:@"保存失败"];
            return ;
        }];
    }else{
        [self addOrUpdateVisit];
    }

}

- (void)addOrUpdateVisit
{
    if (huifangSw.on) {
        NSDate *date = [Date_String dateFromString:huifangBut.titleLabel.text format:@"yyyy-MM-dd"];
        if (!date) {
            [ProgressHUD showError:@"请选择回访时间"];
            return;
        }else {
            [HttpManager addOrUpdateVisit:@{@"salerId": KUserName,@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"date":huifangBut.titleLabel.text} Success:^(id obj) {
                if ([obj objectForKey:@"errorMessage"]) {                         [ProgressHUD showError:[obj objectForKey:@"errorMessage"]];
                    return ;
                }else {
                    [self addCommunUser:nil];
                    [self addCommunUser:huifangBut.titleLabel.text];
                    
                }
            } fail:^(id obj) {
                [ProgressHUD showError:@"保存失败"];
                return ;
            }];
        }
    }else {
        [self addCommunUser:nil];
    }

}

- (void)addCommunUser:(NSString *)huifangStr
{
        NSMutableDictionary *commDateDic = [NSMutableDictionary dictionary];
        [commDateDic removeAllObjects];
        
        [commDateDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
        [commDateDic setObject:KUserName forKey:@"userName"];
        [commDateDic setObject:content.text forKey:@"comment"];
        [commDateDic setObject:@"A" forKey:@"store"];
        if (huifangStr) {
            [commDateDic setObject:[NSString stringWithFormat:@"该客户%@前均由销售%@回访。",huifangStr,[[NSUserDefaults standardUserDefaults] objectForKey:KSellName]] forKey:@"comment"];
        }
    
        if (!timeBut.hidden&&[requesDic objectForKey:@"reservationDate"]) {
            [commDateDic setObject:[requesDic objectForKey:@"reservationDate"] forKey:@"reservationDate"];
            [commDateDic setObject:[requesDic objectForKey:@"reservationTime"] forKey:@"reservationTime"];
            
        }
        
        if (messgeSwitch.isOn && userVOM.phone) {
            [commDateDic setObject:@"1" forKey:@"isSendSMS"];
            [commDateDic setObject:phoneNumBut.titleLabel.text forKey:@"phoneSMS"];
            [commDateDic setObject:messgeTextView.text forKey:@"messageSMS"];
        }
        
        [HttpManager requestUpdateReservationDateByUser:commDateDic Success:^(id obj){
            
            if ([obj objectForKey:@"succeedMessage"]) {
                if ([_delegate respondsToSelector:@selector(communAddVC:ReservationDateByUser:)]) {
                    [_delegate communAddVC:self ReservationDateByUser:commDateDic];
                }
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }else {
                [ProgressHUD showError:[obj objectForKey:@"errorMessage"]];
            }
            
        } fail:^(id obj) {
            
        }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
