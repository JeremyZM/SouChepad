//
//  IntentionCarsController.m
//  SouChepad
//
//  Created by 张艳东 on 14-4-27.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "IntentionCarsController.h"
#import "Cell.h"
#import "seconCell.h"
#import "HttpManager.h"
#import "UserReservationM.h"

@interface IntentionCarsController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    
}
@end
static NSString *cellid = @"deal";
static NSString *seconCellID = @"seconCell";

@implementation IntentionCarsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isNew) {
        
    }else {
        [HttpManager requestUserIntentionWithParamDic:@{@"userId":self.userReserM.crmUserId} Success:^(id obj) {
            
        } fail:^(id obj) {
            
        }];
    }
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    [self addCollectionView];
    [self addToolbar];
}

- (void)addToolbar
{
    UIToolbar *toobar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [toobar setAlpha:0.9];
    [toobar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:toobar];
    
    
    UISegmentedControl *orderSegmented = [[UISegmentedControl alloc] initWithItems:@[@"已购车辆",@"试驾车辆",@"已看车辆--20",@"收藏车辆"]];
    [orderSegmented setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    [orderSegmented setBounds:CGRectMake(0, 0, toobar.frame.size.width, 40)];
    [orderSegmented setCenter:toobar.center];
    [orderSegmented setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [orderSegmented setSelectedSegmentIndex:0];
    //    [orderSegmented setTintColor:[UIColor lightGrayColor]];
    [orderSegmented addTarget:self action:@selector(SegmentedChanged:) forControlEvents:UIControlEventValueChanged];
    [toobar addSubview:orderSegmented];
}


- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setSectionInset:UIEdgeInsetsMake(20, 20, 0, 20)];
//    layout.minimumLineSpacing = 20;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    [_collectionView registerClass:[Cell class] forCellWithReuseIdentifier:cellid];
    [_collectionView registerClass:[seconCell class] forCellWithReuseIdentifier:seconCellID];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

    [self.view addSubview:_collectionView];
    
}

- (void)SegmentedChanged:(UISegmentedControl *)Seg
{
    NSIndexPath *index  = [NSIndexPath indexPathForItem:0 inSection:Seg.selectedSegmentIndex];
    
   
    [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

#pragma mark - 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section?20:5;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(self.view.frame.size.width-40 , 300);
    if (indexPath.section==1) {
        size = CGSizeMake(self.view.frame.size.width*0.3, 300);
    }
    return size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"----------cellForItemAtIndexPath");
    UICollectionViewCell *cell = nil;
    if (indexPath.section==0) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    }else if (indexPath.section == 1){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:seconCellID forIndexPath:indexPath];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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
