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

- (void)yuShuanViewController:(YushuanViewController *)yushuanVC selectCode:(NSString *)selectCode selectBeginStr:(NSString *)selectBeginStr selectEndStr:(NSString *)selectEndStr;

@end

@interface YushuanViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *endArray;
@property (nonatomic, strong) UIButton *seleckBut;
/** 开始 */
@property (copy, nonatomic) NSString *beginSelect;
/** 结束 */
@property (copy, nonatomic) NSString *endSelect;

@property (nonatomic, weak) id<YushuanViewControllerDelegate> delegate;
@end
