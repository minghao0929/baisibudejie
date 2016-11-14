//
//  JMHPublishViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/22.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHPublishViewController.h"
#import "JMHVerticalButton.h"
#import "POP.h"


@interface JMHPublishViewController ()

//@property (nonatomic, copy) void (^completionBlock)();
@end

@implementation JMHPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupButton];
}

- (void)setupButton
{
    self.view.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    
    CGFloat buttonStartX = 20;
    CGFloat buttonStartY = - (2 * buttonH);
//    CGFloat buttonStartY = 50;
    CGFloat marginX = (JMHScreenW - (2 * buttonStartX + maxCols * buttonW)) / (maxCols - 1);

    
    for (int i = 0; i < images.count; i++) {
        JMHVerticalButton *button = [JMHVerticalButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
        [button setTitle:titles[i] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:button];
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        
        CGFloat buttonEndX = buttonStartX + (buttonW + marginX) * col;
        CGFloat buttonEndY = (JMHScreenH - 2 * buttonH) * 0.5 + buttonH * row ;
       
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonStartX, buttonStartY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonEndX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 10;
        anim.springSpeed = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        
        [button pop_addAnimation:anim forKey:nil];
        
    }
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    
    CGFloat sloganW = 202;
    CGFloat sloganH = 20;
    CGFloat sloganStartX = (JMHScreenW - sloganW) * 0.5;
    CGFloat sloganStartY = -20;
    
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(sloganStartX, sloganStartY, sloganW, sloganH)];
    CGFloat sloganEndY = JMHScreenH * 0.2;
    
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(sloganStartX, sloganEndY, sloganW, sloganH)];
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    
    [sloganView pop_addAnimation:anim forKey:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick:(UIButton *)button
{
    [self cancleWithCompletionBlock:^{
    }];
}
- (IBAction)cancle:(id)sender {
    [self cancleWithCompletionBlock:nil];
}

- (void)cancleWithCompletionBlock:(void(^)())completionBlock
{
    
    NSInteger index = 2;
    for (NSInteger i = index; i < self.view.subviews.count; i ++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        CGFloat endY = subview.y + JMHScreenH;
        
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(subview.x, endY, subview.width, subview.height)];
        anim.beginTime = CACurrentMediaTime() + (i - index) * 0.1;
        
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1 ) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                
                [self dismissViewControllerAnimated:NO completion:nil];
                
                                !completionBlock ? : completionBlock();
            }];
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancleWithCompletionBlock:nil];
}
/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
