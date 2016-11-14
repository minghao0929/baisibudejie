//
//  JMHNewViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHNewViewController.h"

@interface JMHNewViewController ()

@end

@implementation JMHNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置navigation的title图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置navigation的leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(mainTagBtnClick)];
    
}
- (void)mainTagBtnClick
{
    JMHLogFunc;
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
