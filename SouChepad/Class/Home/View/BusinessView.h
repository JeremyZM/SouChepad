//
//  BusinessView.h
//  Athena
//
//  Created by zt on 14-10-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessVO.h"

@interface BusinessView : UIView
- (void)fillViewWithBusinessVOArray:(NSMutableArray*)voArray currentPage:(int)currentpage totalPage:(int)totalPage;
@end
