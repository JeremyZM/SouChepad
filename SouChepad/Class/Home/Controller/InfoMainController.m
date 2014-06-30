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
#import "CarDetailWebView.h"
#import "SCDockItem.h"
#import "TTCounterLabel.h"
#import "HttpManager.h"
#import "EndReceiveViewController.h"
#import "BeginBut.h"


typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

#define KInfoDockW 100
@interface InfoMainController () <InfoDockDelegate,IntentionCarsControllerDelegat,TTCounterLabelDelegate,UIAlertViewDelegate>
{
    UIView *_contentView;
    BeginBut *beginBtn;
    NSDate *beginDate;
    NSDate *endDate;
}
@property (strong, nonatomic) TTCounterLabel *counterLabel;
@end

@implementation InfoMainController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    
    
    beginBtn =[[BeginBut alloc] initWithFrame:CGRectMake(0, userInfoDock.bounds.size.height-200, 100, 100)];
    [beginBtn setImage:[UIImage imageNamed:@"start_33"] forState:UIControlStateNormal];
    [beginBtn setImage:[UIImage imageNamed:@"anniu_31"] forState:UIControlStateSelected];
    [beginBtn setTitle:@"开始接待" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor hexStringToColor:KBaseColo] forState:UIControlStateNormal];
    [beginBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [beginBtn addTarget:self action:@selector(startStopTapped:) forControlEvents:UIControlEventTouchUpInside];
    [userInfoDock addSubview:beginBtn];
    
    
//    self.counterLabel = [[TTCounterLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(beginBtn.frame)+10,KInfoDockW, 30)];
//    [userInfoDock addSubview:self.counterLabel];
//    [self.counterLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
//    
//    self.counterLabel.textColor = [UIColor redColor];
//    [self.counterLabel updateApperance];


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

//            EndReceiveViewController *endReceiveVC = [[EndReceiveViewController alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:endReceiveVC];
//            [nav setModalPresentationStyle:UIModalPresentationFormSheet];
//            [self presentViewController:nav animated:YES completion:^{
//                [self.counterLabel stop];
//                [self updateUIForState:kTTCounterStopped];
//            }];
            UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"确认结束接待" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [endAlert setTag:255];
            [endAlert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认开始接待" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert setTag:256];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==256) {
        if (buttonIndex==1) {
            if (self.userInfoM.reservationId==nil||[self.userInfoM.reservationId isEqualToString:@"暂无"]) {
                [HttpManager requestUpdateBeginReservationByUser:@{@"user":self.userInfoM.crmUserId,@"userName":KUserName} Success:^(id obj) {
                    [beginBtn setSelected:YES];
                    beginDate = [NSDate date];
                    [self.counterLabel start];
                    [beginBtn setTitle:@"结束接待" forState:UIControlStateNormal];
                    [self updateUIForState:kTTCounterRunning];
                } fail:^(id obj) {
                    
                }];
                
            }else {
                [HttpManager requestUpdateBeginReservationById:@{@"reservationId":self.userInfoM.reservationId,@"userName":KUserName} Success:^(id obj) {
                    beginDate = [NSDate date];
                    [self.counterLabel start];
                    [beginBtn setSelected:YES];
                    [beginBtn setTitle:@"结束接待" forState:UIControlStateNormal];
                    [self updateUIForState:kTTCounterRunning];
                    
                } fail:^(id obj) {
                    
                }];
            }
        }

    }else if (alertView.tag==255){
        endDate = [NSDate date];
        // NSDateFormatter 专门用来转换日期格式的 类
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置格式
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        // NSDateFormatter转换为NSString
        NSString *beginDateStr = [formatter stringFromDate:beginDate];
        NSString *endDateStr = [formatter stringFromDate:endDate];
        
        
        [HttpManager requestUserOutStore:@{@"user":self.userInfoM.crmUserId,@"name":self.userInfoM.user,@"userName":KUserName,@"phone":self.userInfoM.phone,@"receptionBeginTime":beginDateStr,@"receptionEndTime":endDateStr,@"store":@"A",@"level":self.userInfoM.userLevel,@"comment":@"",@"remark":@""} Success:^(id obj) {
            NSDictionary *dicobj = [NSDictionary dictionaryWithDictionary:obj];
            if ([dicobj objectForKey:@"succeedMessage"]) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } fail:^(id obj) {
            
        }];
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
    [intentionCarsVC setDeleget:self];
    intentionCarsVC.userReserM = self.userInfoM;
    [self addChildViewController:intentionCarsVC];
    
    CommListController *commListVC = [[CommListController alloc] init];
    commListVC.userResM = self.userInfoM;
    [self addChildViewController:commListVC];

    
    SearchCarViewController *searchCarVC = [[SearchCarViewController alloc] init];
    [self addChildViewController:searchCarVC];
    
    [self InfoDock:nil tabChangeFrom:1 to:1];
}

- (void)InfoDock:(InfoDock *)dock tabChangeFrom:(NSInteger)from to:(NSInteger)to
{
    if (to ==0) {
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
