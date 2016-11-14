//
//  UIBarButtonItem+JMHExtension.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "UIBarButtonItem+JMHExtension.h"

@implementation UIBarButtonItem (JMHExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    // 设置navigation的leftBarButtonItem MainTagSubIconClick
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    // 设置size （必须设置）
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
 
    return [[self alloc] initWithCustomView:button];
}
@end
