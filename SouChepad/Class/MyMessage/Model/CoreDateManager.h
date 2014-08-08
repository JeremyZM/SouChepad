//
//  CoreDateManager.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-21.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SystermMessage.h"

#define TableName @"MyMessage"

@interface CoreDateManager : NSObject

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//插入数据
- (void)insertCoreData:(NSArray*)dataArray;
//查询
- (NSArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteData;
//更新
- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end
