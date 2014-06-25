//
//  CustomerListCell.h
//  IpadSouChe
//
//  Created by 张艳东 on 14-4-17.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReservationM.h"

@interface CustomerListCell : UITableViewCell
/** 客户姓名 */
@property (weak, nonatomic) IBOutlet UILabel *NameCustomer;

/**
 *  //客户性别
 */
@property (weak, nonatomic) IBOutlet UILabel *SexCustomer;

/**
 * // 客户电话
 */
@property (weak, nonatomic) IBOutlet UILabel *PhoneCustomer;

/**
 * // 等级
 */
@property (weak, nonatomic) IBOutlet UILabel *GradeCustomer;

/**
 *  客户更新时间
 */
@property (weak, nonatomic) IBOutlet UIButton *TimeUpdate;


@property (nonatomic, strong) UserReservationM *userReserM;
/**
 *   修改预约时间
 *
 *  @param sender 修改预约时间
 */
//- (IBAction)changeTime:(id)sender;

@end
