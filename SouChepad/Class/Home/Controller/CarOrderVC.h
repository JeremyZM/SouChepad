//
//  CarOrderVC.h
//  Athena
//
//  Created by zt on 14-10-8.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarBaseModel;

@protocol CarOrderVCDelegate <NSObject>

@required
- (void)orderDidComplete;//订单完成

@end

@interface CarOrderVC : UIViewController

@property (nonatomic,weak) id<CarOrderVCDelegate> delegate;

- (id)initWithCarModel:(CarBaseModel*)carModel;
@end
