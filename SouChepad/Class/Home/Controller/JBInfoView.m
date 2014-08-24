//
//  JBInfoView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-5.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "JBInfoView.h"
#import "CityPickViewController.h"
#import "DatePickViewController.h"
#import "CarTypeTableViewController.h"
#import "NSString+val.h"
#import "ProgressHUD.h"

@interface JBInfoView ()<QRadioButtonDelegate,CitypickViewDelegate,DatePickerVCdelegate,UITextFieldDelegate,CarTypeTableViewDelegate>
{
    UITableView *JBtableView;
    NSArray *array;
    NSArray *fuArray;
    UIButton *guohuCityBut;
    UIPopoverController *popoVC;
    UIScrollView *scrollView;
    UIButton *haveCarTypeBut;
}
@end

@implementation JBInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _userVo = userVo;
//        _userExtendM = userExtendM;
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [scrollView setContentSize:CGSizeMake(0, frame.size.height+50)];
        [self addSubview:scrollView];
        array = @[@"姓名",@"手机",@"性别",@"级别"];
        fuArray = @[@"指标",@"过户方式",@"付款方式",@"购车用途",@"拥有车辆",@"是否卖车",@"备注"];
        for (NSInteger i = 0; i<array.count; i++) {
            UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(40, 10+i*60, 60, 60)];
            [labe setFont:KFont18];
            [labe setText:array[i]];
            [scrollView addSubview:labe];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 10+i*60, frame.size.width-40, 1)];
            [lineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [lineView setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [scrollView addSubview:lineView];
            
            UIView *lineL = [[UIView alloc] initWithFrame:CGRectMake(20, 10+i*60, 1, 60)];
            [lineL setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [scrollView addSubview:lineL];
            
            UIView *lineR = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-20, 10+i*60, 1, 60)];
            [lineR setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin];
            
            [lineR setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [scrollView addSubview:lineR];
        }
        for (NSInteger j= 0; j<fuArray.count; j++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 280+j*60, 100, 60)];
            [label setFont:KFont18];
            [label setText:fuArray[j]];
            [scrollView addSubview:label];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 280+j*60, frame.size.width-40, 1)];
            [lineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [lineView setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [scrollView addSubview:lineView];
            
            UIView *lineL = [[UIView alloc] initWithFrame:CGRectMake(20, 280+j*60, 1, 60)];
            [lineL setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [scrollView addSubview:lineL];
            
            UIView *lineR = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-20, 280+j*60, 1, 60)];
            [lineR setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin];
            [lineR setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [scrollView addSubview:lineR];

        }
        
        self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 600, 60)];
        [self.nameText setPlaceholder:@"填写名字"];
        [scrollView addSubview:self.nameText];
        
        
        self.phoneText = [self phoneTextFieldFrame:CGRectMake(150, 70, 130, 60) placeholder:@"填写主号码"];
        [self.phoneText setLeftViewMode:UITextFieldViewModeNever];
        [scrollView addSubview:self.phoneText];
        
        
        self.phoneText1 = [self phoneTextFieldFrame:CGRectMake(300, 70, 130, 60) placeholder:@"备用手机号1"];
        [scrollView addSubview:self.phoneText1];
        
        
        self.phoneText2 = [self phoneTextFieldFrame:CGRectMake(450, 70, 130, 60) placeholder:@"备用手机号2"];
        [scrollView addSubview:self.phoneText2];
        
        
        self.phoneText3 = [self phoneTextFieldFrame:CGRectMake(600, 70, 130, 60) placeholder:@"备用手机号3"];
        [scrollView addSubview:self.phoneText3];
        
        self.phoneText4 = [self phoneTextFieldFrame:CGRectMake(750, 70, 155, 60) placeholder:@"备用手机号4"];
        [scrollView addSubview:self.phoneText4];
        
        self.manBut = [self QRbutWithFrame:CGRectMake(150, 130, 60, 60) andtitle:@"男" groupId:@"1"];
        [scrollView addSubview:self.manBut];
        self.womanBut = [self QRbutWithFrame:CGRectMake(CGRectGetMaxX(self.manBut.frame)+30, 130, 60, 60) andtitle:@"女" groupId:@"1"];
        [scrollView addSubview:self.womanBut];
        
        
        NSArray *aarray = [NSArray arrayWithContentsOfFile:KbuyerStatus];
        self.jibieButArray = [NSMutableArray arrayWithCapacity:aarray.count];
        for (NSInteger i = 0; i<aarray.count; i++) {
            NSDictionary *dataM = aarray[i];
            
            QRadioButton *dengji = [self QRbutWithFrame:CGRectMake(150+i*90, 190, 90, 60) andtitle:[dataM objectForKey:@"name"] groupId:@"2"];
            [scrollView addSubview:dengji];
            [self.jibieButArray addObject:dengji];
        }
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(20, 250, frame.size.width-40, 1)];
        [lineview setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lineview setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
        [scrollView addSubview:lineview];
        
        
        self.zhibiaoBut = [self QRbutWithFrame:CGRectMake(150, 280, 90, 60) andtitle:@"有" groupId:@"3"];
        [scrollView addSubview:self.zhibiaoBut];
        self.zhibiaoNOBut = [self QRbutWithFrame:CGRectMake(240, 280, 90, 60) andtitle:@"无" groupId:@"3"];
        [scrollView addSubview:self.zhibiaoNOBut];
        
       self.zhibiaoDateBut = [self buttonChooes:CGRectMake(700, 295, 120, 30) andtitle:@"过期时间"];
        [self.zhibiaoDateBut setHidden:YES];
        [self.zhibiaoDateBut addTarget:self action:@selector(chooseZhibiaoDate:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:self.zhibiaoDateBut];
        
        self.guoHuTypeBut = [self QRbutWithFrame:CGRectMake(150, 340, 90, 60) andtitle:@"本市" groupId:@"4"];
        [scrollView addSubview:self.guoHuTypeBut];
        self.guoHuwaiBut = [self QRbutWithFrame:CGRectMake(240, 340, 90, 60) andtitle:@"外迁" groupId:@"4"];
        [scrollView addSubview:self.guoHuwaiBut];
        guohuCityBut = [self buttonChooes:CGRectMake(600, 350, 250, 40) andtitle:@"过户省市"];
        [guohuCityBut addTarget:self action:@selector(chooseGuohuCity:) forControlEvents:UIControlEventTouchUpInside];
        [guohuCityBut setHidden:YES];
#warning 过户**__*_*__*_*_*_*_*___*_*_*_*_*
        [scrollView addSubview:guohuCityBut];
        self.guohudi = [[HZLocation alloc] init];
        
        self.fuKuanTypeBut = [self QRbutWithFrame:CGRectMake(150, 400, 90, 60) andtitle:@"全款" groupId:@"5"];
        [scrollView addSubview:self.fuKuanTypeBut];
        self.fuKuanFenqi = [self QRbutWithFrame:CGRectMake(240, 400, 90, 60) andtitle:@"分期" groupId:@"5"];
        [scrollView addSubview:self.fuKuanFenqi];

        
        self.yongtuBut = [self QRbutWithFrame:CGRectMake(150, 460, 110, 60) andtitle:@"新手练车" groupId:@"6"];
        [scrollView addSubview:self.yongtuBut];
        self.yongtujiaBut = [self QRbutWithFrame:CGRectMake(260, 460, 110, 60) andtitle:@"家用代步" groupId:@"6"];
        [scrollView addSubview:self.yongtujiaBut];
        self.yongtubiaoBut = [self QRbutWithFrame:CGRectMake(370, 460, 110, 60) andtitle:@"占标车" groupId:@"6"];
        [scrollView addSubview:self.yongtubiaoBut];
        self.yongtubuBut = [self QRbutWithFrame:CGRectMake(480, 460, 110, 60) andtitle:@"代步" groupId:@"6"];
        [scrollView addSubview:self.yongtubuBut];
        self.yongtuArray = @[self.yongtuBut,self.yongtubiaoBut,self.yongtujiaBut,self.yongtubuBut];
        
        self.haveCarBut = [self QRbutWithFrame:CGRectMake(150, 520, 90, 60) andtitle:@"有" groupId:@"7"];
        [scrollView addSubview:self.haveCarBut];
        self.haveNocarBut = [self QRbutWithFrame:CGRectMake(240, 520, 90, 60) andtitle:@"无" groupId:@"7"];
        [scrollView addSubview:self.haveNocarBut];
        haveCarTypeBut = [self buttonChooes:CGRectMake(600, 530, 250, 40) andtitle:@"车型  车系"];
        [haveCarTypeBut setHidden:YES];
        [haveCarTypeBut addTarget:self action:@selector(showAllCarType:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:haveCarTypeBut];
        
        
        self.maicheBut = [self QRbutWithFrame:CGRectMake(150, 580, 90, 60) andtitle:@"是" groupId:@"8"];
        [scrollView addSubview:self.maicheBut];
        self.maicheNOBut = [self QRbutWithFrame:CGRectMake(240, 580, 90, 60) andtitle:@"否" groupId:@"8"];
        [scrollView addSubview:self.maicheNOBut];
        
        self.beizhuTextF = [[UITextField alloc] initWithFrame:CGRectMake(150, 650, 730, 40)];
        [self.beizhuTextF setBorderStyle:UITextBorderStyleRoundedRect];
        [self.beizhuTextF setPlaceholder:@"填写客户备注信息"];

        [self.beizhuTextF setDelegate:self];
        [scrollView addSubview:self.beizhuTextF];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 700, frame.size.width-40, 1)];
        [line setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [line setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
        [scrollView addSubview:line];
    }
    return self;
}

- (void)showAllCarType:(UIButton *)but
{
    CarTypeTableViewController *carTypeVC = [[CarTypeTableViewController alloc] init];
    [carTypeVC setDelegate:self];
    UINavigationController *carNav = [[UINavigationController alloc] initWithRootViewController:carTypeVC];
    popoVC = [[UIPopoverController alloc] initWithContentViewController:carNav];
    popoVC.popoverContentSize = CGSizeMake(540, 620);
    [popoVC presentPopoverFromRect:but.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)carTypeTableView:(CarTypeTableViewController *)carTypetable selectCarDic:(NSDictionary *)selectCarDic
{
    self.cardBankCode = [selectCarDic objectForKey:@"brandCode"];
    NSString *carName;
    if ([selectCarDic objectForKey:@"seriesName"]) {
        
        carName = [NSString stringWithFormat:@"%@ %@",[selectCarDic objectForKey:@"brandName"],[selectCarDic objectForKey:@"seriesName"]];
        self.carSerisCode = [selectCarDic objectForKey:@"seriesCode"];
    }else{
        carName = [NSString stringWithFormat:@"%@",[selectCarDic objectForKey:@"brandName"]];
    }   
    [haveCarTypeBut setTitle:carName forState:UIControlStateNormal];
    [popoVC dismissPopoverAnimated:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.beizhuTextF) {
        
        [scrollView setContentOffset:CGPointMake(0, 450) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.beizhuTextF) {
        [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
    if ((textField == self.phoneText||textField == self.phoneText1||textField == self.phoneText2|| textField == self.phoneText3 ||textField == self.phoneText4)&&textField.text.length) {
        if (![NSString phoneValidate:textField.text]) {
//            [textField setText:nil];
        }
    }
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
   UserVOModel *userVo = [dataDic objectForKey:@"user"];
   UserExtendModel *userExtendM = [dataDic objectForKey:@"userExtend"];
    [self.nameText setText:userVo.userName];
    [self.phoneText setText:userVo.phone];
    [self.phoneText1 setText:userVo.callPhone1];
    [self.phoneText2 setText:userVo.callPhone2];
    [self.phoneText3 setText:userVo.callPhone3];
    [self.phoneText4 setText:userVo.callPhone4];
    
    if ([userVo.sex isEqualToString:@"man"]) {
        [self.manBut setChecked:YES];
    }else if ([userVo.sex isEqualToString:@"woman"]) {
        [self.womanBut setChecked:YES];
    }
    
    NSArray *aarray = [NSArray arrayWithContentsOfFile:KbuyerStatus];
    for (NSInteger i = 0; i<aarray.count; i++) {
        NSDictionary *dataM = aarray[i];
        QRadioButton *dengji = self.jibieButArray[i];
        if ([userVo.userStatus isEqualToString:[dataM objectForKey:@"code"]]) {
            [dengji setChecked:YES];
        }
    }
    
    for (QRadioButton *yongtu in self.yongtuArray) {
        if ([userExtendM.carUsed isEqualToString:yongtu.titleLabel.text]) {
            [yongtu setChecked:YES];
        }
    }
    if ([userExtendM.carTarget isEqualToString:@"1"]) {
        [self.zhibiaoBut setChecked:YES];
        [self.zhibiaoDateBut setHidden:NO];
        [self.zhibiaoDateBut setTitle:userExtendM.carTargetEndDate?userExtendM.carTargetEndDate:@"过期时间" forState:UIControlStateNormal];
    }else if ([userExtendM.carTarget isEqualToString:@"0"]){
        [self.zhibiaoNOBut setChecked:YES];
        [self.zhibiaoDateBut setHidden:YES];
    }
    
    if ([userExtendM.insureType isEqualToString:@"this_city"]) {
        [self.guoHuTypeBut setChecked:YES];
    }else if ([userExtendM.insureType isEqualToString:@"outside_move"]){
        [self.guoHuwaiBut setChecked:YES];
        NSString *guohu = @"过户省市";
        if (userExtendM.insureCityName) {
            guohu = [NSString stringWithFormat:@"%@  %@",userExtendM.insureProvinceName,userExtendM.insureCityName];
            self.guohudi.stateCode = userExtendM.insureProvince;
            self.guohudi.state = userExtendM.insureProvinceName;
            self.guohudi.cityCode = userExtendM.insureCity;
            self.guohudi.city = userExtendM.insureCityName;
        }else if (userExtendM.insureProvinceName){
            guohu = userExtendM.insureProvinceName;
            self.guohudi.stateCode = userExtendM.insureProvince;
        }
        [guohuCityBut setTitle:guohu forState:UIControlStateNormal];
    }
    
    if ([userExtendM.payType isEqualToString:@"fullpay"]) {
        [self.fuKuanTypeBut setChecked:YES];
    }else if ([userExtendM.payType isEqualToString:@"partpay"]){
        [self.fuKuanFenqi setChecked:YES];
    }
    
    if ([userExtendM.isHaveCar isEqualToString:@"1"]) {
        [self.haveCarBut setChecked:YES];
        [self.maicheNOBut setUserInteractionEnabled:YES];
        [self.maicheBut setUserInteractionEnabled:YES];
        [haveCarTypeBut setHidden:NO];
        NSString *carName = @"车型  车系";
        if (userExtendM.seriesName) {
            carName = [NSString stringWithFormat:@"%@  %@",userExtendM.brandName,userExtendM.seriesName];
        }else if (userExtendM.brandName){
            carName = userExtendM.brandName;
        }
        [haveCarTypeBut setTitle:carName forState:UIControlStateNormal];
        
    }else if ([userExtendM.isHaveCar isEqualToString:@"0"]){
        [self.haveNocarBut setChecked:YES];
        [self.maicheBut setUserInteractionEnabled:NO];
        [self.maicheNOBut setUserInteractionEnabled:NO];
        [haveCarTypeBut setHidden:YES];
    }
    
    
    if ([userExtendM.isSellCar isEqualToString:@"1"]) {
        [self.maicheBut setChecked:YES];
    }else if ([userExtendM.isSellCar isEqualToString:@"0"]){
        [self.maicheNOBut setChecked:YES];
    }
    
    [self.beizhuTextF setText:userExtendM.remark];
}

- (void)chooseGuohuCity:(UIButton *)button
{
    CityPickViewController *cityPick = [[CityPickViewController alloc] init];
    [cityPick setDelegate:self];
    [cityPick setHzLocat:self.guohudi];
    popoVC = [[UIPopoverController alloc] initWithContentViewController:cityPick];
    popoVC.popoverContentSize = CGSizeMake(450, 260);
    [popoVC presentPopoverFromRect:button.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


#pragma mark - delegate
- (void)cityPickView:(CityPickViewController *)cityPickVC HZlocation:(HZLocation *)hzLocation
{
    self.guohudi = hzLocation;
    [guohuCityBut setTitle:[NSString stringWithFormat:@"%@  %@",hzLocation.state,hzLocation.city] forState:UIControlStateNormal];
}


- (void)chooseZhibiaoDate:(UIButton *)button
{
    DatePickViewController *datePick = [[DatePickViewController alloc] init];
    [datePick setDelegate:self];
    popoVC = [[UIPopoverController alloc] initWithContentViewController:datePick];
    popoVC.popoverContentSize = CGSizeMake(320, 210);
    [popoVC presentPopoverFromRect:button.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)datePickerVC:(DatePickViewController *)datePickVC dateStr:(NSString *)datestr
{
    [self.zhibiaoDateBut setTitle:datestr forState:UIControlStateNormal];
}

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    if ([groupId isEqualToString:@"3"]) {
        if ([radio.titleLabel.text isEqualToString:@"有"]) {
            [self.zhibiaoDateBut setHidden:NO];
        }else {
            [self.zhibiaoDateBut setHidden:YES];
        }
    }else if ([groupId isEqualToString:@"4"]){
        if ([radio.titleLabel.text isEqualToString:@"外迁"]) {
            [guohuCityBut setHidden:NO];
        }else{
            [guohuCityBut setHidden:YES];
        }
    }else if ([groupId isEqualToString:@"7"]){
        if ([radio.titleLabel.text isEqualToString:@"有"]) {
            [self.maicheBut setUserInteractionEnabled:YES];
            [self.maicheNOBut setUserInteractionEnabled:YES];
            [haveCarTypeBut setHidden:NO];
        }else {
            [self.maicheNOBut setUserInteractionEnabled:NO];
            [self.maicheBut setUserInteractionEnabled:NO];
            [self.maicheBut setChecked:NO];
            [self.maicheNOBut setChecked:NO];
            [haveCarTypeBut setHidden:YES];
        }
    }
}


- (UIButton*)buttonChooes:(CGRect)frmae andtitle:(NSString*)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:frmae];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[[UIColor hexStringToColor:KBaseColo] CGColor]];
    [button.layer setCornerRadius:5];
    return button;
}

-(QRadioButton *)QRbutWithFrame:(CGRect)frame andtitle:(NSString *)title groupId:(NSString *)groupId
{
    QRadioButton *womanBut = [[QRadioButton alloc] initWithDelegate:self groupId:groupId];
    [womanBut setFrame:frame];
    [womanBut setTitle:title forState:UIControlStateNormal];
    [womanBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [womanBut setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateSelected];
    return womanBut;
}


- (UITextField *)phoneTextFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    UITextField *phoneText = [[UITextField alloc] initWithFrame:frame];
    [phoneText setDelegate:self];
    [phoneText setKeyboardType:UIKeyboardTypePhonePad];
//    [phoneText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneText setPlaceholder:placeholder];
    UIView *vei1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 1, 40)];
    [vei1 setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
    [phoneText setRightViewMode:UITextFieldViewModeAlways];
    [phoneText setRightView:vei1];
//    [phoneText setLeftViewMode:UITextFieldViewModeAlways];
//    [phoneText setLeftView:vei1];
    return phoneText;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField == self.phoneText||textField == self.phoneText1||textField == self.phoneText2|| textField == self.phoneText3 ||textField == self.phoneText4)&&range.location > 10) {

            return NO;
        }
    
    return YES;
}



@end
