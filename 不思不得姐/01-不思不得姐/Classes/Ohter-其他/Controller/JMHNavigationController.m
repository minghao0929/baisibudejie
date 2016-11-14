//
//  JMHNavigationController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/4.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHNavigationController.h"

@implementation JMHNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    

    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"返回" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        
        //    button.backgroundColor = [UIColor blueColor];
        
        // 让button的内容向左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 方法1:设置edge 向左偏移
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
