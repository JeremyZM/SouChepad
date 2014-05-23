//
//  MainViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MyCarsViewController.h"
#import "SettingViewController.h"
#import "ToolViewController.h"
#import "SCDock.h"
#import "MyMessageController.h"
#import "MessageVC.h"
#import "MasterTableViewController.h"
#import "DetailViewController.h"


@interface MainViewController () <SCDockDelegate>
{
    UIView *_contentView;  // 当前view
    UIView *_blindView;    // 蒙板
}
@property (nonatomic, strong) SCDock *dock;
@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    // 1.添加dock栏
    [self addDockView];
    
    // 2.添加所有子控制器
    [self addAllChildViewControllers];
}

#pragma mark - 添加dock栏
- (void)addDockView
{
    self.dock = [[SCDock alloc] initWithFrame:CGRectMake(0, 0, KDockW, self.view.bounds.size.height)];
    [self.dock setBackgroundColor:[UIColor orangeColor]];
    [self.dock setDelegate:self];
    [self.view addSubview:self.dock];
    [self.dock setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDock:) name:KShowDockNotification object:nil];

}

#pragma mark - 添加所有子控制器
- (void)addAllChildViewControllers
{
    // 2.添加内容view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(0, 0, w, h);
    [self.view addSubview:_contentView];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeShowDock:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipe setNumberOfTouchesRequired:2];
    [_contentView addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer *hideShowSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHideDock:)];
    [hideShowSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [hideShowSwipe setNumberOfTouchesRequired:2];
    [_contentView addGestureRecognizer:hideShowSwipe];
    
    // 我的客户
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self addChildViewController:homeNav];

    // 添加主页view
    [_contentView addSubview:homeNav.view];
    
    
    // 我的消息
//    MyMessageController *messageVC = [[MyMessageController alloc] init];
//    [self addChildViewController:messageVC];
//    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageVC];
    
    
    UISplitViewController *messageNav = [[UISplitViewController alloc] init];
    MasterTableViewController *masterCtrl = [[MasterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    DetailViewController *detailCtrl = [[DetailViewController alloc] init];
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:masterCtrl];
    UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detailCtrl];
    [messageNav setViewControllers:@[masterNav,detailNav]];
    [self addChildViewController:messageNav];
    
    // 我的车辆
    MyCarsViewController *myCarsVC = [[MyCarsViewController alloc] init];
    UINavigationController *myCarsNav = [[UINavigationController alloc] initWithRootViewController:myCarsVC];
    [self addChildViewController:myCarsNav];
    
    
    // 工具
    ToolViewController *toolVC = [[ToolViewController alloc] init];
    UINavigationController *toolNav = [[UINavigationController alloc] initWithRootViewController:toolVC];
    [self addChildViewController:toolNav];
    
    // 设置
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:settingVC];
    [self addChildViewController:settingNav];

    
}

#pragma mark - 显示dock栏
- (void)showDock:(UIButton*)button
{
    if (_contentView.frame.origin.x==0) {
        //
        [self swipeShowDock:nil];
    }else if (_contentView.frame.origin.x == KDockW){
        [self swipeHideDock:nil];
    }


}


#pragma mark - 显示dock
- (void)swipeShowDock:(UISwipeGestureRecognizer*)swipe
{
    if (_blindView==nil) {
        _blindView = [[UIView alloc] initWithFrame:self.view.bounds];
        [_blindView setBackgroundColor:[UIColor blackColor]];
        [_blindView setAlpha:0.3];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDock:)];
        tapRecognizer.cancelsTouchesInView = NO;
        [_blindView addGestureRecognizer:tapRecognizer];
        
    }
    
    if (_contentView.frame.origin.x==0) {
        [_contentView addSubview:_blindView];
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = _contentView.frame;
            frame.origin.x +=KDockW;
            [_contentView setFrame:frame];
        } completion:^(BOOL finished) {

        }];
    }
}

#pragma mark 隐藏dock
- (void)swipeHideDock:(UISwipeGestureRecognizer*)swipe
{
    if (_blindView==nil) {
        _blindView = [[UIView alloc] initWithFrame:self.view.bounds];
        [_blindView setBackgroundColor:[UIColor blackColor]];
        [_blindView setAlpha:0.3];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDock:)];
        tapRecognizer.cancelsTouchesInView = NO;
        [_blindView addGestureRecognizer:tapRecognizer];
        
    }
    if (_contentView.frame.origin.x == KDockW){
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = _contentView.frame;
            frame.origin.x -=KDockW;
            [_contentView setFrame:frame];
        } completion:^(BOOL finished) {
            [_blindView removeFromSuperview];
        }];
    }


}



#pragma mark - dock栏代理方法
- (void)SCDock:(SCDock *)dock tabChangeFrom:(NSInteger)from to:(NSInteger)to
{
    // 1.先移除旧的
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    // 2.添加新的
    UIViewController *new = self.childViewControllers[to];
    
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    new.view.frame = _contentView.bounds;
    [_contentView addSubview:new.view];
    
    [self showDock:nil];

}


#pragma mark - 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KShowDockNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
