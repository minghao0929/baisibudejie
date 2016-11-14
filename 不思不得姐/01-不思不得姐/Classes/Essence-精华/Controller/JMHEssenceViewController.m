//
//  JMHEssenceViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/3.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHEssenceViewController.h"
#import "JMHRecommendTagsViewController.h"
#import "JMHTopicViewController.h"

@interface JMHEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation JMHEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 设置导航栏
    [self setupNav];

    // 初始化子控制器
    [self setupChildVces];
    
    // 设置顶部的标签栏
    [self setupTitlesView];

    // 底部的scrollView
    [self setupContentView];
    
    
}
/**
 * 设置导航栏
 */
- (void)setupNav
{
    // 设置navigation的title图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置navigationItem的leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(mainTagBtnClick)];
    
    // view的背景颜色
    self.view.backgroundColor = JMHGlobalBg;
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // title框架
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, 64, self.view.width, 35);
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(width * i, 0, width, height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];

        [titlesView addSubview:button];
        if (i == 0) {
            self.selectedBtn = button;
            button.enabled = NO;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    button.enabled = NO;
    self.selectedBtn.enabled = YES;
    self.selectedBtn = button;

    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    

}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.pagingEnabled = YES;
    contentView.frame = self.view.bounds;
    contentView.bounces = NO;
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    [self scrollViewDidEndScrollingAnimation:contentView];
}
- (void)mainTagBtnClick
{
    JMHRecommendTagsViewController *vc = [[JMHRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    JMHTopicViewController *allVC = [[JMHTopicViewController alloc]init];
    [self addChildViewController:allVC];
    allVC.type = JMHTopicTypeAll;
    
    JMHTopicViewController *videoVC = [[JMHTopicViewController alloc]init];
    [self addChildViewController:videoVC];
    videoVC.type = JMHTopicTypeVideo;
    
    JMHTopicViewController *voiceVC = [[JMHTopicViewController alloc]init];
    [self addChildViewController:voiceVC];
    voiceVC.type = JMHTopicTypeVoice;
    
    JMHTopicViewController *pictureVC = [[JMHTopicViewController alloc]init];
    [self addChildViewController:pictureVC];
    pictureVC.type = JMHTopicTypePicture;
    
    JMHTopicViewController *wordVC = [[JMHTopicViewController alloc]init];
    [self addChildViewController:wordVC];
    wordVC.type = JMHTopicTypeWord;
}
#pragma mark <>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
 
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0（默认为20）
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度（默认是比屏幕高度少个20）

    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
