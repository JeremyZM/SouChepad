//
//  SCDock.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCDock;

@protocol SCDockDelegate <NSObject>

//@optional
- (void)SCDock:(SCDock *)dock tabChangeFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface SCDock : UIView

@property (nonatomic, weak) id<SCDockDelegate> delegate;
@end
