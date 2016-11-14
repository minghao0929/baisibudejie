//
//  JMHRecommendTagsViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/9.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHRecommendTagsViewController.h"
#import "JMHRecommendTag.h"
#import "JMHRecommendTagsCell.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
@interface JMHRecommendTagsViewController ()

/** 标签数据 **/
@property (nonatomic, strong) NSArray *tags;
@end

static NSString * const JMHTagsID = @"tag";

@implementation JMHRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    // 加载蒙板
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 保存数据
        self.tags = [JMHRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = JMHGlobalBg;
    self.title = @"推荐关注";
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JMHRecommendTagsCell class]) bundle:nil] forCellReuseIdentifier:JMHTagsID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMHRecommendTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:JMHTagsID];
    cell.RecommendTag = self.tags[indexPath.row];
    
    // Configure the cell...
    
    return cell;
}



@end
