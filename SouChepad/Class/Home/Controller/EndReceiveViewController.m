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
#import "PopoTableViewController.h"
#import "BiaoQianView.h"
#import "DatePickViewController.h"
#import "Date&String.h"


@interface EndReceiveViewController () <UITextFieldDelegate,UITextViewDelegate,PopoTableViewDelegate,BiaoQianViewDelegate,UIPopoverControllerDelegate,DatePickerVCdelegate>
{
    UITextField *nameTextF;
    UITextField *phoneTextF;
    UITextField *jibieBut;
    UITextView *messgeTextView;
    UISwitch *messgeSwitch;
    UserVOModel *userVOM;
    UIPopoverController *popoController;
    UITextField *otherCauseTextF;
    NSString *leaveString;
    NSString *biaoqianString;
    
    UIButton *phoneNumBut;
    UIButton *_huifangBut;
    UISwitch *huifangSw;
    BOOL isHuifang;
}
@property (nonatomic, strong) UIScrollView *scorllView;
@end

@implementation EndReceiveViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HttpManager userCanVisit:@{@"salerId":KUserName,@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if (![[dic objectForKey:@"date"] isKindOfClass:[NSNull class]]) {
            isHuifang = YES;
            [huifangSw setOn:YES];
            [_huifangBut setHidden:NO];
            [_huifangBut setTitle:[dic objectForKey:@"date"] forState:UIControlStateNormal];
        }
    } fail:^(id obj) {
        
    }];
