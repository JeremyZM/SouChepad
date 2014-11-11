//
//  BusinessItem.m
//  Athena
//
//  Created by zt on 14-10-22.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "BusinessItem.h"
#import "BusinessVO.h"
#import "UIImageView+WebCache.h"
#import "CommunAddVC.h"
#import "UIView+ParentController.h"
#import "InfoMainController.h"
#import "UIImage+Utility.h"

@interface BusinessItem(){
    __weak IBOutlet UIImageView *carImage;
    __weak IBOutlet UILabel *userName;
    __weak IBOutlet UILabel *phone;
    __weak IBOutlet UILabel *carName;
    __weak IBOutlet UILabel *businessType;
    __weak IBOutlet UILabel *time;
    __weak IBOutlet UILabel *userLabel;// 给用打得各种标签
    __weak IBOutlet UIButton *commentButton;
    __weak IBOutlet UIButton *deleteButton;
    
    BusinessVO *businessVO;
}
@end

@implementation BusinessItem

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view = LoadNibWithName(@"BusinessItem");
        view.frame = self.bounds;
        [self addSubview:view];
        // 设置ui样式
        [self initUIStyle];
        // 商机点击
        [self addTapAction];
    }
    return self;
}

// 设置ui样式
- (void)initUIStyle{
    [commentButton.titleLabel setFont:KBoldFont18];
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentButton setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    [commentButton setImage:[UIImage imageNamed:@"tubiao_35"] forState:UIControlStateNormal];
    [commentButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    
    [businessType setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
    
    viewroundCorner(self, [UIColor clearColor], 0.5, 5);
}

// 显示商机的详细数据
- (void)fillValueWithBusinessVO:(BusinessVO*)vo{
    businessVO = vo;
    
    UIImage *img = [UIImage new];
    [img setImageWithUrl:vo.carImageURL scaleToSize:carImage.frame.size forImageView:carImage];

//    [carImage setImageWithURL:[NSURL URLWithString:vo.carImageURL] placeholderImage:[UIImage imageNamed:@"loading_03"]];
    userName.text = vo.userName;
    phone.text = vo.phone;
    carName.text = vo.carName;
    businessType.text = vo.requirementSourceName;
    time.text = vo.dateUpdate;
    if (vo.tags != nil && ![vo.tags isKindOfClass:[NSNull class]]) {
        NSString *tags = FormatStr(@"标签:%@", [[vo.tags componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@"," withString:@" "]);
        userLabel.text = tags;
    }
}

// 监听 tap 事件
- (void)addTapAction{
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)];
    [self addGestureRecognizer:rec];
}

// 删除商机
- (IBAction)deleteButtonAction:(id)sender {
    
    [HttpManager requestDeleteBusinessWithid:businessVO.id success:^(id obj) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteBusinessSuccess" object:businessVO];
    } fail:^(id obj) {
        
    }];
}

// 处理 点击事件，进入 InfoMainController
- (void)itemClicked:(UITapGestureRecognizer*)rec{
    InfoMainController *infoMVC = [[InfoMainController alloc] init];
    UserReservationM *userReserM = [[UserReservationM alloc] init];
    userReserM.crmUserId = businessVO.user;
    [infoMVC setUserInfoM:userReserM];
    [[self viewController].navigationController pushViewController:infoMVC animated:YES];
}

// 沟通记录按钮
- (IBAction)commentButtonAction:(id)sender {
    CommunAddVC *commAddVC = [[CommunAddVC alloc] init];
    
    UserReservationM *userReserM = [[UserReservationM alloc] init];
    userReserM.crmUserId = businessVO.user;
    commAddVC.userResM = userReserM;

    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:commAddVC];
    [navVC setModalPresentationStyle:UIModalPresentationFormSheet];
    UIViewController *controller = [self viewController];
    [controller presentViewController:navVC animated:YES completion:^{}];
}

#pragma mark - CommunAddVCDelegate

@end
