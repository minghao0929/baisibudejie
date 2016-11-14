//
//  JMHMeFooterView.m
//  01-不思不得姐
//
//  Created by Minghao on 16/9/2.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHMeFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "JMHSquare.h"
#import "JMHSquareButton.h"
#import "JMHWebViewController.h"


@implementation JMHMeFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *sqaures = [JMHSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:sqaures];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    
    self.height = 843.75;
    return self;
}

- (void)createSquares:(NSArray *)sqaures
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = JMHScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        JMHSquareButton *button = [JMHSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;

        
    }
    
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    NSLog(@"111%@",self);
    [self setNeedsLayout];
}

- (void)buttonClick:(JMHSquareButton *)button
{
    if (![button.square.url hasPrefix:@"http"])return;
    
    JMHWebViewController *web = [[JMHWebViewController alloc]init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    
    [nav pushViewController:web animated:YES];
    
}

@end
