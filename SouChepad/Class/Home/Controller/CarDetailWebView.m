//
//  CarDetailWebView.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarDetailWebView.h"
#import "ProgressHUD.h"

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
    
    UIButton *infoCQI = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-80, 30, 50, 40)];
    [infoCQI addTarget:self action:@selector(showinfoCQI) forControlEvents:UIControlEventTouchUpInside];
    [infoCQI setBackgroundColor:[UIColor whiteColor]];
    [self.headBar addSubview:infoCQI];
    
    
    UIWebView *carWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width+80, self.view.bounds.size.height-100)];
    [carWeb setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:carWeb];
    [carWeb setScalesPageToFit:YES];
    [carWeb setDelegate:self];

    NSString *url = [NSString stringWithFormat:@"http://souche.com/pages/choosecarpage/choose-car-detail.html?carId=%@&isapp=1",self.carID];
    [carWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)showinfoCQI
{
    UIWebView *infoCQIView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-900, 0, 900, self.view.bounds.size.height)];
    [infoCQIView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:infoCQIView];
    [infoCQIView setDelegate:self];
    
    NSString *url = [NSString stringWithFormat:@"http://manage.souche.com/pages/car/preview-report.html?carId=prg9I4G"];
    [infoCQIView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
}

- (void)dismisSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
}

@end
