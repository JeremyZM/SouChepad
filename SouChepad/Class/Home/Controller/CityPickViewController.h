//
//  CityPickViewController.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityPickViewController;

@protocol CitypickViewDelegate <NSObject>

- (void)cityPickView:(CityPickViewController*)cityPickVC state:(NSString*)state city:(NSString*)city;

@end

@interface CityPickViewController : UIViewController

@property (nonatomic, weak) id<CitypickViewDelegate>delegate;

@end
