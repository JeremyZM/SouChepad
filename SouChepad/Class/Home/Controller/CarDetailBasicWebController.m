//
//  CarDetailBasicWebController.m
//  Athena
//
//  Created by 张艳东 on 14-7-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarDetailBasicWebController.h"
#import "ProgressHUD.h"
#import "CarDetailWebView.h"

@interface CarDetailBasicWebController () <UIWebViewDelegate>

@end

@implementation CarDetailBasicWebController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:KuserPathInfo attributes:@{@"sellName":KUserName}];
    UIWebView *carWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [carWeb setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:carWeb];
    [carWeb setScalesPageToFit:YES];
    [carWeb setDelegate:self];
    
    NSString *encodedString=[self.URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *weburl = [NSURL URLWithString:encodedString];
    [carWeb loadRequest:[NSURLRequest requestWithURL:weburl]];
    
}

- (void)dismisSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        [ProgressHUD dismiss];
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    DLog(@"%@",url);
    NSString *urlstring = [url absoluteString];
    
    NSArray *components = [urlstring componentsSeparatedByString:@"?"];
    for (NSString *str in components) {
        NSArray *comArray = [str componentsSeparatedByString:@"&"];
        for (NSString *carid in comArray) {
            if ([carid hasPrefix:@"carId"]) {
                CarDetailWebView *carDetailVC = [[CarDetailWebView alloc] init];
                [carDetailVC setCarID:[carid substringFromIndex:6]];
                [self presentViewController:carDetailVC animated:YES completion:^{
                    
                }];
                
                return NO;
            }
        }
    }
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
