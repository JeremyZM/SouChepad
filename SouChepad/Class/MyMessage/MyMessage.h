//
//  MyMessage.h
//  SouChepad
//
//  Created by 张艳东 on 14-5-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyMessage : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *commentShwo;
@property (nonatomic, strong) NSString *dateCreate;
@property (nonatomic, strong) NSString *dateDelete;
@property (nonatomic, strong) NSString *dateUpdate;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;

@end