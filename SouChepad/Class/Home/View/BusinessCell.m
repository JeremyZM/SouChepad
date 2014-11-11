//
//  BusinessCell.m
//  Athena
//
//  Created by zt on 14-10-21.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "BusinessCell.h"
#import "BusinessView.h"
#import "StyledPageControl.h"

@interface BusinessCell()<SwipeViewDataSource,SwipeViewDelegate>{
    StyledPageControl *pageControl;
    NSMutableArray *businessVOArray;
    int totalPage;//页数
}
@end

@implementation BusinessCell

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        totalPage = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestBusinessInfo) name:@"deleteBusinessSuccess" object:nil];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

// 填充数据
- (void)fillCell{
    totalPage = ceil(businessVOArray.count / 4.0);
    
    [self showBusinessPageAndControl];
}

// 显示商机page和pagecontrol
- (void)showBusinessPageAndControl{
    // 滑动page
    CGRect frame = CGRectMake(0, 0, 1024, 298);
    if (self.swipeView == nil) {
        self.swipeView = [[SwipeView alloc] initWithFrame:frame];
        _swipeView.pagingEnabled = YES;
        _swipeView.delegate = self;
        _swipeView.dataSource = self;
        [self addSubview:self.swipeView];
    }
    [self.swipeView reloadData];
    
    // page control
    if (pageControl == nil) {
        frame = CGRectMake(0, 300, 1024, 350-298);
        pageControl = [[StyledPageControl alloc] initWithFrame:frame];
        [pageControl setPageControlStyle:PageControlStyleDefault];
        [pageControl setCurrentPage:0];
        [pageControl setCoreNormalColor:[UIColor grayColor]];
        [pageControl setCoreSelectedColor:[UIColor hexStringToColor:KBaseColo]];
        [pageControl setGapWidth:10];
        [pageControl setDiameter:15];
        [self addSubview:pageControl];
    }
    [pageControl setNumberOfPages:totalPage];
}

#pragma mark swipeView delegate methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    return totalPage;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    BusinessView *item;
    
    //create new view if no view is available for recycling
    if (view == nil){
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.backgroundColor = [UIColor clearColor];
        
        item = [[BusinessView alloc] initWithFrame:self.swipeView.bounds];
        item.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        item.tag = 1;
        [view addSubview:item];
    }else{
        //get a reference to the label in the recycled view
        item = (BusinessView *)[view viewWithTag:1];
    }
    [item fillViewWithBusinessVOArray:businessVOArray currentPage:index totalPage:totalPage];
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    CGSize size = self.swipeView.bounds.size;
    size.height = 300;
    return size;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    pageControl.currentPage  = swipeView.currentPage;
}

#pragma mark - 网络请求
// 获取商机列表
- (void)requestBusinessInfo{
    [HttpManager requestBusinessInfoSuccess:^(id obj) {
        businessVOArray = obj;
        [self fillCell];
        // 回调
        if (self.delegate && [self.delegate respondsToSelector:@selector(businessDidLoad:)]) {
            [self.delegate businessDidLoad:FormatStr(@"%d", businessVOArray.count)];
        }
    } fail:^(id obj) {
    }];
}
@end
