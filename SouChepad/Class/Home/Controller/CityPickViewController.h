//
//  CityPickViewController.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"
@class CityPickViewController;

@protocol CitypickViewDelegate <NSObject>

- (void)cityPickView:(CityPickViewController*)cityPickVC HZlocation:(HZLocation*)hzLocation;

@end

@interface CityPickViewController : UIViewController

@property (nonatomic, weak) id<CitypickViewDelegate>delegate;
@property (nonatomic, strong) HZLocation *hzLocat;

@end
