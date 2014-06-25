//
//  AddUserCarBodyController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-19.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "AddUserCarBodyController.h"
#import "CarTypeTableViewController.h"

@interface AddUserCarBodyController ()
{
    NSArray *array;
}
@end

@implementation AddUserCarBodyController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"添加意向车型"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBar)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(saveBar)];

    array = @[@"车型",@"排量",@"变速箱",@"颜色",@"需求强度",@"备注"];
}

- (void)cancelBar
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)saveBar
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    [cell.textLabel setText:array[indexPath.row]];
    [cell.detailTextLabel setText:@"请选择"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        CarTypeTableViewController *carTypeVC = [[CarTypeTableViewController alloc] init];
        [self.navigationController pushViewController:carTypeVC animated:YES];
    }
}

@end
