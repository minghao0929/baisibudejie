//
//  JMHPushGuideView.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/11.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHPushGuideView.h"

@interface JMHPushGuideView()

@end
@implementation JMHPushGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)button:(id)sender {
    [self removeFromSuperview];
}
+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";

    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        JMHPushGuideView *guideView = [JMHPushGuideView guideView];
        guideView.frame = window.bounds;
        
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
+ (instancetype)guideView
{
        return [[[NSBundle mainBundle] loadNibNamed:@"JMHPushGuideView" owner:nil options:nil] lastObject];
}
@end
