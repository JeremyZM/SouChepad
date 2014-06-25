//
//  ImageViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-6-23.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [imageview setImage:self.avatarImageView.image];
    [imageview setUserInteractionEnabled:YES];
    [self.view addSubview:imageview];
    
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideself:)];
    [imageview addGestureRecognizer:hideTap];

}

- (void)hideself:(UITapGestureRecognizer*)tep
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
