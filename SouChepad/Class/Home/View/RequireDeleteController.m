//
//  RequireDeleteController.m
//  Athena
//
//  Created by 张艳东 on 14-7-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "RequireDeleteController.h"
#import "RequireDeleteCell.h"
#import "RequireBrandsModel.h"

@interface RequireDeleteController ()

@end

static NSString *cellID = @"requireDeleteCell";
@implementation RequireDeleteController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        [self.navigationItem setTitle:@"无效需求"];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissMyselfVC)];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"RequireDeleteCell" bundle:nil] forCellReuseIdentifier:cellID];
//        [self.tableView registerClass:[RequireDeleteCell class] forCellReuseIdentifier:cellID];
    }
    return self;
}


- (void)dismissMyselfVC
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.reqDeleteBrandArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (RequireDeleteCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RequireDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setRequireDeleteM:self.reqDeleteBrandArray[indexPath.row]];
    return cell;
}

@end
