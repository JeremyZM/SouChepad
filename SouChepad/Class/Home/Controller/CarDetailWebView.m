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
#import "DriveCarRecordController.h"
#import "HttpManager.h"
#import "DriveCarLastData.h"
#import "OverDriveCarController.h"
#import "BeginBut.h"
#import "CarOrderVC.h"

@interface CarDetailWebView () <UIWebViewDelegate,DriveCarBeginDelegate>

@end

@implementation CarDetailWebView


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *disBut = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    [disBut setImage:[UIImage imageNamed:@"tubiao_37"] forState:UIControlStateNormal];
    [disBut addTarget:self action:@selector(dismisSelfDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:disBut];
    
    UIButton *infoCQI = [[UIButton alloc] initWithFrame:CGRectMake(924, 40, 82, 40)];
    [infoCQI setImage:[UIImage imageNamed:@"zhijian_64"] forState:UIControlStateNormal];
    [infoCQI addTarget:self action:@selector(showinfoCQI) forControlEvents:UIControlEventTouchUpInside];
    [infoCQI setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [infoCQI setTitle:@"报告" forState:UIControlStateNormal];
    [infoCQI setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headBar addSubview:infoCQI];
    
    UIWebView *carWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    [carWeb setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:carWeb];
    [carWeb setScalesPageToFit:YES];
    [carWeb setDelegate:self];
    NSString *url = url = [NSString stringWithFormat:@"http://souche.com/pages/choosecarpage/choose-car-detail.html?carId=%@&isapp=1",self.carID];
    
    if (self.carStatusType == CarStatusTypePresell) {
        url = [NSString stringWithFormat:@"http://souche.com/pages/yushou/yushoudetail.html?carId=%@&isapp=1",self.carID];
        [infoCQI setHidden:YES];
    }else if(self.carStatusType == CarStatusTypeSellout){
        [infoCQI setFrame:CGRectMake(900, 40, 82, 40)];
    }else if (self.carStatusType == CarStatusTypeSelling){
        
    }
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *weburl = [NSURL URLWithString:encodedString];
    [carWeb loadRequest:[NSURLRequest requestWithURL:weburl]];
}


- (void)driveCarBeginRecordController:(DriveCarRecordController *)driveCarController
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
}


- (void)showinfoCQI
{
    [MobClick event:KcarReportInfo attributes:@{@"sellName":KUserName}];
    CarCQIInfoController *carCQIVC = [[CarCQIInfoController alloc] init];
    carCQIVC.carID = self.carID;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:carCQIVC];
    [navVC setModalPresentationStyle:UIModalPresentationPageSheet];
    [self presentViewController:navVC animated:YES completion:^{
        
    }];
    
}

- (void)dismisSelfDetail
{
    [self dismissViewControllerAnimated:YES completion:^{
        [ProgressHUD dismiss];
    }];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    DLog(@"%@",[url absoluteString]);
    return YES;
    
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
