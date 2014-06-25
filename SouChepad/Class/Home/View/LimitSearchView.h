//
//  LimitSearchView.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-15.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCarViewController.h"
@class LimitSearchView;

@protocol LimitSearchViewDelegate <NSObject>

- (void)limitSearch:(LimitSearchView*)limitSearchView withDic:(NSDictionary*)searchDic;

@end

@interface LimitSearchView : UIToolbar
@property (nonatomic, weak) SearchCarViewController *secrVC;
@property (nonatomic, strong) UIButton *searchBut;
@property (nonatomic, weak) id<LimitSearchViewDelegate>limitDelegate;
@end
