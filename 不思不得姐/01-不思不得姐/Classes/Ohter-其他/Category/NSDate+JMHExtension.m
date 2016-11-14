//
//  NSData+JMHExtension.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/16.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "NSDate+JMHExtension.h"

@implementation NSDate (JMHExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}
/**
 * 是否为今年
 */
- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

/**
 * 是否为今天
 */
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowDate = [fmt stringFromDate:[NSDate date]];
    NSString *selfDate = [fmt stringFromDate:self];
    return [nowDate isEqualToString:selfDate];
}

/**
 * 是否为昨天
 */
- (BOOL)isYesterday
{
    // 日起格式话类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *cmp = [calendar component:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:<#(nonnull NSDate *)#> t]
    NSDateComponents *cmp = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 1;
}
@end

