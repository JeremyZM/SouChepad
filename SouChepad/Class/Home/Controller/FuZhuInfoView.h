//
//  FuZhuInfoView.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-6.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPIMController.h"
#import "UserExtendModel.h"
#import "UserVOModel.h"

@interface FuZhuInfoView : UIView
@property (nonatomic, weak) CustomPIMController *customPIMVC;
- (id)initWithFrame:(CGRect)frame userVOModel:(UserVOModel*)userVo userExtendmodel:(UserExtendModel*)userExtendM;
@end
