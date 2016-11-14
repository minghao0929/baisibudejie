//
//  JMHVerticalButton.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/11.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHVerticalButton.h"

@implementation JMHVerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    self.titleLabel.frame = CGRectMake(0, self.width, self.width, self.height - self.width);
}
@end
