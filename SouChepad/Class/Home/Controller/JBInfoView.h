//
//  JBInfoView.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-5.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVOModel.h"
#import "UserExtendModel.h"
#import "QRadioButton.h"
#import "HZLocation.h"

@interface JBInfoView : UIView

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UserVOModel *userVo;
@property (nonatomic, strong) UserExtendModel *userExtendM;

@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UITextField *phoneText1;
@property (nonatomic, strong) UITextField *phoneText2;
@property (nonatomic, strong) UITextField *phoneText3;
@property (nonatomic, strong) UITextField *phoneText4;

@property (nonatomic, strong) QRadioButton *manBut;
@property (nonatomic, strong) QRadioButton *womanBut;
@property (nonatomic, strong) NSMutableArray *jibieButArray;

@property (nonatomic, strong) QRadioButton *zhibiaoBut;
@property (nonatomic, strong) QRadioButton *zhibiaoNOBut;
@property (nonatomic, strong)  UIButton *zhibiaoDateBut;


@property (nonatomic, strong) QRadioButton *guoHuTypeBut;
@property (nonatomic, strong) QRadioButton *guoHuwaiBut;
/** 过户省市 */
@property (nonatomic, strong) HZLocation *guohudi;



@property (nonatomic, strong) QRadioButton *fuKuanTypeBut;
@property (nonatomic, strong) QRadioButton *fuKuanFenqi;

@property (nonatomic, strong) NSArray *yongtuArray;
@property (nonatomic, strong) QRadioButton *yongtuBut;
@property (nonatomic, strong) QRadioButton *yongtujiaBut;
@property (nonatomic, strong) QRadioButton *yongtubiaoBut;
@property (nonatomic, strong) QRadioButton *yongtubuBut;

@property (nonatomic, strong) QRadioButton *haveCarBut;
@property (nonatomic, strong) QRadioButton *haveNocarBut;
/** 车型 */
@property (copy, nonatomic) NSString *cardBankCode;
/** 车系 */
@property (copy, nonatomic) NSString *carSerisCode;

@property (nonatomic, strong) QRadioButton *maicheBut;
@property (nonatomic, strong) QRadioButton *maicheNOBut;

@property (nonatomic, strong) UITextField *beizhuTextF;
@end
