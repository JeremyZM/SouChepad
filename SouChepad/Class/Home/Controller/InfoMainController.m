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

#define KInfoDockW 100
@interface InfoMainController () <InfoDockDelegate>
{
    UIView *_contentView;
}
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
    [userInfoDock setBackgroundColor:[UIColor blueColor]];
    [userInfoDock setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:userInfoDock];
    
    // 2.添加内容view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - KInfoDockW;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(KInfoDockW, 0, w, h);
    [self.view addSubview:_contentView];
}

- (void)addAllInfoChildViewControllers
{
    CustomPIMController *customPIM = [[CustomPIMController alloc] init];
    customPIM.isNew = self.isNew;
    customPIM.userInfoM = self.userInfoM;
    [self addChildViewController:customPIM];
    
    IntentionCarsController *intentionCarsVC = [[IntentionCarsController alloc] init];
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
