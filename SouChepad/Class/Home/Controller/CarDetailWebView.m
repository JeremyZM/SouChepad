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
    
    UIButton *infoCQI = [[UIButton alloc] initWithFrame:CGRectMake(700, 40, 82, 40)];
    [infoCQI setImage:[UIImage imageNamed:@"zhijian_64"] forState:UIControlStateNormal];
    [infoCQI addTarget:self action:@selector(showinfoCQI) forControlEvents:UIControlEventTouchUpInside];
    [infoCQI setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [infoCQI setTitle:@"报告" forState:UIControlStateNormal];
    [infoCQI setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headBar addSubview:infoCQI];
    
    // 看车
    UIButton *lookCarBut = [[UIButton alloc] initWithFrame:CGRectMake(800, 40, 82, 40)];
    [lookCarBut setTitle:@"看车" forState:UIControlStateNormal];
    [lookCarBut setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [lookCarBut setImage:[UIImage imageNamed:@"anniu_43"] forState:UIControlStateNormal];
    [lookCarBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lookCarBut addTarget:self action:@selector(addLookCarRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:lookCarBut];
    
    // 试驾
    UIButton *driveCarBut = [[UIButton alloc] initWithFrame:CGRectMake(900, 40, 82, 40)];
     [driveCarBut setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [driveCarBut setImage:[UIImage imageNamed:@"anniu_45"] forState:UIControlStateNormal];
    [driveCarBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [driveCarBut setTitle:@"试驾" forState:UIControlStateNormal];
    [driveCarBut addTarget:self action:@selector(addDriveCarRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.headBar addSubview:driveCarBut];
    
    
    UIWebView *carWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    [carWeb setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:carWeb];
    [carWeb setScalesPageToFit:YES];
    [carWeb setDelegate:self];
    NSString *url = url = [NSString stringWithFormat:@"http://souche.com/pages/choosecarpage/choose-car-detail.html?carId=%@&isapp=1",self.carID];
    
    if (self.carStatusType == CarStatusTypePresell) {
        url = [NSString stringWithFormat:@"http://souche.com/pages/yushou/yushoudetail.html?carId=%@&isapp=1",self.carID];
        
        [lookCarBut setHidden:YES];
        [driveCarBut setHidden:YES];
        [infoCQI setHidden:YES];
    }else if(self.carStatusType == CarStatusTypeSellout){

        [lookCarBut setHidden:YES];
        [driveCarBut setHidden:YES];
        [infoCQI setFrame:CGRectMake(900, 40, 82, 40)];
    }else if (self.carStatusType == CarStatusTypeSelling){
        
    }
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *weburl = [NSURL URLWithString:encodedString];
    [carWeb loadRequest:[NSURLRequest requestWithURL:weburl]];
}

// 看车
- (void)addLookCarRecord:(UIButton*)but
{
    LookCarRecordController *lookCarVC = [[LookCarRecordController alloc] init];
    [lookCarVC setCarID:self.carID];
    UINavigationController *lookNavVC = [[UINavigationController alloc] initWithRootViewController:lookCarVC];
    [lookNavVC setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:lookNavVC animated:YES completion:^{
        
    }];
}

// 试驾
- (void)addDriveCarRecord:(UIButton*)but
{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    [HttpManager lastUserDriveCarByData:@{@"user":userID,@"carId":self.carID} Success:^(id obj) {
        UINavigationController *driveNavVC;
        DriveCarLastData *driveDataM = obj;
        if ([driveDataM.isDriveCar isEqualToString:@"0"]) {
            DriveCarRecordController *driveCarVC = [[DriveCarRecordController alloc] init];
            driveNavVC  = [[UINavigationController alloc] initWithRootViewController:driveCarVC];
            [driveCarVC setDelegate:self];
            [driveCarVC setCarId:self.carID];
            [driveCarVC setDriveCarDataM:driveDataM];
        }else if ([driveDataM.isDriveCar isEqualToString:@"1"]){
            OverDriveCarController *overDriveCarVC = [[OverDriveCarController alloc] init];
            driveNavVC = [[UINavigationController alloc] initWithRootViewController:overDriveCarVC];
            [overDriveCarVC setCarId:self.carID];
            [overDriveCarVC setDriveCarDataM:driveDataM];
        }
        
        [driveNavVC setModalPresentationStyle:UIModalPresentationFormSheet];
        if (driveNavVC) {
            [self presentViewController:driveNavVC animated:YES completion:^{
                [ProgressHUD dismiss];
            }];
        }
        
    } fail:^(id obj) {
        
    }];
}

- (void)driveCarBeginRecordController:(DriveCarRecordController *)driveCarController
{
    [self addDriveCarRecord:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
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
