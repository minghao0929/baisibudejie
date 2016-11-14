//
//  JMHMeViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHMeViewController.h"
#import "JMHMeFooterView.h"
@interface JMHMeViewController ()

@end

@implementation JMHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];
    JMHMeFooterView *footer = [[JMHMeFooterView alloc]init];
    self.tableView.tableFooterView = footer;
    NSLog(@"%@",self.tableView.tableFooterView);
    
    NSLog(@"%@",footer);
}

- (void)setupBasic{
    
    // 设置view的navigationItem的title
    self.navigationItem.title = @"我的";
    
    // 设置navigationItem的rightBarButtonItem
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingBtnClick)];
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingButton,moonButton];
    
    self.tableView.backgroundColor = JMHGlobalBg;
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);

}

- (void)settingBtnClick
{
    JMHLogFunc;
}

- (void)moonBtnClick
{
    JMHLogFunc;
}

#pragma mark <UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"meCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
