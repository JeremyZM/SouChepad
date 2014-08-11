//
//  CarCQIInfoController.m
//  Athena
//
//  Created by 张艳东 on 14-7-4.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarCQIInfoController.h"
#import "ProgressHUD.h"

@interface CarCQIInfoController () <UIWebViewDelegate>

@end

@implementation CarCQIInfoController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(dismisSelf)];
    
    UIWebView *infoCQIView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [infoCQIView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:infoCQIView];
    [infoCQIView setDelegate:self];
    
    NSString *url = [NSString stringWithFormat:@"http://manage.souche.com/pages/sellipad/preview-report.html?carId=%@&source=sellipad&s=0000s0yP9HIpTyEPnBglffYM2R2:18a1kacdt",self.carID];
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *weburl = [NSURL URLWithString:encodedString];
    [infoCQIView loadRequest:[NSURLRequest requestWithURL:weburl]];
}

- (void)dismisSelf
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

        [ProgressHUD dismiss];
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
