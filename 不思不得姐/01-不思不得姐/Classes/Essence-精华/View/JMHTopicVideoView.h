//
//  JMHTopicVideoView.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/24.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMHTopic;
@interface JMHTopicVideoView : UIView

/** 帖子数据 */
@property (strong, nonatomic) JMHTopic *topic;

+ (instancetype)videoView;

@end
