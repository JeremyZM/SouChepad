//
//  InfoDock.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InfoDock;

@protocol InfoDockDelegate <NSObject>

- (void)InfoDock:(InfoDock *)dock tabChangeFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface InfoDock : UIView

@property (nonatomic, weak) id<InfoDockDelegate> delegate;

@end
