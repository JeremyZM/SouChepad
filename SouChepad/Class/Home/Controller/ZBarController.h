//
//  ZBarController.h
//  Athena
//
//  Created by 张艳东 on 14-6-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZBarController;

@protocol ZBarControllerDelegate <NSObject>

- (void)zBarController:(ZBarController*)zbarVC didFinishPickingMediaWithInfo: (NSDictionary*) info;

@end


@interface ZBarController : UIViewController

@property (weak, nonatomic) id<ZBarControllerDelegate> delegate;

@end
