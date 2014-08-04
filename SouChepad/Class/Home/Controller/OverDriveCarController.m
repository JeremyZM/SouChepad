//
//  OverDriveCarController.m
//  Athena
//
//  Created by 张艳东 on 14-7-25.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "OverDriveCarController.h"
#import "DriveCarLastData.h"
#import "QRadioButton.h"
#import "ASValueTrackingSlider.h"
#import "BiaoQianView.h"
#import "ProgressHUD.h"
#import "HttpManager.h"

@interface OverDriveCarController () <QRadioButtonDelegate,ASValueTrackingSliderDataSource,BiaoQianViewDelegate,UITextViewDelegate>
{
    NSMutableDictionary *requestDic;
    NSString *outcomeStr;
}
@property (strong, nonatomic) BiaoQianView *appraiseView;

@property (strong, nonatomic) UITextView *otherAppraiseTextV;
@end

@implementation OverDriveCarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"试驾中"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"稍后处理" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelfController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"结束试驾" style:UIBarButtonItemStyleBordered target:self action:@selector(saveOverDriveCarRecord:)];
    
    requestDic = [NSMutableDictionary dictionary];
    
    self.priceSlider.popUpViewColor = [UIColor hexStringToColor:KBaseColo];
    self.priceSlider.font = KBoldFont18;
    [self.priceSlider showPopUpView];
    [self.priceSlider setDataSource:self];
    
    [self.highBut setGroupId:@"1"];
    [self.highBut setDelegate:self];
    
    [self.middlingBut setGroupId:@"1"];
    [self.middlingBut setDelegate:self];
    
    [self.lowBut setGroupId:@"1"];
    [self.lowBut setDelegate:self];
    
    
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:KdriveCarEvaluate];
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
    
    [self setDriveCarDataM:self.driveCarDataM];
    
}

- (void)setDriveCarDataM:(DriveCarLastData *)driveCarDataM
{
    _driveCarDataM = driveCarDataM;
    if (driveCarDataM.salerPrice) {
        
        [self.priceSlider setMaximumValue:[driveCarDataM.salerPrice floatValue]];
        [self.priceSlider setMinimumValue:[driveCarDataM.salerPrice floatValue]*0.9];
    }
    if (driveCarDataM.userPrice) {
        [self.priceSlider setValue:[driveCarDataM.userPrice floatValue] animated:YES];
    }else{
        [self.priceSlider setValue:self.priceSlider.maximumValue];
    }
    
}

- (void)biaoQianView:(BiaoQianView *)biaoqian selectBiaoqian:(NSString *)selectString
{
    outcomeStr = selectString;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, -44) animated:YES];
}


- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value
{
    return [NSString stringWithFormat:@"%.2f",value];
}


- (void)saveOverDriveCarRecord:(UIBarButtonItem*)item
{
    if ([self.endMileTextF.text integerValue]>=[self.driveCarDataM.driveBeginMile integerValue]) {
        
        [requestDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forKey:@"userName"];
        [requestDic setObject:[NSString stringWithFormat:@"%.2f",self.priceSlider.value] forKey:@"userPrice"];
        [requestDic setObject:self.carId forKey:@"carId"];
        [requestDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
        [requestDic setObject:self.endMileTextF.text forKey:@"endMile"];
        
        if (self.highBut.checked) {
            [requestDic setObject:self.highBut.titleLabel.text forKey:@"satisfaction"];
        }else if (self.middlingBut.checked){
            [requestDic setObject:self.middlingBut.titleLabel.text forKey:@"satisfaction"];
        }else if (self.lowBut.checked){
            [requestDic setObject:self.lowBut.titleLabel.text forKey:@"satisfaction"];
        }
        
        if (outcomeStr||self.otherAppraiseTextV.text.length) {
            if (outcomeStr) {
                NSString *outcome = [outcomeStr stringByAppendingString:self.otherAppraiseTextV.text];
                [requestDic setObject:outcome forKey:@"outcome"];
            }else{
                [requestDic setObject:self.otherAppraiseTextV.text forKey:@"outcome"];
            }
        }
        [HttpManager saveDriveCarEnd:requestDic Success:^(id obj) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [ProgressHUD showSuccess:@"保存成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
            }];
        } fail:^(id obj) {
            
        }];

    }else {
        [ProgressHUD showError:@"结束里程错误！"];
    }
    
}


- (void)dismissSelfController:(UIBarButtonItem*)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
