//
//  NSData+JMHExtension.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/16.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JMHExtension)

/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
