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

@interface JBInfoView ()<QRadioButtonDelegate,CitypickViewDelegate,DatePickerVCdelegate>
{
    UITableView *JBtableView;
    NSArray *array;
    NSArray *fuArray;
    UIButton *zhibiaoDateBut;
    UIButton *guohuCityBut;
    UIPopoverController *popoVC;
}
@end

@implementation JBInfoView

- (id)initWithFrame:(CGRect)frame userVOModel:(UserVOModel*)userVo userExtendmodel:(UserExtendModel*)userExtendM
{
    self = [super initWithFrame:frame];
    if (self) {
        
        array = @[@"姓名",@"手机",@"性别",@"级别"];
        fuArray = @[@"指标",@"过户方式",@"付款方式",@"购车用途",@"拥有车辆",@"是否卖车"];
        for (NSInteger i = 0; i<array.count; i++) {
            UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(40, 10+i*60, 60, 60)];
            [labe setFont:KFont18];
            [labe setText:array[i]];
            [self addSubview:labe];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 10+i*60, frame.size.width-40, 1)];
            [lineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [lineView setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [self addSubview:lineView];
            
            UIView *lineL = [[UIView alloc] initWithFrame:CGRectMake(20, 10+i*60, 1, 60)];
            [lineL setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [self addSubview:lineL];
            
            UIView *lineR = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-20, 10+i*60, 1, 60)];
            [lineR setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin];
            
            [lineR setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [self addSubview:lineR];
        }
        for (NSInteger j= 0; j<fuArray.count; j++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 280+j*60, 100, 60)];
            [label setFont:KFont18];
            [label setText:fuArray[j]];
            [self addSubview:label];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 280+j*60, frame.size.width-40, 1)];
            [lineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [lineView setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [self addSubview:lineView];
            
            UIView *lineL = [[UIView alloc] initWithFrame:CGRectMake(20, 280+j*60, 1, 60)];
            [lineL setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [self addSubview:lineL];
            
            UIView *lineR = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-20, 280+j*60, 1, 60)];
            [lineR setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin];
            [lineR setBackgroundColor:[UIColor hexStringToColor:KSeparatorColor]];
            [self addSubview:lineR];

        }
        
        self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 600, 60)];
        if (![userVo.userName isEqualToString:@"暂无"]) {
            
            [self.nameText setText:userVo.userName];
        }
        [self.nameText setPlaceholder:@"填写名字"];
        [self addSubview:self.nameText];
        
        self.phoneText = [[UITextField alloc] initWithFrame:CGRectMake(150, 70, 600, 60)];
        [self.phoneText setPlaceholder:@"填写手机号"];
        if (![userVo.phone isEqualToString:@"暂无"]) {
            
            [self.phoneText setText:userVo.phone];
        }
        [self addSubview:self.phoneText];
        
        
        self.manBut = [self QRbutWithFrame:CGRectMake(150, 130, 60, 60) andtitle:@"男" groupId:@"1"];
        [self addSubview:self.manBut];
        self.womanBut = [self QRbutWithFrame:CGRectMake(CGRectGetMaxX(self.manBut.frame)+30, 130, 60, 60) andtitle:@"女" groupId:@"1"];
        [self addSubview:self.womanBut];
        if ([userVo.sex isEqualToString:@"man"]) {
            [self.manBut setChecked:YES];
        }else if ([userVo.sex isEqualToString:@"woman"]) {
            [self.womanBut setChecked:YES];
        }
        
        
        NSArray *aarray = [NSArray arrayWithContentsOfFile:KbuyerStatus];
        self.jibieButArray = [NSMutableArray arrayWithCapacity:aarray.count];
        for (NSInteger i = 0; i<aarray.count; i++) {
            NSDictionary *dataM = aarray[i];
            
            QRadioButton *dengji = [self QRbutWithFrame:CGRectMake(150+i*90, 190, 90, 60) andtitle:[dataM objectForKey:@"name"] groupId:@"2"];
            [self addSubview:dengji];
            if ([userVo.userStatus isEqualToString:[dataM objectForKey:@"code"]]) {
                [dengji setChecked:YES];
            }
            [self.jibieButArray addObject:dengji];
        }
        
        self.zhibiaoBut = [self QRbutWithFrame:CGRectMake(150, 280, 90, 60) andtitle:@"有" groupId:@"3"];
        [self addSubview:self.zhibiaoBut];
        self.zhibiaoNOBut = [self QRbutWithFrame:CGRectMake(240, 280, 90, 60) andtitle:@"无" groupId:@"3"];
        [self addSubview:self.zhibiaoNOBut];
        
        zhibiaoDateBut = [self buttonChooes:CGRectMake(700, 295, 120, 30) andtitle:@"过期时间"];
        [zhibiaoDateBut setHidden:YES];
        [zhibiaoDateBut addTarget:self action:@selector(chooseZhibiaoDate:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:zhibiaoDateBut];
        
        if ([userExtendM.carTarget isEqualToString:@"1"]) {
            [self.zhibiaoBut setChecked:YES];
            [zhibiaoDateBut setHidden:NO];
            [zhibiaoDateBut setTitle:userExtendM.carTargetEndDate forState:UIControlStateNormal];
        }else if ([userExtendM.carTarget isEqualToString:@"0"]){
            [self.zhibiaoNOBut setChecked:YES];
        }
        
        
        self.guoHuTypeBut = [self QRbutWithFrame:CGRectMake(150, 340, 90, 60) andtitle:@"本市" groupId:@"4"];
        [self addSubview:self.guoHuTypeBut];
        self.guoHuwaiBut = [self QRbutWithFrame:CGRectMake(240, 340, 90, 60) andtitle:@"外市" groupId:@"4"];
        [self addSubview:self.guoHuwaiBut];
        guohuCityBut = [self buttonChooes:CGRectMake(700, 355, 120, 30) andtitle:@"过户省市"];
        [guohuCityBut addTarget:self action:@selector(chooseGuohuCity:) forControlEvents:UIControlEventTouchUpInside];
        [guohuCityBut setHidden:YES];
        [self addSubview:guohuCityBut];
        if ([userExtendM.insureType isEqualToString:@"this_city"]) {
            [self.guoHuTypeBut setChecked:YES];
        }else if ([userExtendM.insureType isEqualToString:@"outside_move"]){
            [self.guoHuwaiBut setChecked:YES];
        }
        
        
        self.fuKuanTypeBut = [self QRbutWithFrame:CGRectMake(150, 400, 90, 60) andtitle:@"全款" groupId:@"5"];
        [self addSubview:self.fuKuanTypeBut];
        self.fuKuanFenqi = [self QRbutWithFrame:CGRectMake(240, 400, 90, 60) andtitle:@"分期" groupId:@"5"];
        [self addSubview:self.fuKuanFenqi];
        if ([userExtendM.payType isEqualToString:@"fullpay"]) {
            [self.fuKuanTypeBut setChecked:YES];
        }else if ([userExtendM.payType isEqualToString:@"partpay"]){
            [self.fuKuanFenqi setChecked:YES];
        }
        
        
        self.yongtuBut = [self QRbutWithFrame:CGRectMake(150, 460, 110, 60) andtitle:@"新手练车" groupId:@"6"];
        [self addSubview:self.yongtuBut];
        self.yongtujiaBut = [self QRbutWithFrame:CGRectMake(260, 460, 110, 60) andtitle:@"家用代步" groupId:@"6"];
        [self addSubview:self.yongtujiaBut];
        self.yongtubiaoBut = [self QRbutWithFrame:CGRectMake(370, 460, 110, 60) andtitle:@"占标车" groupId:@"6"];
        [self addSubview:self.yongtubiaoBut];
        self.yongtubuBut = [self QRbutWithFrame:CGRectMake(480, 460, 110, 60) andtitle:@"代步" groupId:@"6"];
        [self addSubview:self.yongtubuBut];
        
        
        self.haveCarBut = [self QRbutWithFrame:CGRectMake(150, 520, 90, 60) andtitle:@"有" groupId:@"7"];
        [self addSubview:self.haveCarBut];
        self.haveNocarBut = [self QRbutWithFrame:CGRectMake(240, 520, 90, 60) andtitle:@"无" groupId:@"7"];
        [self addSubview:self.haveNocarBut];
        if ([userExtendM.isHaveCar isEqualToString:@"1"]) {
            [self.haveCarBut setChecked:YES];
        }else if ([userExtendM.isHaveCar isEqualToString:@"0"]){
            [self.haveNocarBut setChecked:YES];
        }
        
        self.maicheBut = [self QRbutWithFrame:CGRectMake(150, 580, 90, 60) andtitle:@"是" groupId:@"8"];
        [self addSubview:self.maicheBut];
        self.maicheNOBut = [self QRbutWithFrame:CGRectMake(240, 580, 90, 60) andtitle:@"否" groupId:@"8"];
        [self addSubview:self.maicheNOBut];
        if ([userExtendM.isSellCar isEqualToString:@"1"]) {
            [self.maicheBut setChecked:YES];
        }else if ([userExtendM.isSellCar isEqualToString:@"0"]){
            [self.maicheNOBut setChecked:YES];
        }
    }
    return self;
}

