//
//  LookCarRecordController.m
//  Athena
//
//  Created by 张艳东 on 14-7-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "LookCarRecordController.h"
#import "QRadioButton.h"
#import "BiaoQianView.h"
#import "ASValueTrackingSlider.h"
#import "UserOperationRecordVO.h"
#import "HttpManager.h"
#import "ProgressHUD.h"

@interface LookCarRecordController () <QRadioButtonDelegate,BiaoQianViewDelegate,UITextViewDelegate,ASValueTrackingSliderDataSource>
{
    NSMutableDictionary *requestDic;
    NSString *outcomeStr;
}

@property (nonatomic, strong) UserOperationRecordVO *userOperVO;

@end

@implementation LookCarRecordController

- (void)viewWillAppear:(BOOL)animated
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    [HttpManager lastCarLookOrDrive:@{@"carId":self.carID,@"user":userID,@"type":@"lookcar"} Success:^(id obj) {
//        userOperVO = obj;
        [self setDataUserOperVO:obj];
    } fail:^(id obj) {
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationItem setTitle:@"填写看车记录"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelfController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveLookCarRecord:)];
    
    self.priceSlider.popUpViewColor = [UIColor hexStringToColor:KBaseColo];
    self.priceSlider.font = KBoldFont18;
    [self.priceSlider showPopUpView];
    [self.priceSlider setDataSource:self];
//    self.priceSlider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    
    
    
    requestDic = [NSMutableDictionary dictionary];
    
    [self.highBut setGroupId:@"1"];
    [self.highBut setDelegate:self];
    
    [self.middleBut setGroupId:@"1"];
    [self.middleBut setDelegate:self];
    
    [self.lowBut setGroupId:@"1"];
    [self.lowBut setDelegate:self];
    
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:KlookCarEvaluate];
    self.appraiseView = [[BiaoQianView alloc] initWithFrame:CGRectMake(110, 197, 409, 250)];
    [self.appraiseView setDataArray:dataArray];
    [self.appraiseView setDelegate:self];
    [self.scrollView addSubview:self.appraiseView];
    
    self.otherAppraiseTextV = [[UITextView alloc] initWithFrame:CGRectMake(20, 460, 500, 80)];
    [self.otherAppraiseTextV setFont:KFont18];
    [self.otherAppraiseTextV.layer setCornerRadius:5.0];
    [self.otherAppraiseTextV.layer setBorderWidth:1.0];
    [self.otherAppraiseTextV.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.otherAppraiseTextV setDelegate:self];
    [self.scrollView addSubview:self.otherAppraiseTextV];
}

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value
{
    return [NSString stringWithFormat:@"%.2f",value];
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, -44) animated:YES];
}

- (void)biaoQianView:(BiaoQianView *)biaoqian selectBiaoqian:(NSString *)selectString
{
    outcomeStr = selectString;
}


- (void)setDataUserOperVO:(UserOperationRecordVO *)userOperVO
{
    [self.nameTextF setText:userOperVO.name];
    if (userOperVO.salerPrice) {
        
        [self.priceSlider setMaximumValue:[userOperVO.salerPrice floatValue]];
        [self.priceSlider setMinimumValue:[userOperVO.salerPrice floatValue]*0.9];
    }
    if (userOperVO.userPrice) {
        [self.priceSlider setValue:[userOperVO.userPrice floatValue] animated:YES];
    }else{
        [self.priceSlider setValue:self.priceSlider.maximumValue];
    }
    [self.otherAppraiseTextV setText:userOperVO.outcome];
    if ([userOperVO.satisfaction isEqualToString:@"高"]) {
        [self.highBut setChecked:YES];
    }else if ([userOperVO.satisfaction isEqualToString:@"中"]){
        [self.middleBut setChecked:YES];
    }else if ([userOperVO.satisfaction isEqualToString:@"低"]){
        [self.lowBut setChecked:YES];
    }
    

}


- (void)dismissSelfController:(UIBarButtonItem*)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)saveLookCarRecord:(UIBarButtonItem*)item
{
    [requestDic setObject:self.nameTextF.text forKey:@"name"];
    [requestDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forKey:@"userName"];
    [requestDic setObject:[NSString stringWithFormat:@"%.2f",self.priceSlider.value] forKey:@"userPrice"];
    if (self.highBut.checked) {
        [requestDic setObject:self.highBut.titleLabel.text forKey:@"satisfaction"];
    }else if (self.middleBut.checked){
        [requestDic setObject:self.middleBut.titleLabel.text forKey:@"satisfaction"];
    }else if (self.lowBut.checked){
        [requestDic setObject:self.lowBut.titleLabel.text forKey:@"satisfaction"];
    }
    [requestDic setObject:self.carID forKey:@"carId"];
    [requestDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
    NSString *outcome = [NSString stringWithFormat:@"%@%@",outcomeStr,self.otherAppraiseTextV.text];
    if (outcomeStr||self.otherAppraiseTextV.text.length) {
        
        [requestDic setObject:outcome forKey:@"outcome"];
    }
    
    [HttpManager saveLookCarRecord:requestDic Success:^(id obj) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [ProgressHUD showSuccess:@"保存成功"];
        }];
    } fail:^(id obj) {
        
    }];
    
    
}


@end
