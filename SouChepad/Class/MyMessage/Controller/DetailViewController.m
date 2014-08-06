//
//  DetailViewController.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-14.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+LK.h"

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
    [self.navigationController.navigationBar setBarTintColor:[UIColor hexStringToColor:KBaseColo]];
}

- (void)setMessageM:(MyMessage *)messageM
{
    if (_messageM != messageM) {
        
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
        
        [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(self.contentLabel.frame))];
        
        if (messageM.image) {

            
            if (self.imageView == nil) {
                
               self.imageView = [[UIImageView alloc] init];
//                [self.imageView setNeedsLayout];
                [scrollView addSubview:self.imageView];
            }
            [self.imageView setFrame:CGRectMake(30, CGRectGetMaxY(self.contentLabel.frame)+20, 200, 200)];

//            [SDWebImageManager.sharedManager.imageCache clearMemory];
//            [SDWebImageManager.sharedManager.imageCache clearDisk];
            NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://res.souche.com/%@",messageM.image]];
//            [self.imageView setImageWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/eb058794a4c27d1e6b6ad74019d5ad6edcc438a4.jpg"] placeholderImage:[UIImage imageNamed:@"remind_noimage"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                [self.imageView sizeToFit];
//                [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(self.imageView.frame))];
//            }];
//            [self.imageView setImageURL:@"http://assets.sbnation.com/assets/2512203/dogflops.gif"];
            [self.imageView setImageURL:url result:^(BOOL isDownload) {
                [_imageView sizeToFit];
                [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(self.imageView.frame)+30)];
            }];
            

        }else{
            if (self.imageView) {
                
                [self.imageView removeFromSuperview];
                self.imageView = nil;
            }
            
        }
             [scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    }
    
}


//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    [self.imageView sizeToFit];
//    
//}

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
