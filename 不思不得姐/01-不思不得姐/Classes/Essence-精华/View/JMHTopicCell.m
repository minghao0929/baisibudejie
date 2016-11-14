//
//  JMHTopicCell.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/15.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHTopicCell.h"
#import <UIImageView+WebCache.h>
#import "JMHTopic.h"
#import "JMHTopicPictureView.h"
#import "JMHTopicVoiceView.h"
#import "JMHTopicVideoView.h"
#import "JMHComment.h"
#import "JMHUser.h"

@interface JMHTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UIButton *ding;
@property (weak, nonatomic) IBOutlet UIButton *cai;
@property (weak, nonatomic) IBOutlet UIButton *repost;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 声音帖子中间的内容 */
@property (nonatomic, weak) JMHTopicVoiceView *voiceView;
/** 图片帖子中间的内容 */
@property (weak, nonatomic) JMHTopicPictureView *pictureView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak) JMHTopicVideoView *videoView;

/** 最热评论框架 **/
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtViewContentLabel;

@end
@implementation JMHTopicCell

+ (instancetype)cell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (JMHTopicVideoView *)videoView
{
    if (!_videoView) {
        JMHTopicVideoView *videoView = [JMHTopicVideoView videoView];
        _videoView = videoView;
        [self.contentView addSubview:videoView];
    }
    return _videoView;
    
}
- (JMHTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        JMHTopicVoiceView *voiceView = [JMHTopicVoiceView voiceView];
        _voiceView = voiceView;
        [self.contentView addSubview:voiceView];
    }
    return _voiceView;
}
- (JMHTopicPictureView *)pictureView
{
    if (!_pictureView) {
       JMHTopicPictureView *pictureView = [JMHTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTopic:(JMHTopic *)topic
{
    _topic = topic;
    
    
    // 设置头像
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    // 设置昵称
    self.name.text = topic.name;
    
    // 设置帖子创建时间
    self.create_time.text = topic.create_time;
    
    
    // 设置按键文字
    [self setupButtonTitle:self.ding count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.cai count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repost count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.comment count:topic.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topic.text;

    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == JMHTopicTypePicture) {
        self.pictureView.hidden = NO;
        
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureFrame;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    }else if (topic.type == JMHTopicTypeVoice){
        self.voiceView.hidden = NO;
        
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden= YES;
        
    }else if (topic.type == JMHTopicTypeVideo){
        self.videoView.hidden = NO;
        
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }
    
    // 处理最热评论

    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtViewContentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
    }else{
        self.topCmtView.hidden= YES;
        
    }

}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
