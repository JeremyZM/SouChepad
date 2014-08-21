//
//  AddCarController.m
//  Athena
//
//  Created by 张艳东 on 14-7-16.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "AddCarController.h"
#import "CarTypeTableViewController.h"
#import "HttpManager.h"
#import "ProgressHUD.h"

@interface AddCarController () <QradioButDelegate,CarTypeTableViewDelegate,UITextViewDelegate>
{
    NSMutableDictionary *reqCarDictionaryM;
}
@end    

@implementation AddCarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationItem setTitle:@"添加意向车型"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBar)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(saveBar)];
    
    reqCarDictionaryM = [NSMutableDictionary dictionary];
    [self.carTypeText setPlaceholder:@"请选择"];
    [self.carTypeText setFont:[UIFont systemFontOfSize:18]];
    
    // 排量
    [self.rankOneButton setCodeStr:@"0-1.0"];
    [self.rankTwoButton setCodeStr:@"1.1-1.6"];
    [self.rankThreeButton setCodeStr:@"1.6-2.0"];
    [self.rankFourButton setCodeStr:@"2.0-2.5"];
    [self.rankFiveButton setCodeStr:@"2.5-3.0"];
    [self.rankSixButton setCodeStr:@"3.0-4.0"];
    [self.rankSevenButton setCodeStr:@"4.0-1000"];
    
    self.rankArray = @[self.rankOneButton,self.rankTwoButton,self.rankThreeButton,self.rankFourButton,self.rankFiveButton,self.rankSixButton,self.rankSevenButton];
    for (QradioBut *rankBut in self.rankArray) {
        [rankBut setDelegate:self];
        [rankBut setGroupId:@"2"];
    }
    
    
    //颜色
    [self.AColoerBut setCodeStr:@"11"];
    [self.BColoerBut setCodeStr:@"6"];
    [self.CColoerBut setCodeStr:@"12"];
    [self.DColoerBut setCodeStr:@"10"];
    [self.EColoerBut setCodeStr:@"15"];
    [self.FColoerBut setCodeStr:@"5"];
    [self.GColoerBut setCodeStr:@"17"];
    [self.HColoerBut setCodeStr:@"7"];
    [self.IColoerBut setCodeStr:@"9"];
    [self.JColoerBut setCodeStr:@"4"];
    [self.KColoerBut setCodeStr:@"3"];
    [self.LColoerBut setCodeStr:@"2"];
    [self.MColoerBut setCodeStr:@"1"];

    self.coloerArray = @[self.AColoerBut,self.BColoerBut,self.CColoerBut,self.DColoerBut,self.EColoerBut,self.FColoerBut,self.GColoerBut,self.HColoerBut,self.IColoerBut,self.JColoerBut,self.KColoerBut,self.LColoerBut,self.MColoerBut];
    
    for (UIButton *coloerbut in self.coloerArray) {
        [coloerbut addTarget:self action:@selector(coloerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //变速箱
    [self.speedAutomaticBut setGroupId:@"1"];
    [self.speedAutomaticBut setDelegate:self];
    [self.speedManuaBut setDelegate:self];
    [self.speedManuaBut setGroupId:@"1"];
    
    // 需求强度
    [self.demandStrongButton setGroupId:@"3"];
    [self.demandStrongButton setDelegate:self];
    
    [self.demandModeraButton setGroupId:@"3"];
    [self.demandModeraButton setDelegate:self];
    
    [self.demandWeakButton setGroupId:@"3"];
    [self.demandWeakButton setDelegate:self];
    
    // 备注
    [self.remarkTextView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.remarkTextView.layer setCornerRadius:8.0];
    [self.remarkTextView.layer setBorderWidth:1.0];
    [self.remarkTextView.layer setMasksToBounds:YES];
    [self.remarkTextView setDelegate:self];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, 220) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointZero animated:YES];

}

- (void)coloerButtonClick:(UIButton*)colerBut
{
    [colerBut setSelected:!colerBut.selected];
}

