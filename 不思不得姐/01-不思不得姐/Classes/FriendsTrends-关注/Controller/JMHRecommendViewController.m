//
//  JMHRecommendViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/4.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHRecommendViewController.h"
#import "JMHRecommendCategoryCell.h"
#import "JMHRecommendCategory.h"
#import "JMHRecommendUserCell.h"
#import "JMHRecommendUser.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h> 

#define JMHSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface JMHRecommendViewController() <UITableViewDelegate,UITableViewDataSource>

/** 左侧类目 **/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右侧列表 **/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *users;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation JMHRecommendViewController

static NSString * const JMHCategoryID = @"category";
static NSString * const JMHUserID = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化控件
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
    
    
    
}

- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 获取category数据
        self.categories = [JMHRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        //        NSLog(@"%@",responseObject[@"list"]);
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"连接失败!"];
        
    }];
}

/**
 * 控件的初始化
 */
- (void)setupTableView
{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JMHRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:JMHCategoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JMHRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:JMHUserID];

    
    // 取消scrollview的自动排版
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 70;
    
    self.view.backgroundColor = JMHGlobalBg;
    self.title = @"推荐关注";
    self.userTableView.backgroundColor = JMHGlobalBg;
}

- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    JMHRecommendCategory *category = JMHSelectedCategory;
    category.currentPage = 1;
    // 发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    self.params = params;
    // 发送请求给服务器，加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *array = [JMHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清楚所有旧数据
        [category.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:array];
        
        category.total = [responseObject[@"total"] integerValue];
        
        // 不适最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败！"];
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    
    JMHLogFunc;
    JMHRecommendCategory *category = JMHSelectedCategory;
    
    // 发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *array = [JMHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:array];
        
        //category.total = [responseObject[@"total"] integerValue];
        
        // 不适最后一次请求
        if (self.params != params) return;
        // 刷新表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败！"];
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    JMHRecommendCategory *rc = JMHSelectedCategory;
    
    //每次刷新右边数据时，都控制footer显示或隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) {// 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{// 还没有加载
        [self.userTableView.mj_footer endRefreshing];
    }
}
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // 左边类别列表
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 右边用户列表
    JMHRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    [self checkFooterState];
    return c.users.count;
    
        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {// 左边类别列表
        JMHRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:JMHCategoryID];
        
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{// 右边用户列表
        JMHRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:JMHUserID];
        
        JMHRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.mj_footer endRefreshing];
    [self.userTableView.mj_header endRefreshing];
    
    JMHRecommendCategory *category = self.categories[indexPath.row];
    
    if (category.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    }else{

        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc{
    
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
