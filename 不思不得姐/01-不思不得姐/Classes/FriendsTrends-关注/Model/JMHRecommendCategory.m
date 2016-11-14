//
//  JMHRecommendCategory.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/4.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHRecommendCategory.h"

@implementation JMHRecommendCategory

- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end
