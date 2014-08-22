//
//  InfoMainController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "InfoMainController.h"
#import "InfoDock.h"
#import "CustomPIMController.h"
#import "IntentionCarsController.h"
#import "SearchCarViewController.h"
#import "UserReservationM.h"
#import "CommListController.h"
//#import "CarDetailWebView.h"
#import "SCDockItem.h"
#import "TTCounterLabel.h"
#import "HttpManager.h"
#import "EndReceiveViewController.h"
#import "BeginBut.h"
#import "ProgressHUD.h"
#import "CarDetailBasicWebController.h"
#import "NSString+MD5.h"


typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

#define KInfoDockW 100
@interface InfoMainController () <InfoDockDelegate,IntentionCarsControllerDelegat,TTCounterLabelDelegate,UIAlertViewDelegate,EndReceiveDelegate>
{
    UIView *_contentView;
    BeginBut *beginBtn;
}
@property (strong, nonatomic) TTCounterLabel *counterLabel;
@end

@implementation InfoMainController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:self.userInfoM.crmUserId forKey:@"userID"];
    DLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]);
    
    // 1.添加dock栏
    [self addInfoDockView];
    
    // 2.添加所有子控制器
    [self addAllInfoChildViewControllers];
    
}

- (void)addInfoDockView
{
    InfoDock *userInfoDock = [[InfoDock alloc] initWithFrame:CGRectMake(0, 0, KInfoDockW, self.view.frame.size.height)];
    [userInfoDock setDelegate:self];
    [userInfoDock setBackgroundColor:[UIColor whiteColor]];
    [userInfoDock setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:userInfoDock];
    
    beginBtn =[[BeginBut alloc] initWithFrame:CGRectMake(0, userInfoDock.bounds.size.height-100, 100, 100)];
    [beginBtn setImage:[UIImage imageNamed:@"start_33"] forState:UIControlStateNormal];
    [beginBtn setImage:[UIImage imageNamed:@"anniu_31"] forState:UIControlStateSelected];
    [beginBtn setTitle:@"开始接待" forState:UIControlStateNormal];
    [beginBtn setTitle:@"结束接待" forState:UIControlStateSelected];
    [beginBtn setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [beginBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [beginBtn addTarget:self action:@selector(startStopTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [beginBtn setSelected:YES];
    [userInfoDock addSubview:beginBtn];
    
    
//    self.counterLabel = [[TTCounterLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(beginBtn.frame)+10,KInfoDockW, 30)];
     self.counterLabel = [[TTCounterLabel alloc] initWithFrame:CGRectZero];
    [userInfoDock addSubview:self.counterLabel];
//    [self.counterLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    
//    self.counterLabel.textColor = [UIColor redColor];
    [self.counterLabel updateApperance];
    if (self.inHand) {
        [beginBtn setSelected:YES];
        [self.counterLabel start];
    }


    // 2.添加内容view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - KInfoDockW;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(KInfoDockW, 0, w, h);
    [self.view addSubview:_contentView];
}

- (void)startStopTapped:(UIButton*)sender {
        if ([self.counterLabel isRunning]) {
            EndReceiveViewController *endVC = [[EndReceiveViewController alloc] init];
            [endVC setDelegate:self];
            endVC.userInfoM = self.userInfoM;
            UINavigationController *endNavVC = [[UINavigationController alloc] initWithRootViewController:endVC];
            [endNavVC setModalPresentationStyle:UIModalPresentationFormSheet];
            [self presentViewController:endNavVC animated:YES completion:^{
                
            }];

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认开始接待" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
}

- (void)endReceiveController:(EndReceiveViewController *)endReceiveVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (self.userInfoM.reservationId==nil || !self.userInfoM.reservationId) {
            [HttpManager requestUpdateBeginReservationByUser:@{@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"userName":KUserName} Success:^(id obj) {
                [beginBtn setSelected:YES];
                [self.counterLabel start];
                [self updateUIForState:kTTCounterRunning];
                [ProgressHUD showSuccess:@""];
            } fail:^(id obj) {
                
            }];
            
        }else {
            [HttpManager requestUpdateBeginReservationById:@{@"reservationId":self.userInfoM.reservationId,@"userName":KUserName} Success:^(id obj) {
                [self.counterLabel start];
                [beginBtn setSelected:YES];
                [self updateUIForState:kTTCounterRunning];
                [ProgressHUD showSuccess:@""];
            } fail:^(id obj) {
                
            }];
        }
    }

}


- (void)updateUIForState:(NSInteger)state {
    switch (state) {
        case kTTCounterRunning:

            break;
            
        case kTTCounterStopped:
            break;
            
        case kTTCounterReset:
            break;
            
        case kTTCounterEnded:

            break;
            
        default:
            break;
    }
}


#pragma mark - TTCounterLabelDelegate

- (void)countdownDidEnd {
    [self updateUIForState:kTTCounterEnded];
}



- (void)addAllInfoChildViewControllers
{
    CustomPIMController *customPIM = [[CustomPIMController alloc] init];
    customPIM.userInfoM = self.userInfoM;
    [self addChildViewController:customPIM];
    
    IntentionCarsController *intentionCarsVC = [[IntentionCarsController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:intentionCarsVC];
    [intentionCarsVC setDeleget:self];
    intentionCarsVC.userReserM = self.userInfoM;
    [self addChildViewController:navVC];
    
    CommListController *commListVC = [[CommListController alloc] init];
    commListVC.userResM = self.userInfoM;
    [self addChildViewController:commListVC];

    // 需求分析
    SearchCarViewController *searchCarVC = [[SearchCarViewController alloc] init];
    [self addChildViewController:searchCarVC];
    
    CarDetailBasicWebController *carDetailWeb = [[CarDetailBasicWebController alloc] init];
    NSString *crmid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    NSString *tokensting = [NSString stringWithFormat:@"%@!@a#Vs31",crmid];
    NSString *tokenMD5 = [tokensting md5];
    
    NSString *urlstring = [NSString stringWithFormat:@"http://data.souche.com/user/profile.do?crmid=%@&&token=%@",crmid,tokenMD5];
    [carDetailWeb setURLString:urlstring];
    [self addChildViewController:carDetailWeb];
    
    
    [self InfoDock:nil tabChangeFrom:1 to:1];
}

- (void)InfoDock:(InfoDock *)dock tabChangeFrom:(NSInteger)from to:(NSInteger)to
{
    if (to ==0) {
        CustomPIMController *old = self.childViewControllers[to];
        [old viewDidAppear:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        from -= 1;
        to -= 1;
        // 1.先移除旧的
        UIViewController *old = self.childViewControllers[from];
        [old.view removeFromSuperview];
        
        // 2.添加新的
        UIViewController *new = self.childViewControllers[to];
        new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        new.view.frame = _contentView.bounds;
        [_contentView addSubview:new.view];
    }

}

- (void)intentionCarsController:(IntentionCarsController *)controller carID:(NSString *)carid
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
