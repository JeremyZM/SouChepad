//
//  OtherSellUserCell.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-10.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReservationM.h"

@interface OtherSellUserCell : UITableViewCell

@property (nonatomic, strong) UserReservationM *userReserM;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellNameLabel;

@end
