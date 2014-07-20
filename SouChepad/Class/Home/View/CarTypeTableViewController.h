//
//  CarTypeTableViewController.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-21.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarTypeTableViewController;

@protocol CarTypeTableViewDelegate <NSObject>

- (void)carTypeTableView:(CarTypeTableViewController*)carTypetable selectCarDic:(NSDictionary*)selectCarDic;

@end

@interface CarTypeTableViewController : UIViewController

@property (nonatomic, weak) id<CarTypeTableViewDelegate> delegate;

@end
