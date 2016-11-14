//
//  JMHRecommendTag.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/9.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMHRecommendTag : NSObject


/*
 "image_list" = "http://img.spriteapp.cn/ugc/2016/03/10/092924_69853.jpg";
 "is_default" = 0;
 "is_sub" = 0;
 "sub_number" = 239026;
 "theme_id" = 3096;
 "theme_name" = "\U767e\U601d\U7ea2\U4eba";

*/

/** 图片 */
@property (copy, nonatomic) NSString *image_list;

/** 名字 */
@property (copy, nonatomic) NSString *theme_name;

/** 订阅数 */
@property (assign, nonatomic) NSInteger sub_number;

@end
