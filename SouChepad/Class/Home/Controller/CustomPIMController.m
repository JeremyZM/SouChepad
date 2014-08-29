//
//  CustomPIMController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CustomPIMController.h"
#import "JBInfoView.h"
#import "HttpManager.h"
#import "FuZhuInfoView.h"
#import "UserReservationM.h"
#import "UserVOModel.h"
#import "UserExtendModel.h"
#import "QRadioButton.h"
#import "NSString+val.h"


@interface CustomPIMController ()
{
    UserExtendModel *userExtendmodel;
    UserVOModel *userVomodel;
    JBInfoView *_jbInfoView;
    NSDictionary *dataInfoDic;
    FuZhuInfoView *_fuzhuView;
    UISegmentedControl *seg;
    UIButton *saveUserInfoBut;
}
@end

@implementation CustomPIMController

- (void)dealloc
{
    [MobClick endLogPageView:@"基本信息"];
    [self saveUserInfoClickt];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [MobClick beginLogPageView:@"基本信息"];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataData) name:KUserImageChang object:nil];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 1.添加toolbar
    [self addToolbar];
    [self updataData];
}

- (void)updataData
{
    [HttpManager requestUserInfoWithParamDic:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
        dataInfoDic = [NSDictionary dictionaryWithDictionary:obj];
        userVomodel = [dataInfoDic objectForKey:@"user"];
        userExtendmodel = [dataInfoDic objectForKey:@"userExtend"];
        if (userExtendmodel&&userVomodel) {
            
            // 添加基本信息view
            [self addBasicInfoView];
        }
        
    } fail:^(id obj) {
        
    }];

}


