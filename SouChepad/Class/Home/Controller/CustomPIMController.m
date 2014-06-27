//
//  CustomPIMController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CustomPIMController.h"
//#import "FZInfoView.h"
#import "JBInfoView.h"
#import "HttpManager.h"
#import "FuZhuInfoView.h"
#import "UserReservationM.h"
#import "UserVOModel.h"
#import "UserExtendModel.h"
#import "QRadioButton.h"


@interface CustomPIMController ()
{
    UserExtendModel *userExtendmodel;
    UserVOModel *userVomodel;
    JBInfoView *_jbInfoView;
    
    FuZhuInfoView *_fuzhuView;
}
@end

@implementation CustomPIMController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 1.添加toolbar
    [self addToolbar];
    
    [HttpManager requestUserInfoWithParamDic:@{@"userId":self.userInfoM.crmUserId} Success:^(id obj) {
        NSDictionary *dataInfoDic = [NSDictionary dictionaryWithDictionary:obj];
        userVomodel = [dataInfoDic objectForKey:@"user"];
        userExtendmodel = [dataInfoDic objectForKey:@"userExtend"];
        if (userExtendmodel&&userVomodel) {
            
            // 添加基本信息view
            [self addBasicInfoView];
            UIButton *saveUserInfoBut = [[UIButton alloc] initWithFrame:CGRectMake(750, 35, 150, 40)];
            [saveUserInfoBut setTitle:@"保存修改信息" forState:UIControlStateNormal];
            [saveUserInfoBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [saveUserInfoBut addTarget:self action:@selector(saveUserInfoClickt) forControlEvents:UIControlEventTouchUpInside];
            [self.headBar addSubview:saveUserInfoBut];
            
        }
        
    } fail:^(id obj) {
        
    }];
}

- (void)saveUserInfoClickt
{
    if (_jbInfoView) {
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
        [reqDic setObject:self.userInfoM.crmUserId forKey:@"userId"];
        [reqDic setObject:_jbInfoView.phoneText.text forKey:@"phone"];
        [reqDic setObject:_jbInfoView.nameText.text forKey:@"name"];
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
            }
        }
        
        if (_jbInfoView.zhibiaoBut.checked) {
            [reqDic setObject:@"1" forKey:@"carTarget"];
            
        }else if(_jbInfoView.zhibiaoBut.checked) {
            [reqDic setObject:@"0" forKey:@"carTarget"];
        }
        if (_jbInfoView.guoHuTypeBut.checked) {
            [reqDic setObject:@"1" forKey:@"insureType"];
        }else if (_jbInfoView.guoHuwaiBut.checked){
            [reqDic setObject:@"0" forKey:@"insureType"];
        }
        if (_jbInfoView.fuKuanFenqi.checked) {
            [reqDic setObject:@"1" forKey:@"payType"];
        }else if (_jbInfoView.fuKuanTypeBut.checked){
            [reqDic setObject:@"0" forKey:@"payType"];
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
        
        [HttpManager requestUpdtaeUser:reqDic Success:^(id obj) {
            DLog(@"%@",obj);
        } fail:^(id obj) {
            
        }];
    }
}

- (void)addToolbar
{
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"基本信息",@"辅助信息"]];
    [seg setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [seg setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:19] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    [seg setCenter:self.headBar.center];
    [seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    [seg setTintColor:[UIColor whiteColor]];
    [seg setBounds:CGRectMake(0, 0, 260, 40)];
    [seg setSelectedSegmentIndex:0];
    [self.headBar addSubview:seg];
}

- (void)segChanged:(UISegmentedControl*)seg
{
    switch (seg.selectedSegmentIndex) {
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
    if (_jbInfoView == nil) {
        
        JBInfoView *jbInfo = [[JBInfoView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) userVOModel:userVomodel userExtendmodel:userExtendmodel];
        [jbInfo setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _jbInfoView = jbInfo;
    }
    [self.view addSubview:_jbInfoView];

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