//    [HttpManager getAllVistors:@{@"salerId":KUserName} Success:^(id obj) {
//        
//    } fail:^(id obj) {
//        
//    }];
    
    [HttpManager requestUserInfoWithParamDic:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        NSDictionary *dataInfoDic = [NSDictionary dictionaryWithDictionary:obj];
        userVOM = [dataInfoDic objectForKey:@"user"];
        [nameTextF setText:userVOM.name];
        [phoneTextF setText:userVOM.phone];
        if (!(userVOM.userStatus||userVOM.userStatus==nil)) {
            [jibieBut setText:userVOM.userStatusName];
        }
        NSString *messgeStr;
        if (userVOM.name) {
            messgeStr = [NSString stringWithFormat:@"%@您好：感谢您光顾大搜车，接待中如有不周之处敬请谅解，今天和您聊的很开心，期待您的下次光临！您的搜车顾问%@：%@",userVOM.name,[[NSUserDefaults standardUserDefaults] objectForKey:KSellName],[[NSUserDefaults standardUserDefaults] objectForKey:KSellPhone]];
        }else {
            messgeStr = [NSString stringWithFormat:@"您好：感谢您光顾大搜车，接待中如有不周之处敬请谅解，今天和您聊的很开心，期待您的下次光临！您的搜车顾问%@：%@",[[NSUserDefaults standardUserDefaults] objectForKey:KSellName],[[NSUserDefaults standardUserDefaults] objectForKey:KSellPhone]];
        }
        
        [messgeTextView setText:messgeStr];
        
    } fail:^(id obj) {
        
    }];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    biaoqianString = @"";
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.scorllView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.scorllView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.scorllView setContentSize:CGSizeMake(0, 680)];
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
    [phoneTextF setDelegate:self];
    [self.scorllView addSubview:phoneTextF];
    
    jibieBut = [[UITextField alloc] initWithFrame:CGRectMake(130, 120, 350, 60)];
    [jibieBut setPlaceholder:@"请选择（必填）"];
    [jibieBut setDelegate:self];
    [self.scorllView addSubview:jibieBut];
    
    UILabel *liLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 130, 60)];
    [liLabel setText:@"离店原因"];
    [self.scorllView addSubview:liLabel];
    UIView *lineliV = [[UIView alloc] initWithFrame:CGRectMake(20, 380, self.scorllView.bounds.size.width-40, 1)];
    [lineliV setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [lineliV setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
    [self.scorllView addSubview:lineliV];
    
    BiaoQianView *biaoqian = [[BiaoQianView alloc] initWithFrame:CGRectMake(130, 190, 400, 180)];
    [biaoqian setDelegate:self];
//    [biaoqian setBackgroundColor:[UIColor redColor]];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:KdepartureReason];
    [biaoqian setDataArray:dataArray];
    [self.scorllView addSubview:biaoqian];
    
    otherCauseTextF = [[UITextField alloc] initWithFrame:CGRectMake(20, 330, 500, 40)];
    [otherCauseTextF setDelegate:self];
    [otherCauseTextF setBorderStyle:UITextBorderStyleRoundedRect];
    [otherCauseTextF setPlaceholder:@"沟通记录..."];
    [self.scorllView addSubview:otherCauseTextF];
    
    
    UILabel *huif = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(otherCauseTextF.frame)+40, 150, 24)];
    [huif setText:@"我来回访"];
    [self.scorllView addSubview:huif];
    
    huifangSw = [[UISwitch alloc] initWithFrame:CGRectMake(460,CGRectGetMaxY(otherCauseTextF.frame)+30+5, 20, 20)];
    [self.scorllView addSubview:huifangSw];
    [huifangSw addTarget:self action:@selector(huifangTimeSw:) forControlEvents:UIControlEventValueChanged];
    [huifangSw setOn:NO];
    [huifangSw sizeToFit];
    
    _huifangBut = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huif.frame)+20, huif.frame.origin.y, 200, 40)];
    
    [_huifangBut setTitle:@"请选择" forState:UIControlStateNormal];
    [_huifangBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [_huifangBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [_huifangBut.layer setBorderWidth:1.0];
    [_huifangBut.layer setCornerRadius:8.0];
    [self.scorllView addSubview:_huifangBut];
    [_huifangBut setHidden:YES];
    [_huifangBut addTarget:self action:@selector(showPopohuifangTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *messgeLabel = [[UILabel alloc]  initWithFrame:CGRectMake(20, 470, 150, 60)];
    [messgeLabel setText:@"自动发短信/微信"];
    [self.scorllView addSubview:messgeLabel];
    messgeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(460, 480, 30, 30)];
    [messgeSwitch setOn:NO];
    [messgeSwitch addTarget:self action:@selector(sendMessgaChangde:) forControlEvents:UIControlEventValueChanged];
    [self.scorllView addSubview:messgeSwitch];
    
    phoneNumBut = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(messgeLabel.frame)+20, 480, 200, 40)];
    [phoneNumBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [phoneNumBut.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [phoneNumBut.layer setBorderWidth:1.0];
    [phoneNumBut.layer setCornerRadius:8.0];
    [self.scorllView addSubview:phoneNumBut];
    [phoneNumBut setHidden:YES];
    [phoneNumBut addTarget:self action:@selector(showUserPhone:) forControlEvents:UIControlEventTouchUpInside];
    
    
    messgeTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 530, self.scorllView.bounds.size.width-40, 100)];
    [messgeTextView setFont:KFont18];
    [messgeTextView.layer setCornerRadius:5.0];
    [messgeTextView.layer setBorderWidth:1.0];
    [messgeTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [messgeTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [messgeTextView setDelegate:self];
    [self.scorllView addSubview:messgeTextView];
    [messgeTextView setUserInteractionEnabled:NO];
    [messgeTextView setTextColor:[UIColor lightGrayColor]];
    
    
    
}

- (void)huifangTimeSw:(UISwitch*)swit
{
    if (swit.isOn) {
        
        [_huifangBut setHidden:NO];
        
    }else{
        [_huifangBut setHidden:YES];
    }
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
    
    popoController = [[UIPopoverController alloc] initWithContentViewController:huifagDatePick];
    CGRect frame = [self.view convertRect:huifang.frame fromView:huifang.superview];
    popoController.popoverContentSize = CGSizeMake(320, 260);
    [popoController presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)datePickerVC:(DatePickViewController *)datePickVC dateStr:(NSString *)datestr
{
    [_huifangBut setTitle:datestr forState:UIControlStateNormal];
}



- (void)showUserPhone:(UIButton *)phoneBut
{
    NSMutableArray *phoneArray = [NSMutableArray array];
    if (userVOM.phone) {
        
        [phoneArray addObject:userVOM.phone];
    }
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
    if (phoneArray.count==0) {
        [phoneArray addObject:phoneTextF.text];
    }
    [phoneTVC setArray:phoneArray];
    for (NSInteger i = 0; i<phoneArray.count; i++) {
        if ([phoneBut.titleLabel.text isEqualToString:phoneArray[i]]) {
            [phoneTVC setSelectRow:[NSString stringWithFormat:@"%d",i]];
        }
    }
    //    [phoneTVC setSelectRow:phoneBut.titleLabel.text];
    [phoneTVC setSortWayBtn:phoneBut];
    popoController = [[UIPopoverController alloc] initWithContentViewController:phoneTVC];
    CGRect frame = [self.view convertRect:phoneBut.frame fromView:phoneBut.superview];
    popoController.popoverContentSize = CGSizeMake(400, 60*phoneArray.count+44);
    [popoController presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}


- (void)PopoTableViewController:(PopoTableViewController *)popoTableVC seleckChanged:(NSString *)seleckStr andseleckRow:(NSInteger)row andselectBtn:(UIButton *)selecBtn
{
    if (selecBtn == phoneNumBut) {
        
        [selecBtn setTitle:seleckStr forState:UIControlStateNormal];
    }else {
        [jibieBut setText:seleckStr];
    }
    [popoController dismissPopoverAnimated:YES];
}


- (void)biaoQianView:(BiaoQianView *)biaoqian selectBiaoqian:(NSString *)selectString
{
    biaoqianString = [NSString stringWithFormat:@"%@",selectString];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==jibieBut) {
        PopoTableViewController *dengjiVC = [[PopoTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [dengjiVC setPopoTabelDelegate:self];
        NSArray *aarray = [NSArray arrayWithContentsOfFile:KbuyerStatusOther];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSInteger i = 0; i<aarray.count; i++) {
            NSDictionary *dataM = aarray[i];
            [arrayM addObject:[dataM objectForKey:@"name"]];
            if ([jibieBut.text isEqualToString:[dataM objectForKey:@"name"]]) {
                [dengjiVC setSelectRow:[NSString stringWithFormat:@"%d",i]];
            }
        }
        
        [dengjiVC setArray:arrayM];
        popoController = [[UIPopoverController alloc] initWithContentViewController:dengjiVC];
        popoController.popoverContentSize = CGSizeMake(480, 400);
        [popoController presentPopoverFromRect:jibieBut.frame inView:self.scorllView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        return NO;
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == otherCauseTextF) {
        [self.scorllView setContentOffset:CGPointMake(0, 140) animated:YES];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == otherCauseTextF) {
       [self.scorllView setContentOffset:CGPointZero animated:YES];
        [textField resignFirstResponder];
    } else if (textField == phoneTextF) {
        [phoneNumBut setTitle:textField.text forState:UIControlStateNormal];
    }
}

- (void)sendMessgaChangde:(UISwitch*)messwitch
{
    if (phoneTextF.text.length>0) {
        
        if (messgeSwitch.isOn) {
            [phoneNumBut setHidden:NO];
            [phoneNumBut setTitle:phoneTextF.text forState:UIControlStateNormal];
            [messgeTextView setTextColor:[UIColor blackColor]];
            [messgeTextView setUserInteractionEnabled:YES];
        }else {
            [phoneNumBut setHidden:YES];
            [messgeTextView setUserInteractionEnabled:NO];
            [messgeTextView setTextColor:[UIColor lightGrayColor]];
        }
    }else {
        [messwitch setOn:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该客户暂无手机号" message:@"请到个人信息添加" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.scorllView setContentOffset:CGPointMake(0, 240) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scorllView setContentOffset:CGPointZero animated:YES];
}

- (void)cancelItemCilck
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)saveItemReceive
{
    if (phoneTextF.text.length>0) {
        if (![NSString phoneValidate:phoneTextF.text]) return;
    }
    
    leaveString = [NSString stringWithFormat:@"%@%@",biaoqianString,otherCauseTextF.text];
    if (!(leaveString.length>0&&jibieBut.text.length>0)) {
        
        [ProgressHUD showError:@"请选择用户等级或离店原因！"];
        return;
    }
    [MobClick event:KendReception attributes:@{@"sellName":KUserName}];
    if (isHuifang) {
        [HttpManager closeVisit:@{@"salerId": KUserName,@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
            if ([obj objectForKey:@"errorMessage"]) {
                [ProgressHUD showError:[obj objectForKey:@"errorMessage"]];
            }else {
                [self addOrUpdateVisit];
            }
        } fail:^(id obj) {
            [ProgressHUD showError:@"保存失败"];
        }];

    }else {
        [self addOrUpdateVisit];
    }
    
}

- (void)addOrUpdateVisit
{
    if (huifangSw.on) {
        NSDate *date = [Date_String dateFromString:_huifangBut.titleLabel.text format:@"yyyy-MM-dd"];
        if (!date) {
            [ProgressHUD showError:@"请选择回访时间"];
        }else {
            [HttpManager addOrUpdateVisit:@{@"salerId": KUserName,@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"date":_huifangBut.titleLabel.text} Success:^(id obj) {
                if ([obj objectForKey:@"errorMessage"]) {                         [ProgressHUD showError:[obj objectForKey:@"errorMessage"]];
                    return ;
                }else {
                    NSMutableDictionary *commDateDic = [NSMutableDictionary dictionary];
                    [commDateDic removeAllObjects];
                    
                    [commDateDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
                    [commDateDic setObject:KUserName forKey:@"userName"];
                    
                    [commDateDic setObject:[NSString stringWithFormat:@"该客户%@前均由销售%@回访。",_huifangBut.titleLabel.text,[[NSUserDefaults standardUserDefaults] objectForKey:KSellName]] forKey:@"comment"];
                    
                    [commDateDic setObject:@"A" forKey:@"store"];
                    [HttpManager requestUpdateReservationDateByUser:commDateDic Success:^(id obj) {
                        if ([obj objectForKey:@"succeedMessage"]) {
                            
                            [self endReceiveUser];
                        }
                    } fail:^(id obj) {
                        
                    }];
                }
            } fail:^(id obj) {
                [ProgressHUD showError:@"保存失败"];
            }];
        }
    }else {
        [self endReceiveUser];
    }

}

- (void)endReceiveUser
{
    
        NSMutableDictionary *requDic = [NSMutableDictionary dictionary];
        [requDic setObject:self.userInfoM.crmUserId forKey:@"user"];
        [requDic setObject:nameTextF.text forKey:@"name"];
        if (KUserName) {
            [requDic setObject:KUserName forKey:@"userName"];
        }
        [requDic setObject:phoneTextF.text forKey:@"phone"];
        NSArray *aarray = [NSArray arrayWithContentsOfFile:KbuyerStatusOther];
        for (NSDictionary *dic in aarray) {
            if ([jibieBut.text isEqualToString:[dic objectForKey:@"name"]]) {
                [requDic setObject:[dic objectForKey:@"code"] forKey:@"level"];
                continue;
            }
        }
        
        if (messgeSwitch.isOn&&phoneTextF.text.length) {
            [requDic setObject:@"1" forKey:@"isSendSMS"];
            [requDic setObject:phoneNumBut.titleLabel.text forKey:@"phoneSMS"];
            [requDic setObject:messgeTextView.text forKey:@"messageSMS"];
        }
        
        [requDic setObject:@"A"forKey:@"store"];
        [requDic setObject:leaveString forKey:@"comment"];
        
        
        if (!self.userInfoM.phone&&phoneTextF.text.length) {
            [NSString phoneValidate:phoneTextF.text];
            [HttpManager requestUserHandleByType:@{@"phone":phoneTextF.text,@"userTag":userVOM.userTag} Success:^(id obj) {
                [requDic setObject:obj forKey:@"user"];
                [HttpManager requestUserOutStore:requDic Success:^(id obj) {
                    NSDictionary *dicobj = [NSDictionary dictionaryWithDictionary:obj];
                    if ([dicobj objectForKey:@"succeedMessage"]) {
                        [ProgressHUD showSuccess:@"接待完成！"];
                        [self dismissViewControllerAnimated:YES completion:^{
                            if ([_delegate respondsToSelector:@selector(endReceiveController:)]) {
                                [_delegate endReceiveController:self];
                            }
                        }];
                    }
                } fail:^(id obj) {
                    
                }];
            } fail:^(id obj) {
                
            }];
        }else {
            [HttpManager requestUserOutStore:requDic Success:^(id obj) {
                NSDictionary *dicobj = [NSDictionary dictionaryWithDictionary:obj];
                if ([dicobj objectForKey:@"succeedMessage"]) {
                    [ProgressHUD showSuccess:@"接待完成！"];
                    [self dismissViewControllerAnimated:YES completion:^{
                        if ([_delegate respondsToSelector:@selector(endReceiveController:)]) {
                            [_delegate endReceiveController:self];
                        }
                        
                    }];
                }
            } fail:^(id obj) {
                
            }];
            
        }
}


- (void)dealloc
{
    popoController = nil;
}
@end
