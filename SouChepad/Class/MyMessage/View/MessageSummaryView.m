//
//  SummaryView.m
//  Athena
//
//  Created by zt on 14-8-11.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "MessageSummaryView.h"
#import "MessageType.h"
#import "SystermMessage.h"
#import "MyMessageCell.h"
#import "MessageType.h"
#import "MJRefresh.h"

@interface MessageSummaryView()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>{
    UITableView *tbView;
    NSMutableArray *_messageArray;
    NSArray *filteredContentList;
    int messageType;//消息类型
    int page;//请求第一页消息
    int pageSize;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation MessageSummaryView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化数据
        page = 0;
        pageSize = 40;// 每页显示40条
        messageType = kMyMessage;
        [self requestMessageWithType:messageType];
        [self showTableView];
    }
    return self;
}


- (void)showTableView{
    if (tbView == nil) {
        tbView = [[UITableView alloc] initWithFrame:self.bounds];
        tbView.delegate = self;
        tbView.dataSource = self;
        [self addSubview:tbView];
        
        [self addPullRefresh];
    }else {
        [tbView reloadData];
    }
}
                       
// 集成上拉，下拉刷新
- (void)addPullRefresh{
    // 1.添加下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    _header.scrollView = tbView;
}

// 结束刷新
- (void)endRefresh{
    [_header endRefreshing];
    [_footer endRefreshing];
}

// 获取系统消息或者我的消息
- (void)requestMessageWithType:(int)type{
    messageType = type;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    // 页
    [dic setObject:[NSNumber numberWithInt:page] forKey:@"index"];
    // 条
    [dic setObject:@"40" forKey:@"pageSize"];
    //销售ID
    [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forKey:@"userName"];
    
    // 获取系统消息
    if (type == kSystermMessage) {
        // 类型（系统信息：system）
        [dic setObject:@"system" forKey:@"readType"];
        
        [HttpManager requestSystermMessage:dic Success:^(id obj) {
            [self showFirstMessages:obj];
        } fail:^(id obj) {
            [self endRefresh];
        }];
    }else{
        // 获取个人消息
        [HttpManager requestMyMessageWithParamDic:dic Success:^(id obj) {
            [self showFirstMessages:obj];
        } fail:^(id obj) {
            [self endRefresh];
        }];
    }
}


// 数据请求完后显示消息
- (void)showFirstMessages:(id)obj{
    _messageArray = [NSMutableArray arrayWithArray:obj];
    [tbView reloadData];
    //默认显示第一条详情
    if (page == 0) {
        [self showMessageDetailWithIndex:0];
    }
    [self endRefresh];
}

// 显示消息详情
- (void)showMessageDetailWithIndex:(int)msgIndex{
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(messageCellDidSelectedAtIndex:data:)]) {
        SystermMessage *message = nil;
        if (_messageArray.count > 0) {
            message = [_messageArray objectAtIndex:msgIndex];
        }
        [self.cellDelegate messageCellDidSelectedAtIndex:msgIndex data:message];
    }
}


#pragma mark - 刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        // 下拉刷新
       [_messageArray removeAllObjects];
        [self requestMessageWithType:messageType];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyMessageCell";
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[MyMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)_cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageCell *cell = (MyMessageCell*)_cell;
    SystermMessage *msg = [_messageArray objectAtIndex:indexPath.row];
    [cell fillValueWithMessage:msg type:messageType];
    if (indexPath.row == 0) {
        [cell markMessageStatusForData];
    }
    
    
    // 加载到最后一条的时候自动加载下一页
    if ((indexPath.row == _messageArray.count-1) && (_messageArray.count%pageSize == 0)) {
        page++;
        [self requestMessageWithType:messageType];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showMessageDetailWithIndex:indexPath.row];
}
@end
