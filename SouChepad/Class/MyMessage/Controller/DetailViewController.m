//
//  DetailViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()
{
    UIScrollView *scrollView;
}
@end

@implementation DetailViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

- (void)setMessageM:(MyMessage *)messageM
{
    _messageM = messageM;
    [self.titleLabel setText:messageM.title];
    [self.titleLabel setFrame:CGRectMake(30, 30, scrollView.frame.size.width-60, 30)];
    [self.titleLabel sizeToFit];

    [self.dateLabel setText:messageM.dateCreate];
    [self.dateLabel setFrame:CGRectMake(30, CGRectGetMaxY(self.titleLabel.frame)+5, 30, 30)];
    [self.dateLabel sizeToFit];
    
    
    [self.contentLabel setText:messageM.comment];
    [self.contentLabel setFrame:CGRectMake(30, CGRectGetMaxY(self.dateLabel.frame)+20, scrollView.frame.size.width-60, 30)];
    [self.contentLabel sizeToFit];

    if (![messageM.image  isEqual: @"NULL"]) {
        [self.imageView setFrame:CGRectMake(30, CGRectGetMaxY(self.contentLabel.frame)+30, 50, 50)];
        
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://res.souche.com/%@",messageM.image]];
    
    [self.imageView setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        [[SDImageCache sharedImageCache] storeImage:image forKey:messageM.image];
        
    }];
        [self.imageView sizeToFit];
        [scrollView addSubview:self.imageView];

            [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(self.imageView.frame))];
    }else{
        [self.imageView removeFromSuperview];
        [self.imageView setFrame:CGRectZero];
        [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(self.contentLabel.frame))];

    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:scrollView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
    [scrollView addSubview:self.titleLabel];

    
    self.dateLabel = [[UILabel alloc] init];
    [self.dateLabel setFont:[UIFont systemFontOfSize:16]];
    [self.dateLabel setTextColor:[UIColor grayColor]];
    [scrollView addSubview:self.dateLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    [scrollView addSubview:self.contentLabel];
//    [self.contentLabel setFont:[UIFont systemFontOfSize:80]];
    [self.contentLabel setNumberOfLines:0];

    self.imageView = [[UIImageView alloc] init];
   [scrollView addSubview:self.imageView];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
