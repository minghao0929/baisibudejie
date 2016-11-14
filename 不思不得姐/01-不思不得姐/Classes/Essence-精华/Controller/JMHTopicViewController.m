//
//  JMHTopicViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/13.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHTopicViewController.h"
#import "JMHTopic.h"
#import "JMHTopicCell.h"
#import "JMHCommentViewController.h"
#import "JMHNewViewController.h"
#import <AFNetworking.h>
#import "UIImageView+WebCache.h"
#import <MJExtension.h>
#import <MJRefresh.h>

@interface JMHTopicViewController ()

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 帖子数据 **/
@property (nonatomic, strong) NSMutableArray *topics;
/** 上一次的请求参数 **/
@property (nonatomic, strong) NSDictionary *params;
/** 当加载下一页数据时需要这个参数 **/
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation JMHTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}


static NSString * const JMHTopicCellID = @"topic";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
//    

//
    
}

- (void)setupTableView
{

    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = JMHTitilesViewH + JMHTitilesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JMHTopicCell class]) bundle:nil] forCellReuseIdentifier:JMHTopicCellID];
}
/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据处理
/**
 * 加载新的帖子数据
 */

- (NSString *)a
{
    NSString *a = nil;
    if ([self.parentViewController isKindOfClass:[JMHNewViewController class]]) {
        a = @"newlist";
    }else{
        a = @"list";
    }
    return  a;
}
- (void)loadNewTopics
{
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典 -> 模型
        self.topics = [JMHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
//        NSLog(@"---%@",responseObject);
//        [responseObject[@"list"] writeToFile:@"/Users/apple/Desktop/2016-IOS/top_comment.plist" atomically:YES];
    
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopics
{
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [JMHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 清空页码
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:JMHTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMHTopic *topic = self.topics[indexPath.row];
    return  topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMHCommentViewController *commentVC = [[JMHCommentViewController alloc]init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:NO];
    
}

@end
