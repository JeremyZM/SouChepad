//
//  CustomerListCell.h
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NameCustomer;     // 客户姓名
@property (weak, nonatomic) IBOutlet UILabel *SexCustomer;      // 客户性别
@property (weak, nonatomic) IBOutlet UILabel *PhoneCustomer;    // 客户电话
@property (weak, nonatomic) IBOutlet UILabel *GradeCustomer;    // 等级
@property (weak, nonatomic) IBOutlet UIButton *TimeUpdate;       // 客户更新时间
- (IBAction)changeTime:(id)sender;


@end
