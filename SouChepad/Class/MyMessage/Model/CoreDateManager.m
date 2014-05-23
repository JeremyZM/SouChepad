//
//  CoreDateManager.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-21.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CoreDateManager.h"


@interface CoreDateManager()
{
    NSManagedObjectContext *_managedContext;
    NSManagedObjectModel *_managedModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}
@end

@implementation CoreDateManager


- (void)saveContext
{
    NSError *error = nil;
    if (_managedContext != nil) {
        if ([_managedContext hasChanges] && ![_managedContext save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }

    
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedContext != nil) {
        return _managedContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedContext = [[NSManagedObjectContext alloc] init];
        [_managedContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedModel != nil) {
        return _managedModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MessageModel" withExtension:@"momd"];
    _managedModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedModel;
}



- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MessageModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//插入数据
- (void)insertCoreData:(NSArray*)dataArray
{
    NSManagedObjectContext *context = [self managedObjectContext];
    for (MyMessage *info in dataArray) {
        MyMessage *newsInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        
        newsInfo.comment = info.comment;
        newsInfo.title = info.title;
        newsInfo.commentShwo = info.commentShwo;
        newsInfo.dateCreate = info.dateCreate;
        newsInfo.dateDelete = info.dateDelete;
        newsInfo.dateUpdate = info.dateUpdate;
        newsInfo.image = info.image;
    
        NSError *error;
        if(![context save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
    }
}

//查询
- (NSArray*)selectData:(int)pageSize andOffset:(int)currentPage
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // 限定查询结果的数量
    //setFetchLimit
    // 查询的偏移量
    //setFetchOffset
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    NSMutableArray *resultArray = [NSMutableArray array];

//    for (MyMessageM *info in fetchedObjects) {
//        
//        [resultArray addObject:info];
//    }
    return fetchedObjects;
}

//删除
-(void)deleteData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}
//更新
- (void)updateData:(NSString*)newsId  withIsLook:(NSString*)islook
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"newsid like[cd] %@",newsId];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:TableName inManagedObjectContext:context]];
    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    
    //https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (MyMessage *info in result) {
        info.title = islook;
    }
    
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}

@end
