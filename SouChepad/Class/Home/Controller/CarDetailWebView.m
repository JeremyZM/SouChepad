//
//  CarDetailWebView.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarDetailWebView.h"
#import "ProgressHUD.h"
#import "CarCQIInfoController.h"
#import "LookCarRecordController.h"

@interface CarDetailWebView () <UIWebViewDelegate>

@end

@implementation CarDetailWebView


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *disBut = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    [disBut setImage:[UIImage imageNamed:@"tubiao_37"] forState:UIControlStateNormal];
    [disBut addTarget:self action:@selector(dismisSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:disBut];
    
    UIButton *infoCQI = [[UIButton alloc] initWithFrame:CGRectMake(850, 40, 150, 40)];
    [infoCQI addTarget:self action:@selector(showinfoCQI) forControlEvents:UIControlEventTouchUpInside];
    [infoCQI setTitle:@"详细质检报告" forState:UIControlStateNormal];
    [infoCQI setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headBar addSubview:infoCQI];
    
    // 看车
    UIButton *lookCarBut = [[UIButton alloc] initWithFrame:CGRectMake(700, 40, 50, 40)];
    [lookCarBut setTitle:@"看车" forState:UIControlStateNormal];
    [lookCarBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lookCarBut addTarget:self action:@selector(addLookCarRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:lookCarBut];
    
    // 试驾
    UIButton *driveCarBut = [[UIButton alloc] initWithFrame:CGRectMake(800, 40, 50, 40)];
    [driveCarBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [driveCarBut setTitle:@"试驾" forState:UIControlStateNormal];
    [driveCarBut addTarget:self action:@selector(addDriveCarRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:driveCarBut];
    
    
    UIWebView *carWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    [carWeb setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:carWeb];
    [carWeb setScalesPageToFit:YES];
    [carWeb setDelegate:self];

    NSString *url = [NSString stringWithFormat:@"http://souche.com/pages/choosecarpage/choose-car-detail.html?carId=%@&isapp=1",self.carID];
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *weburl = [NSURL URLWithString:encodedString];
    [carWeb loadRequest:[NSURLRequest requestWithURL:weburl]];
}

// 看车
- (void)addLookCarRecord:(UIButton*)but
{
    LookCarRecordController *lookCarVC = [[LookCarRecordController alloc] init];
    UINavigationController *lookNavVC = [[UINavigationController alloc] initWithRootViewController:lookCarVC];
    [lookNavVC setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:lookNavVC animated:YES completion:^{
        
    }];
}

// 试驾
- (void)addDriveCarRecord:(UIButton*)but
{


}


- (void)showinfoCQI
{
    CarCQIInfoController *carCQIVC = [[CarCQIInfoController alloc] init];
    carCQIVC.carID = self.carID;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:carCQIVC];
    [navVC setModalPresentationStyle:UIModalPresentationPageSheet];
    [self presentViewController:navVC animated:YES completion:^{
        
    }];
    
}

- (void)dismisSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        [ProgressHUD dismiss];
        if ([_delegate respondsToSelector:@selector(dismissViewAllController:)]) {
            [_delegate dismissViewAllController:self];
        }
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [ProgressHUD show:@"努力加载中"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [ProgressHUD showSuccess:nil];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ProgressHUD showError:error.localizedRecoveryOptions[0]];
    [ProgressHUD showError:@"暂无该车辆信息"];
}

@end
