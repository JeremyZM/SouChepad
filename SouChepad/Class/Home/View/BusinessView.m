//
//  BusinessView.m
//  Athena
//
//  Created by zt on 14-10-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "BusinessView.h"
#import "BusinessItem.h"

@interface BusinessView(){
    __weak IBOutlet BusinessItem *cell1;
    __weak IBOutlet BusinessItem *cell2;
    __weak IBOutlet BusinessItem *cell3;
    __weak IBOutlet BusinessItem *cell4;
    
    NSArray *itemArray;
}

@end
@implementation BusinessView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = LoadNibWithName(@"BusinessView");
        itemArray = @[cell1,cell2,cell3,cell4];
        self.frame = frame;
    }
    return self;
}

- (void)fillViewWithBusinessVOArray:(NSMutableArray*)voArray currentPage:(int)currentpage totalPage:(int)totalPage{
    cell1.hidden = YES;
    cell2.hidden = YES;
    cell3.hidden = YES;
    cell4.hidden = YES;
    
    // vo的索引
    int voIndex = currentpage*4;
 
    for (BusinessItem *item in itemArray) {
        item.hidden = NO;
        BusinessVO *vo = [voArray objectAtIndex:voIndex];
        [item fillValueWithBusinessVO:vo];
        voIndex++;
        if (voIndex >= voArray.count) {
            break;
        }
    }
}
@end
