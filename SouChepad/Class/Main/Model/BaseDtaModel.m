//
//  BaseDtaModel.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-9.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "BaseDtaModel.h"

#define KCode @"KCode"
#define KName @"KName"
#define KUpdateDate @"KUpdateDate"


@implementation BaseDtaModel

#pragma mark - 归档和解档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_code forKey:KCode];
    [aCoder encodeObject:_name forKey:KName];
    [aCoder encodeObject:_updateDate forKey:KUpdateDate];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.code = [aDecoder decodeObjectForKey:KCode];
        self.name = [aDecoder decodeObjectForKey:KName];
        self.updateDate = [aDecoder decodeObjectForKey:KUpdateDate];
    }
    return self;
}

@end
