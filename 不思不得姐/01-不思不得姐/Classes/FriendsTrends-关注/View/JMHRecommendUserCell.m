//
//  JMHRecommendUserCell.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/6.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHRecommendUserCell.h"
#import "JMHRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface JMHRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end

@implementation JMHRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(JMHRecommendUser *)user
{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
