//
//  PopoTableViewController.h
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-16.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopoTableViewController;

@protocol PopoTableViewDelegate <NSObject>
@optional
- (void)PopoTableViewController:(PopoTableViewController*)popoTableVC seleckChanged:(NSString *)seleckStr andseleckRow:(NSInteger)row andselectBtn:(UIButton*)selecBtn;

@end

@interface PopoTableViewController : UITableViewController

@property (nonatomic, strong) UIButton *sortWayBtn;
@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic,weak) id <PopoTableViewDelegate> popoTabelDelegate;
@end
