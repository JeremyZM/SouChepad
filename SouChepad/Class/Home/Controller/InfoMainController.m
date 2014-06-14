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


typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

#define KInfoDockW 100
@interface InfoMainController () <InfoDockDelegate,IntentionCarsControllerDelegat,TTCounterLabelDelegate>
{
    UIView *_contentView;
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
    
    
    
    UIButton *beginBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, userInfoDock.bounds.size.height-200, 100, 100)];
    [beginBtn setTitle:@"开始接待" forState:UIControlStateNormal];

    [beginBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [beginBtn setBackgroundColor:[UIColor redColor]];
    
    [beginBtn addTarget:self action:@selector(startStopTapped:) forControlEvents:UIControlEventTouchUpInside];
    [userInfoDock addSubview:beginBtn];
    
    self.counterLabel = [[TTCounterLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(beginBtn.frame)+10,KInfoDockW, 30)];
    [userInfoDock addSubview:self.counterLabel];
    [self.counterLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    
    self.counterLabel.textColor = [UIColor redColor];
    [self.counterLabel updateApperance];


    // 2.添加内容view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - KInfoDockW;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(KInfoDockW, 0, w, h);
    [self.view addSubview:_contentView];
}

- (void)startStopTapped:(UIButton*)sender {
    if (self.counterLabel.isRunning) {
        [self.counterLabel reset];
        [sender setTitle:@"开始接待" forState:UIControlStateNormal];
        [self updateUIForState:kTTCounterStopped];
    } else {
        [self.counterLabel start];
        [sender setTitle:@"结束接待" forState:UIControlStateNormal];
        [self updateUIForState:kTTCounterRunning];
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
    customPIM.isNew = self.isNew;
    customPIM.userInfoM = self.userInfoM;
    [self addChildViewController:customPIM];
    
    IntentionCarsController *intentionCarsVC = [[IntentionCarsController alloc] init];
    [intentionCarsVC setDeleget:self];
    intentionCarsVC.isNew = self.isNew;
    intentionCarsVC.userReserM = self.userInfoM;
    [self addChildViewController:intentionCarsVC];
    
    CommListController *commListVC = [[CommListController alloc] init];
    commListVC.isNew = self.isNew;
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
