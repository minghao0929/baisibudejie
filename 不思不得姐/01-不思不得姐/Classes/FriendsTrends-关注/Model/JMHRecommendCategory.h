//
//  JMHRecommendCategory.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/4.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMHRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 缓存user **/
@property (strong, nonatomic) NSMutableArray *users;
/** 总数 **/
@property (assign, nonatomic) NSInteger total;
/** 当前页码 **/
@property (assign, nonatomic) NSInteger currentPage;
@end
