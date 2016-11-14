//
//  JMHCommentHeaderView.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/25.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHCommentHeaderView.h"

@interface JMHCommentHeaderView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end
@implementation JMHCommentHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    
    JMHCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {// 缓存池中没有, 自己创建
        header = [[JMHCommentHeaderView alloc] initWithReuseIdentifier:ID];
    
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = JMHGlobalBg;

        // 创建label
        UILabel *label = [[UILabel alloc]init];
        label.textColor =  JMHRGBColor(67, 67, 67);
        label.width = 200;
        label.x = JMHTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return  self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}


@end
