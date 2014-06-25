//
//  YushuanViewController.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-18.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YushuanViewController;

@protocol YushuanViewControllerDelegate <NSObject>

- (void)yuShuanViewController:(YushuanViewController *)yushuanVC selectCode:(NSString *)selectCode selectStr:(NSString *)selectStr;

@end

@interface YushuanViewController : UIViewController

@property (nonatomic, weak) id<YushuanViewControllerDelegate> delegate;
@end
