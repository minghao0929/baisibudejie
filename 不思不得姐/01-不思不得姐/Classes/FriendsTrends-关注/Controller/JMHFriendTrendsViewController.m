//
//  JMHFriendTrendsViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHFriendTrendsViewController.h"
#import "JMHRecommendViewController.h"
#import "JMHLoginRegisterViewController.h"
@interface JMHFriendTrendsViewController ()

@end

@implementation JMHFriendTrendsViewController
- (IBAction)loginBtn:(id)sender {
    JMHLoginRegisterViewController *vc = [[JMHLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = JMHGlobalBg;
    
    // 设置view的navigationItem的title
    self.navigationItem.title = @"我的关注";
    [self.view sizeToFit];
    
    // 设置navigationItem的leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsBtnClick)];
}

- (void)friendsBtnClick
{
    JMHLogFunc;
    JMHRecommendViewController *vc = [[JMHRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
