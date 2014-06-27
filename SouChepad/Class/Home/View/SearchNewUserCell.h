//
//  SearchNewUserCell.h
//  SouChepad
//
//  Created by 张艳东 on 14-6-10.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReservationM.h"

@interface SearchNewUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *addNewUserBut;
@property (strong, nonatomic) UserReservationM *userRM;

@end
