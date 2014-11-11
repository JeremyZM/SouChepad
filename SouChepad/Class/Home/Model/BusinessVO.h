//
//  BusinessVO.h
//  Athena
//
//  Created by zt on 14-10-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessVO : NSObject
@property (nonatomic,copy) NSString *carId;// ;// "00120327-ef94-43b4-bfd8-20e98fc27426";
@property (nonatomic,copy) NSString *carImage ;// "http://img.souche.com/files/carpicture/
@property (nonatomic,copy) NSString *carImageURL ;// "http://img.souche.com/files/carpicture/
@property (nonatomic,copy) NSString *carName ;// aaaaa;
@property (nonatomic,copy) NSString *dateCreate ;// "2014-10-20 00:00:00";
@property (nonatomic,copy) NSString *dateDelete ;// "<null>";
@property (nonatomic,copy) NSString *dateUpdate ;// "2014-10-22 10:16:02";
@property (nonatomic,copy) NSString *id ;// 218iVRcL33;
@property (nonatomic,copy) NSString *phone ;// 18635939830;
@property (nonatomic,copy) NSString *remark ;// "<null>";
@property (nonatomic,copy) NSString *requirementSource ;// aaaaa;
@property (nonatomic,copy) NSString *requirementSourceName ;// aaaaa;
@property (nonatomic,copy) NSString *sellHandler ;// salertest;
@property (nonatomic,copy) NSString *store ;// 000001;
@property (nonatomic,copy) NSString *type ;// ipad;
@property (nonatomic,copy) NSString *user ;// 18635939830;
@property (nonatomic,copy) NSString *userName ;// "<null>";
@property (nonatomic,strong) NSArray *tags;
@end
