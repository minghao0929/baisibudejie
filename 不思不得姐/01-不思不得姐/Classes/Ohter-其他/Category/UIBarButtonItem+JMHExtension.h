//
//  UIBarButtonItem+JMHExtension.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JMHExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