- (void)chooseGuohuCity:(UIButton *)button
{
    CityPickViewController *cityPick = [[CityPickViewController alloc] init];
    [cityPick setDelegate:self];
    popoVC = [[UIPopoverController alloc] initWithContentViewController:cityPick];
    popoVC.popoverContentSize = CGSizeMake(320, 260);
    [popoVC presentPopoverFromRect:button.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


#pragma mark - delegate
- (void)cityPickView:(CityPickViewController *)cityPickVC state:(NSString *)state city:(NSString *)city
{
    [guohuCityBut setTitle:[NSString stringWithFormat:@"%@ %@",state,city] forState:UIControlStateNormal];
}


- (void)chooseZhibiaoDate:(UIButton *)button
{
    DatePickViewController *datePick = [[DatePickViewController alloc] init];
    [datePick setDelegate:self];
    popoVC = [[UIPopoverController alloc] initWithContentViewController:datePick];
    popoVC.popoverContentSize = CGSizeMake(320, 210);
    [popoVC presentPopoverFromRect:button.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)datePickerVC:(DatePickViewController *)datePickVC dateStr:(NSString *)datestr
{
    [zhibiaoDateBut setTitle:datestr forState:UIControlStateNormal];
}

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    if ([groupId isEqualToString:@"3"]) {
        if ([radio.titleLabel.text isEqualToString:@"有"]) {
            [zhibiaoDateBut setHidden:NO];
        }else {
            [zhibiaoDateBut setHidden:YES];
        }
    }else if ([groupId isEqualToString:@"4"]){
        if ([radio.titleLabel.text isEqualToString:@"外市"]) {
            [guohuCityBut setHidden:NO];
        }else{
            [guohuCityBut setHidden:YES];
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



@end
