//
//  PopoTableViewController.m
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-16.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "PopoTableViewController.h"


@interface PopoTableViewController ()

@property (nonatomic, strong) NSIndexPath *seleindexPath;
@end

@implementation PopoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setScrollEnabled:NO];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    UITableViewCell  *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.textLabel setText:self.array[indexPath.row]];
    if (indexPath.row == [self.selectRow intValue]&&self.selectRow) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [cell.textLabel setTextColor:[UIColor redColor]];
        self.seleindexPath = [NSIndexPath indexPathForRow:[self.selectRow intValue]inSection:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
//    // 重用机制，如果选中的行正好要重用
//    if (self.seleindexPath == indexPath.row) {
//
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//
//    } else {
//
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.seleindexPath == indexPath) return;
    // 取消前一个选中的，就是单选啦
    if (self.seleindexPath) {
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:self.seleindexPath];
        lastCell.accessoryType = UITableViewCellAccessoryNone;
        [lastCell.textLabel setTextColor:[UIColor blackColor]];
    }
    // 选中操作
    UITableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [cell.textLabel setTextColor:[UIColor redColor]];
    [self.popoTabelDelegate PopoTableViewController:self seleckChanged:cell.textLabel.text andseleckRow:indexPath.row andselectBtn:self.sortWayBtn];
    // 保存选中的
    self.seleindexPath = indexPath;
    
}


- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