- (void)saveUserInfoClickt
{
    if (_jbInfoView) {
        for (UIView *view in _jbInfoView.subviews) {
            for (UIView *viewSub in view.subviews) {
                if ([viewSub isKindOfClass:[UITextField class]]) {
                    [viewSub resignFirstResponder];
                }
            }
        }
        
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
        if (_jbInfoView.phoneText1.text.length) {
            if (![NSString phoneValidate:_jbInfoView.phoneText1.text]) return;
            
            [reqDic setObject:_jbInfoView.phoneText1.text forKey:@"callPhone1"];
        }
        if (_jbInfoView.phoneText2.text.length) {
            if (![NSString phoneValidate:_jbInfoView.phoneText2.text]) return;
            
            [reqDic setObject:_jbInfoView.phoneText2.text forKey:@"callPhone2"];
        }
        if (_jbInfoView.phoneText3.text.length) {
            if (![NSString phoneValidate:_jbInfoView.phoneText3.text]) return;
            
            [reqDic setObject:_jbInfoView.phoneText3.text forKey:@"callPhone3"];
        }
        if (_jbInfoView.phoneText4.text.length) {
            if (![NSString phoneValidate:_jbInfoView.phoneText4.text]) return;
            
            [reqDic setObject:_jbInfoView.phoneText4.text forKey:@"callPhone4"];
        }
        
        if (_jbInfoView.cardBankCode) {
            [reqDic setObject:_jbInfoView.cardBankCode forKey:@"carBrand"];
        }
        if (_jbInfoView.carSerisCode) {
            [reqDic setObject:_jbInfoView.carSerisCode forKey:@"carSeris"];
        }

        [reqDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"userId"];
        [reqDic setObject:_jbInfoView.nameText.text forKey:@"name"];
        [reqDic setObject:_jbInfoView.beizhuTextF.text forKey:@"remark"];
        
        if (_jbInfoView.manBut.checked) {
            [reqDic setObject:@"man" forKey:@"sex"];
        }else if (_jbInfoView.womanBut.checked){
            [reqDic setObject:@"woman" forKey:@"sex"];
        }
        for (NSInteger i = 0; i<_jbInfoView.jibieButArray.count; i++) {
            QRadioButton *dengjiBut = _jbInfoView.jibieButArray[i];
            if (dengjiBut.checked) {
                if ([dengjiBut.titleLabel.text isEqualToString:@"H级"]) {
                    [reqDic setObject:@"buyer_H_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"A级"]) {
                    [reqDic setObject:@"buyer_A_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"A-级"]) {
                    [reqDic setObject:@"buyer_A-_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"B级"]) {
                    [reqDic setObject:@"buyer_B_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"B-级"]) {
                    [reqDic setObject:@"buyer_B-_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"C级"]) {
                    [reqDic setObject:@"buyer_C_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"C-级"]) {
                    [reqDic setObject:@"buyer_C-_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"O1级"]) {
                    [reqDic setObject:@"buyer_O1_level" forKey:@"level"];
                }else if ([dengjiBut.titleLabel.text isEqualToString:@"O2级"]) {
                    [reqDic setObject:@"buyer_O2_level" forKey:@"level"];
                }
                continue;
            }
        }
        
        for (QRadioButton *yongtuB in _jbInfoView.yongtuArray) {
            if (yongtuB.checked) {
                [reqDic setObject:yongtuB.titleLabel.text forKey:@"carUsed"];
            }
        }
        
        // 指标
        if (_jbInfoView.zhibiaoBut.checked) {
            [reqDic setObject:@"1" forKey:@"carTarget"];
            if (![_jbInfoView.zhibiaoDateBut.titleLabel.text isEqualToString:@"过期时间"]) {
                [reqDic setObject:_jbInfoView.zhibiaoDateBut.titleLabel.text forKey:@"carTargetEndDate"];
            }
            
        }else if(_jbInfoView.zhibiaoNOBut.checked) {
            [reqDic setObject:@"0" forKey:@"carTarget"];
        }
        
        
        if (_jbInfoView.guoHuTypeBut.checked) {
            [reqDic setObject:@"this_city" forKey:@"insureType"];
        }else if (_jbInfoView.guoHuwaiBut.checked){
            [reqDic setObject:@"outside_move" forKey:@"insureType"];
            if (_jbInfoView.guohudi.stateCode) {
                
                [reqDic setObject:_jbInfoView.guohudi.stateCode forKey:@"insureProvince"];
            }
            if (_jbInfoView.guohudi.cityCode) {
                
                [reqDic setObject:_jbInfoView.guohudi.cityCode forKey:@"insureCity"];
            }
        }
        if (_jbInfoView.fuKuanFenqi.checked) {
            [reqDic setObject:@"partpay" forKey:@"payType"];
        }else if (_jbInfoView.fuKuanTypeBut.checked){
            [reqDic setObject:@"fullpay" forKey:@"payType"];
        }
        if (_jbInfoView.maicheBut.checked) {
            [reqDic setObject:@"1" forKey:@"isSellCar"];
        }else if(_jbInfoView.maicheNOBut.checked){
            [reqDic setObject:@"0" forKey:@"isSellCar"];
        }
        if (_jbInfoView.haveCarBut.checked) {
            [reqDic setObject:@"1" forKey:@"isHaveCar"];
        }else if(_jbInfoView.haveNocarBut.checked){
            [reqDic setObject:@"0" forKey:@"isHaveCar"];
        }

        if (!userVomodel.phone&&_jbInfoView.phoneText.text.length>0) {
            if (![NSString phoneValidate:_jbInfoView.phoneText.text]) return;
            [HttpManager requestUpdtaeUser:reqDic Success:^(id obj) {
                
                [HttpManager requestUserHandleByType:@{@"phone":_jbInfoView.phoneText.text,@"userTag":userVomodel.userTag} Success:^(id obj) {
                    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:@"userID"];
                    syncUserDefaults;
                    [HttpManager requestUserInfoWithParamDic:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]} Success:^(id obj) {
                        dataInfoDic = [NSDictionary dictionaryWithDictionary:obj];
                        userVomodel = [dataInfoDic objectForKey:@"user"];
                        userExtendmodel = [dataInfoDic objectForKey:@"userExtend"];
                        [_jbInfoView setDataDic:dataInfoDic];
                        [_fuzhuView setDataDic:dataInfoDic];
                    } fail:^(id obj) {
                        
                    }];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userIDchange" object:nil];
                } fail:^(id obj) {
                    
                }];
                
            } fail:^(id obj) {
                
            }];
        }else{
            if (_jbInfoView.phoneText.text.length>0) {
                if (![NSString phoneValidate:_jbInfoView.phoneText.text])  return;
            }
            [reqDic setObject:_jbInfoView.phoneText.text forKey:@"phone"];
            [HttpManager requestUpdtaeUser:reqDic Success:^(id obj) {
                
            } fail:^(id obj) {
                
            }];
        }
    }
}

- (void)addToolbar
{
    
    seg = [[UISegmentedControl alloc] initWithItems:@[@"基本信息",@"辅助信息"]];
    [seg setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [seg setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:19] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    [seg setCenter:self.headBar.center];
    [seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    [seg setTintColor:[UIColor whiteColor]];
    [seg setBounds:CGRectMake(0, 0, 260, 40)];
    [self.headBar addSubview:seg];
}

- (void)segChanged:(UISegmentedControl*)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            // 添加基本信息view
            [self addBasicInfoView];

            break;
        case 1:
            // 3.添加辅助信息view
            [self addauxiliaryInfoView];
            
            break;
        default:
            break;
    }
}



- (void)addBasicInfoView
{
    [_fuzhuView removeFromSuperview];
    [seg setSelectedSegmentIndex:0];
    if (saveUserInfoBut==nil) {
        saveUserInfoBut = [[UIButton alloc] initWithFrame:CGRectMake(750, 35, 150, 40)];
        [saveUserInfoBut setTitle:@"保存修改信息" forState:UIControlStateNormal];
        [saveUserInfoBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveUserInfoBut addTarget:self action:@selector(saveUserInfoClickt) forControlEvents:UIControlEventTouchUpInside];
        [self.headBar addSubview:saveUserInfoBut];
    }
    if (_jbInfoView == nil) {
        JBInfoView *jbInfo = [[JBInfoView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100)];
        [jbInfo setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _jbInfoView = jbInfo;
    }
    [self.view addSubview:_jbInfoView];
    [_jbInfoView setDataDic:dataInfoDic];

}

- (void)addauxiliaryInfoView
{
    [_jbInfoView removeFromSuperview];

    if (_fuzhuView==nil) {
        FuZhuInfoView *fztableView = [[FuZhuInfoView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) userVOModel:userVomodel userExtendmodel:userExtendmodel];
        [fztableView setCustomPIMVC:self];
        [fztableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _fuzhuView = fztableView;
    }
    
    [self.view addSubview:_fuzhuView];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
