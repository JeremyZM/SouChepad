//
//  SCWebViewController.m
//  TestUIWebView
//
//  Created by zt on 14-8-7.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "MessageDetailView.h"
#import "MyMessage.h"

@interface MessageDetailView ()<UIWebViewDelegate>{
    UIWebView *webView;
    NSString *messageArguments;
}

@end

@implementation MessageDetailView

- (id)initWithMessage:(id)message frame:(CGRect)frame{
    self = [super init];
    if (self) {
        [self setMessageDetail:message];
        
        webView = [[UIWebView alloc] initWithFrame:frame];
        webView.delegate = self;
        webView.backgroundColor = [UIColor whiteColor];
        [self addSubview:webView];
        
        NSString * path = [[NSBundle mainBundle] bundlePath];
        NSURL * baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlFile = [[NSBundle mainBundle] pathForResource:@"MessageDetail" ofType:@"html"];
        NSString * htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:(NSUTF8StringEncoding) error:nil];
        [webView loadHTMLString:htmlString baseURL:baseURL];
    }
    return self;
}


- (void)setMessageDetail:(id)message{
    MyMessage *msg = (MyMessage*)message;
    [self loadMessageTitle:msg.title subTitle:msg.dateCreate content:msg.comment imageUrl:msg.image];
}

// 组装js中changeMessage所需要的参数
- (void)loadMessageTitle:(NSString*)title subTitle:(NSString*)subtitle content:(NSString*)content imageUrl:(NSString*)imgUrl{
//    content = [NSString stringWithCString:[content UTF8String] encoding:NSUTF8StringEncoding];
    content = [content stringByReplacingOccurrencesOfString:@"\x0a" withString:@"</br>"];//换行
    content = [content stringByReplacingOccurrencesOfString:@"\x0d" withString:@""];//回车
    messageArguments = [NSString stringWithFormat:@"'%@','%@','%@', '%@'", title, subtitle, content, imgUrl];

    [self showMessage];
}

// show message
- (void)showMessage{
    NSString *jsFunction = [NSString stringWithFormat:@"changeMessage(%@)", messageArguments];
    [webView stringByEvaluatingJavaScriptFromString:jsFunction];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)_webView{
    [self showMessage];
}
@end
