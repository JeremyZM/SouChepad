//
//  JBInfoView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-5.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "JBInfoView.h"

@interface JBInfoView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *JBtableView;
}
@end

@implementation JBInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *array = @[@"姓名",@"手机",@"性别",@"级别",@"指标",@"过户方式",@"付款方式",@"购车用途",@"拥有车辆",@"是否卖车"];
        JBtableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [JBtableView setDataSource:self];
        [JBtableView setDelegate:self];
        [self addSubview:JBtableView];
        
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


@end
