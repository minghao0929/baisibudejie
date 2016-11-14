//
//  JMHTopicVoiceView.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/24.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHTopicVoiceView.h"
#import "JMHTopic.h"
#import <UIImageView+WebCache.h>
@interface JMHTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;

@end
@implementation JMHTopicVoiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)setTopic:(JMHTopic *)topic
{
    _topic = topic;
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    // 播放时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger secound = topic.voicetime % 60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,secound];
    
   // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
}
@end
