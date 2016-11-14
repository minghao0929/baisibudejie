//
//  JMHComment.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/24.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMHUser;

@interface JMHComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频时间 **/
@property (assign, nonatomic) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论内容 **/
@property (copy, nonatomic) NSString *content;
/** 时间 **/
@property (copy, nonatomic) NSString *ctime;
/** 用户 **/
@property (strong, nonatomic) JMHUser *user;
/** 点赞数 **/
@property (assign, nonatomic) NSInteger like_count;
@end
