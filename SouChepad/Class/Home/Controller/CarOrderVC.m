//
//  CarOrderVC.m
//  Athena
//
//  Created by zt on 14-10-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarOrderVC.h"
#import "QRadioButton.h"
#import "CarBaseModel.h"
#import "UIImageView+WebCache.h"
#import "CarOrderVO.h"

@interface CarOrderVC ()<QRadioButtonDelegate,UITextFieldDelegate>{
    __weak IBOutlet UITextField *tfPrice;//价格文本框
    __weak IBOutlet UITextField *tfName;//姓名文本框
    __weak IBOutlet QRadioButton *btPayFull;// 全款支付按钮
    __weak IBOutlet QRadioButton *btPayPart;// 分期支付按钮
    __weak IBOutlet UITextField *tfPhone;//电话文本框
    __weak IBOutlet QRadioButton *btIDCar;// 身份证类型按钮
    __weak IBOutlet QRadioButton *btPassport;// 护照类型按钮
    __weak IBOutlet UITextField *tfIDCard;//身份证文本框
    __weak IBOutlet UIButton *btConfirm;//确认无误
    __weak IBOutlet UIButton *btSubmit;//提交按钮
    __weak IBOutlet UILabel *lbManager;//负责人label
    
    __weak IBOutlet UIButton *dismissButton;
    // 车辆基本信息
    __weak IBOutlet UIView *carIamgeErea;
    __weak IBOutlet UIImageView *carIamgeView;
    __weak IBOutlet UILabel *carBrand;
    __weak IBOutlet UILabel *carPrice;
    
    CarOrderVO *orderVO;
}
@property (nonatomic,strong) CarBaseModel *carModel;
@end

@implementation CarOrderVC

#pragma mark - public methods
- (id)initWithCarModel:(CarBaseModel*)carModel{
    self = [super init];
    if (self) {
        self.carModel = carModel;
    }
    return self;
}

#pragma mark - private methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self showCarBaseInfo];
    [self addRadioButtons];
}

// ui设置
- (void)showCarBaseInfo{
    UIColor *c = [UIColor hexStringToColor:KBaseColo];
    // 关闭按钮
    [dismissButton setBackgroundColor:c];
    [dismissButton setImage:[UIImage imageNamed:@"tubiao_37"] forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 提交按钮
    btSubmit.backgroundColor = c;
    viewroundCorner(btSubmit, c, 1, 3);
    [btSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //品牌图标
    carBrand.text = self.carModel.carName;
    [carIamgeView setImageWithURL:[NSURL URLWithString:self.carModel.image] placeholderImage:[UIImage imageNamed:@"loading_03"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    carPrice.text = FormatStr(@"%@万",self.carModel.souchePrice);
    
    lbManager.text = [UserDefaults objectForKey:KSellName];
    
    // 订单详情
    [HttpManager requestOrderDetailWithOrderid:self.carModel.orderid success:^(id obj) {
        orderVO = obj;
        [self showOrder];
    } fail:^(id obj) {
        
    }];
}

// 显示订单详情
- (void)showOrder{
    NSString *price = FormatStr(@"%.2lf", strNoNull(orderVO.realPayAmount).floatValue/10000.0);
    tfPrice.text = FormatStr(@"%@", price);
    tfIDCard.text = FormatStr(@"%@", strNoNull(orderVO.identityCard));
    tfName.text = FormatStr(@"%@", strNoNull(orderVO.buyerName));
    tfPhone.text = FormatStr(@"%@", strNoNull(orderVO.buyerPhone));
    
    //支付类型
    if (FormatStr(@"%@", strNoNull(orderVO.isStaging)).length>0) {
        btPayPart.checked = YES;
    }else{
        btPayFull.checked = YES;
    }

    //证件类型
    if ([FormatStr(@"%@", strNoNull(orderVO.card_type)) isEqualToString:@"0"]) {
        btIDCar.checked =  YES;
    }
    if ([FormatStr(@"%@", strNoNull(orderVO.card_type)) isEqualToString:@"1"]) {
        btPassport.checked = YES;
    }
    // 销售id
}

// 单选按钮
- (void)addRadioButtons{
    [btPayFull setBackgroundColor:[UIColor clearColor]];
    //支付类型
    btPayFull.delegate = self;
    btPayFull.checked = YES;
    [btPayFull setGroupId:@"payType"];
    btPayPart.delegate = self;
    [btPayPart setGroupId:@"payType"];
    
    // 证件类型
    btIDCar.delegate = self;
    btIDCar.checked= NO;
    [btIDCar setGroupId:@"idType"];
    btPassport.delegate = self;
    [btPassport setGroupId:@"idType"];
}

// 返回
- (IBAction)dismissVC:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)cardTypeButtonAction:(id)sender {
    tfIDCard.enabled = YES;
}


// 提交订单
- (IBAction)submitOrder:(id)sender {
    //    成交价
    if (tfPrice.text.length <= 0 || [tfPrice.text doubleValue] < 0) {
        [ProgressHUD showError:@"请输入正确的成交价"];
        return;
    }
    //    姓名
    if (tfName.text.length == 0) {
        [ProgressHUD showError:@"请输入客户姓名"];
        return;
    }
    //证件号码
    if (btIDCar.selected == YES) {
        if (tfIDCard.text.length != 18) {
            [ProgressHUD showError:@"身份证号码必须为18位"];
            return;
        }
    }

    NSDictionary *dic = @{@"orderid":orderVO.orderSn,//订单号
                          @"isStaging":btPayPart.selected == YES ? @"1" : @"0",//分期
                          @"realPayAmount":tfPrice.text,//成交价
                          @"guestName":tfName.text,
                          @"guestPhone":tfPhone.text,
                          @"credNumber":tfIDCard.text,//证件号码
                          @"cardType":btPassport.selected == YES ? @"1" : @"0"//证件类型
                          };
    [HttpManager requestConfirmOrder:dic success:^(id obj) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            // 告诉观察者订单完成
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderDidComplete)]) {
                [self.delegate orderDidComplete];
            }
        }];
    } fail:^(id obj) {}];
}
@end
