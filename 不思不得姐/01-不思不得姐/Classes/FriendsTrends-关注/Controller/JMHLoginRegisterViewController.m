//
//  JMHLoginRegisterViewController.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/11.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHLoginRegisterViewController.h"

@interface JMHLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *loginRigisterBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation JMHLoginRegisterViewController

- (IBAction)back {
    NSLog(@"click");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)button
{
    [self.view endEditing:YES];
    if (self.loginViewLeftMargin.constant == 0) {// 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
    }else{
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view insertSubview:self.loginRigisterBg atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
