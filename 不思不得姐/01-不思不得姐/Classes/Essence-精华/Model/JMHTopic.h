//
//  JMHTopic.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/15.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMHComment;

@interface JMHTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 **/
@property (copy, nonatomic) NSString *name;
/** 头像 **/
@property (copy, nonatomic) NSString *profile_image;
/** 发帖时间 **/
@property (copy, nonatomic) NSString *create_time;
/** 文字内容 **/
@property (copy, nonatomic) NSString *text;
/** 顶的数量 **/
@property (assign, nonatomic) NSInteger ding;
/** 踩的数量 **/
@property (assign, nonatomic) NSInteger cai;
/** 转发的数量 **/
@property (assign, nonatomic) NSInteger repost;
/** 评论的数量 **/
@property (assign, nonatomic) NSInteger comment;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, assign) JMHTopicType type;

/*** 音频属性 ***/
/** 音频时长 */
@property (assign, nonatomic) NSInteger voicetime;
/** 播放次数 */
@property (assign, nonatomic) NSInteger playcount;
/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceFrame;

/*** 视频属性 ***/
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoFrame;


/****** 额外的辅助属性 ******/
/** cell的高度 **/
@property (assign, nonatomic) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureFrame;
/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;


/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 最热评论(期望这个数组中存放的是XMGComment模型) */
@property (nonatomic, strong) JMHComment *top_cmt;

@end
