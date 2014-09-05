//
//  MyCarsViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MyCarsViewController.h"
#import "InfoMainController.h"
#import "ProgressHUD.h"

@interface MyCarsViewController () <UIWebViewDelegate>

@end

@implementation MyCarsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIWebView *carWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [carWeb setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:carWeb];
    [carWeb setScalesPageToFit:YES];
    [carWeb setDelegate:self];
//    @"http://192.168.2.63/soucheweb/pages/sellipad/sale-revisit-report.html"
    NSString *url = [NSString stringWithFormat:@"http://%@/pages/sellipad/sale-revisit-report.html",[UserDefaults objectForKey:@"httpServerIP"]];
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *weburl = [NSURL URLWithString:encodedString];
    [carWeb loadRequest:[NSURLRequest requestWithURL:weburl]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    DLog(@"%@",url);
    NSString *urlstring = [url absoluteString];
    
    NSArray *components = [urlstring componentsSeparatedByString:@"?"];
    for (NSString *str in components) {
        if ([str hasPrefix:@"userid="]) {
               NSString *userid = [str substringFromIndex:7];
            [[NSUserDefaults standardUserDefaults] setObject:userid forKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            InfoMainController *infoMvc = [[InfoMainController alloc] init];
            [self.navigationController pushViewController:infoMvc animated:YES];
            return NO;
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
}

@end
