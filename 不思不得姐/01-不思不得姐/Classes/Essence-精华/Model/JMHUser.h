//
//  JMHUser.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/24.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMHUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;


@end
