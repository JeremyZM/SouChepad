//
//  CarTypeTableViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-21.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "CarTypeTableViewController.h"
#import "MultiTablesView.h"

@interface CarTypeTableViewController () <MultiTablesViewDataSource,MultiTablesViewDelegate,UIScrollViewDelegate>

{
    NSInteger selectRow;
    NSInteger selectSection;
}
@property (nonatomic, strong) MultiTablesView *carTableView;
@property (nonatomic, strong) NSArray *carTypeArray;
@end

@implementation CarTypeTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carTypeArray = [NSArray arrayWithContentsOfFile:KAllCarTypeData];
    self.carTableView = [[MultiTablesView alloc] initWithFrame:self.view.frame];
    [self.carTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.carTableView setDataSource:self];
    [self.carTableView setDelegate:self];
    [self.carTableView setNextTableViewHorizontalGap:200];
    [self.view addSubview:self.carTableView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfLevelsInMultiTablesView:(MultiTablesView *)multiTablesView
{
    return 2;
}

- (NSInteger)multiTablesView:(MultiTablesView *)multiTablesView numberOfSectionsAtLevel:(NSInteger)level
{
    if (level==0) {
        
        return self.carTypeArray.count;
    }
    return 1;
}


- (NSInteger)multiTablesView:(MultiTablesView *)multiTablesView level:(NSInteger)level numberOfRowsInSection:(NSInteger)section
{
    
    if (level==0) {
        NSDictionary *dick = self.carTypeArray[section];
        NSArray *carA = [dick objectForKey:@"car"];
        return carA.count;

    }else if(level == 1){
        NSDictionary *dick = self.carTypeArray[selectSection];
        NSArray *carA = [dick objectForKey:@"car"];
        NSDictionary *dicc = carA[selectRow];
        NSArray *cartM = [dicc objectForKey:@"dic"];
        return cartM.count;
    }
    return 1;
}


- (NSString*)multiTablesView:(MultiTablesView *)multiTablesView level:(NSInteger)level titleForHeaderInSection:(NSInteger)section
{
    if (level==0) {
        NSDictionary *dick = self.carTypeArray[section];
        return [dick objectForKey:@"key"];
    }
    return nil;
}


- (UITableViewCell*)multiTablesView:(MultiTablesView *)multiTablesView level:(NSInteger)level cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [multiTablesView dequeueReusableCellForLevel:level withIdentifier:CellIdentifier];
    if (cell==nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
    
    if (level==0) {
        NSDictionary *dick = self.carTypeArray[indexPath.section];
        NSArray *carA = [dick objectForKey:@"car"];
        NSDictionary *carDic = carA[indexPath.row];
        [cell.textLabel setText:[carDic objectForKey:@"name"]];
    }else if (level ==1){
        NSDictionary *dick = self.carTypeArray[selectSection];
        NSArray *carA = [dick objectForKey:@"car"];
        NSDictionary *dicc = carA[selectRow];
        NSArray *cartM = [dicc objectForKey:@"dic"];
        NSDictionary *carrrr = cartM[indexPath.row];
        [cell.textLabel setText:[carrrr objectForKey:@"name"]];
    }
    
    return cell;
}


#pragma mark Levels
- (void)multiTablesView:(MultiTablesView *)multiTablesView levelDidChange:(NSInteger)level {
    
	if (multiTablesView.currentTableViewIndex == level) {
		[multiTablesView.currentTableView deselectRowAtIndexPath:[multiTablesView.currentTableView indexPathForSelectedRow] animated:YES];
	}
}


- (NSArray*)multisectionIndexTitlesForTableView:(UITableView *)tableView level:(NSInteger)level
{
    if (level==0) {
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.carTypeArray.count];
        for (NSDictionary *dickey in self.carTypeArray) {
            [arrayM addObject:[dickey objectForKey:@"key"]];
        }
        return arrayM;
    }
    return nil;
}

- (void)multiTablesView:(MultiTablesView *)multiTablesView level:(NSInteger)level didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (level==0) {
        selectRow = indexPath.row;
        selectSection = indexPath.section;
    }else if (level==1) {
        [self.carTableView popCurrentTableViewAnimated:YES];
    }
}


@end
