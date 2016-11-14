//
//  JMHTopic.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/15.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHTopic.h"
#import "JMHComment.h"
#import "JMHUser.h"


@implementation JMHTopic
{
    CGRect _pictureFrame;
}
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"top_cmt" : @"JMHComment"};
}
- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * 10, MAXFLOAT);

        // 计算文字高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // cell 的高度
        _cellHeight = textH + 44 + 55 + 2 * JMHTopicCellMargin;
        if (self.type == JMHTopicTypePicture) {

            // 图片宽度
            CGFloat w = maxSize.width;
            // 图片高度
            CGFloat h = self.height * w / self.width;

            if (h > XMGTopicCellPictureMaxH) {
                self.bigPicture = YES;
                h = JMHTopicCellPictureBreakH;
                
            }
            CGFloat x = JMHTopicCellMargin;
            CGFloat y = 55 + JMHTopicCellMargin + textH;
            _pictureFrame = CGRectMake(x, y, w, h);
            _cellHeight += h + JMHTopicCellMargin;
        }else if (self.type == JMHTopicTypeVoice){
           
            // 图片宽度
            CGFloat w = maxSize.width;
            // 图片高度
            CGFloat h = self.height * w / self.width;
            
            CGFloat x = JMHTopicCellMargin;
            CGFloat y = 55 + JMHTopicCellMargin + textH;
            _voiceFrame = CGRectMake(x, y, w, h);
            _cellHeight += h + JMHTopicCellMargin;
        }else if (self.type == JMHTopicTypeVideo){
            
            // 图片宽度
            CGFloat w = maxSize.width;
            // 图片高度
            CGFloat h = self.height * w / self.width;
            
            CGFloat x = JMHTopicCellMargin;
            CGFloat y = 55 + JMHTopicCellMargin + textH;
            _videoFrame = CGRectMake(x, y, w, h);
            _cellHeight += h + JMHTopicCellMargin;
        }
        // 处理最热评论

        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            
            _cellHeight += contentH + JMHTopicCellMargin + 20;
            
        }
   
    }
    return _cellHeight;
}

/** 图片控件的frame */


@end
