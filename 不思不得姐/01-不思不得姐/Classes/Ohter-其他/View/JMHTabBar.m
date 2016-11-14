//
//  JMHTabBar.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHTabBar.h"
#import "JMHPublishViewController.h"
@interface JMHTabBar()

@property (nonatomic, strong) UIButton *publishButton;
@end

@implementation JMHTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置publishButton的frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);

    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5.0;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
            
            
            buttonX = buttonW * ((index > 1)?(index + 1):index);
            
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
        
    }
}

- (void)publishClick
{
    // 创建publish控制器
    JMHPublishViewController *publishVC = [[JMHPublishViewController alloc]init];
    
    // 呈现publish控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

@end
