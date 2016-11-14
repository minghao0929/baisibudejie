//
//  JMHRecommendTagsCell.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/9.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHRecommendTagsCell.h"
#import "JMHRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface JMHRecommendTagsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation JMHRecommendTagsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setRecommendTag:(JMHRecommendTag *)RecommendTag
{
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:RecommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = RecommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (RecommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",RecommendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",RecommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= frame.origin.x * 2;
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
