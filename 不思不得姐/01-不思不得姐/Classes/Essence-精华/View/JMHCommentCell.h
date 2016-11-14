//
//  JMHCommentHeaderView.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/25.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMHComment;
@interface JMHCommentCell : UITableViewCell

/** 评论 */
@property (strong, nonatomic) JMHComment *comment;
@end
