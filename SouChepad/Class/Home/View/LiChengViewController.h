//
//  LiChengViewController.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-18.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LiChengViewController;

@protocol LiChengViewControllerDelegate <NSObject>

- (void)liChengViewController:(LiChengViewController *)lichengVC selectBut:(UIButton*)button selectDic:(NSDictionary *)selectDic;

@end


@interface LiChengViewController : UIViewController

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, weak) id<LiChengViewControllerDelegate> delegate;

@end
