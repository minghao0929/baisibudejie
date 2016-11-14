//
//  JMHTabBarController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHTabBarController.h"
#import "JMHEssenceViewController.h"
#import "JMHNewViewController.h"
#import "JMHFriendTrendsViewController.h"
#import "JMHMeViewController.h"
#import "JMHNavigationController.h"

#import "JMHTabBar.h"


@interface JMHTabBarController ()

@end

@implementation JMHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    

    

    
    // 设置UITabBarItem的title属性
    NSMutableDictionary *selectedAttributes01 = [NSMutableDictionary dictionary];
    selectedAttributes01[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttributes01[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:selectedAttributes01 forState:UIControlStateSelected];
    
    // 1. 添加子控制器
    [self setupChildVC:[[JMHEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    // 2. 添加子控制器
    [self setupChildVC:[[JMHNewViewController alloc] init] title:@"最新" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    // 3. 添加子控制器
    [self setupChildVC:[[JMHFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    // 4. 添加子控制器 
    [self setupChildVC:[[JMHMeViewController alloc] initWithStyle: UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换tabBar
    [self setValue:[[JMHTabBar alloc]init]  forKey:@"tabBar"];
    
    
}

- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    
    // 设置title
    vc.tabBarItem.title = title;
    vc.navigationItem.title = title;
    
    
    // 设置image
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
//    // 图片渲染设置
//    selectedImage = [selectedImage02 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    JMHNavigationController *nv = [[JMHNavigationController alloc]initWithRootViewController:vc];
    
    
    [self addChildViewController:nv];
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
