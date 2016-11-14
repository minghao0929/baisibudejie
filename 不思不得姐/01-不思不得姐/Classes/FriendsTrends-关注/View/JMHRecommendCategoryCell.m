//
//  JMHRecommendCategoryCell.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/4.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHRecommendCategoryCell.h"
#import "JMHRecommendCategory.h"

@interface JMHRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedView;


@end
@implementation JMHRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.backgroundColor = JMHGlobalBg;
    self.selectedView.backgroundColor = JMHRGBColor(219, 21, 26);
    
    self.textLabel.textColor = JMHRGBColor(78, 78, 78);


    
    
//    /*
//     * 方法2: 通过设置cell的选中颜色设计 没有完成 待研究
//     */
//    // cell的选中背景颜色
//    self.textLabel.highlightedTextColor = JMHRGBColor(219, 21, 26);
//    UIView *selectedBg = [[UIView alloc] init];
//    selectedBg.frame = CGRectMake(10, 2, self.width - 10, self.hidden - 4);
//    selectedBg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = selectedBg;
}

- (void)setCategory:(JMHRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectedView.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedView.backgroundColor : JMHRGBColor(78, 78, 78);
    self.backgroundColor = selected ? [UIColor whiteColor] : JMHGlobalBg;
    
}

@end