- (void)didSelectedRadioButton:(QradioBut *)radio groupId:(NSString *)groupId
{
//    if ([groupId isEqualToString:@"1"]) {  // 变速箱
//        
//        
//    }else if ([groupId isEqualToString:@"2"]){ // 排量
//    
//    
//    }else if ([groupId isEqualToString:@"3"]){ // 需求强度
//    
//    
//    }
}


- (void)cancelBar
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)saveBar
{
    if ([reqCarDictionaryM objectForKey:@"brand"]) {
        
        [reqCarDictionaryM setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
        // 变速箱
        if (self.speedAutomaticBut.checked) { // 自动
            [reqCarDictionaryM setObject:@"transmission_auto" forKey:@"speedChanger"];
        }else if(self.speedManuaBut.checked){ // 手动
            [reqCarDictionaryM setObject:@"transmission_hand" forKey:@"speedChanger"];
        }
        
        // 排量
        for (QradioBut *rankBut in self.rankArray) {
            if (rankBut.checked) {
                [reqCarDictionaryM setObject:rankBut.codeStr forKey:@"displacement"];
                break;
            }
        }
        
        // 需求强度
        if (self.demandStrongButton.checked) {  // 强
            [reqCarDictionaryM setObject:self.demandStrongButton.titleLabel.text forKey:@"requirementLevel"];
        }else if (self.demandModeraButton.checked){ // 中
            [reqCarDictionaryM setObject:self.demandModeraButton.titleLabel.text forKey:@"requirementLevel"];
        }else if (self.demandWeakButton.checked){ // 弱
            [reqCarDictionaryM setObject:self.demandWeakButton.titleLabel.text forKey:@"requirementLevel"];
        }
        
        // 颜色
        NSMutableString *colorCodeStr = [NSMutableString string];
        for (ColoerBut *colorBut in self.coloerArray) {
            if (colorBut.selected) {
                [colorCodeStr appendFormat:@"%@,",colorBut.codeStr];
            }
        }
        if ([colorCodeStr hasSuffix:@","]) {
//            colorCodeStr deleteCharactersInRange:<#(NSRange)#>
            [reqCarDictionaryM setObject:[colorCodeStr substringToIndex:([colorCodeStr length]-1)] forKey:@"colors"];
        }else {
            [reqCarDictionaryM setObject:colorCodeStr forKey:@"colors"];
        }
        
        
        // 备注
        [reqCarDictionaryM setObject:self.remarkTextView.text forKey:@"remarks"];
        
        [HttpManager updateUserRequirementBrand:reqCarDictionaryM Success:^(id obj) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                if ([_delegate respondsToSelector:@selector(addCarCotrollerDismiss:)]) {
                    [_delegate addCarCotrollerDismiss:self];
                }
            }];
        } fail:^(id obj) {
            
        }];
    }else {
        [ProgressHUD showError:@"请选择车型！"];
    }

}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CarTypeTableViewController *carTypeVC = [[CarTypeTableViewController alloc] init];
    [carTypeVC setDelegate:self];
    [self.navigationController pushViewController:carTypeVC animated:YES];
    
    return NO;
}


- (void)carTypeTableView:(CarTypeTableViewController *)carTypetable selectCarDic:(NSDictionary *)selectCarDic
{
    NSString *carName;
    [reqCarDictionaryM setObject:[selectCarDic objectForKey:@"brandCode"] forKey:@"brand"];
    if ([selectCarDic objectForKey:@"seriesName"]) {
        
        carName = [NSString stringWithFormat:@"%@ %@",[selectCarDic objectForKey:@"brandName"],[selectCarDic objectForKey:@"seriesName"]];
        [reqCarDictionaryM setObject:[selectCarDic objectForKey:@"seriesCode"] forKey:@"series"];
    }else{
        carName = [NSString stringWithFormat:@"%@",[selectCarDic objectForKey:@"brandName"]];
    }
    [self.carTypeText setText:carName];
}



@end
