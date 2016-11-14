//
//  JMHCommentHeaderView.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/25.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JMHCommentHeaderView : UITableViewHeaderFooterView

/** 文字数据 */
@property (copy, nonatomic) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;;
@end
