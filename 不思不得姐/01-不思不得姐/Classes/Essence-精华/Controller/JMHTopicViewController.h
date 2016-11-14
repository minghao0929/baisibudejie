//
//  JMHTopicViewController.h
//  01-不思不得姐
//
//  Created by Minghao on 16/8/16.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum{
//    JMHTopicTypeAll = 1,
//    JMHTopicTypePicture = 10,
//    JMHTopicTypeWord = 29,
//    JMHTopicTypeVoice = 31,
//    JMHTopicTypeVideo = 41
//} JMHTopicType;
@interface JMHTopicViewController : UITableViewController

/** 帖子的类型(交给子类去实现) **/
@property (assign, nonatomic) JMHTopicType type;

@end
