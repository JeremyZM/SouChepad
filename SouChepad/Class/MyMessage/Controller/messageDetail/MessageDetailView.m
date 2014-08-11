//
//  SCWebViewController.m
//  TestUIWebView
//
//  Created by zt on 14-8-7.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "MessageDetailView.h"
#import "SystermMessage.h"
#import "MyMessage.h"

@interface MessageDetailView ()<UIWebViewDelegate>{
    UIWebView *webView;
    NSString *messageArguments;
}

@end

@implementation MessageDetailView

- (id)initWithMessage:(id)message frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMessageDetail:message];
        
        webView = [[UIWebView alloc] initWithFrame:self.bounds];
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
    if (message == nil) {
        [self loadMessageTitle:@"" subTitle:@"" content:@"" imageUrl:@""];
        return;
    }
    
    if ([message isKindOfClass:[SystermMessage class]]) {
        SystermMessage *msg = (SystermMessage*)message;
        if (msg) {
            [self loadMessageTitle:msg.title subTitle:msg.dateCreate content:msg.comment imageUrl:msg.image];
        }else{
            [self loadMessageTitle:@"" subTitle:@"" content:@"" imageUrl:@""];
        }
    }else{
        MyMessage *mymsg = message;
        [self loadMessageTitle:strNoNull(mymsg.title) subTitle:strNoNull(mymsg.dateCreate) content:strNoNull(mymsg.message) imageUrl:nil];
    }
}

// 组装js中changeMessage所需要的参数
- (void)loadMessageTitle:(NSString*)title subTitle:(NSString*)subtitle content:(NSString*)content imageUrl:(NSString*)imgUrl{
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
