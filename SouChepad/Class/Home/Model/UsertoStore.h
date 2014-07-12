//
//  UsertoStore.h
//  SouChepad
//
//  Created by 张艳东 on 14-4-28.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsertoStore : NSObject

/** 当前页 */
@property (copy, nonatomic) NSString *currentIndex;

/** 每页个数 */
@property (copy, nonatomic) NSString *pageSize;

/** 总记录数 */
@property (copy, nonatomic) NSString *totalNumber;

/** 总页数 */
@property (copy, nonatomic) NSString *totalPage;

/** 下一页 */
@property (copy, nonatomic) NSString *nextIndex;

@property (nonatomic, strong) NSMutableArray *usersArray;


@end
