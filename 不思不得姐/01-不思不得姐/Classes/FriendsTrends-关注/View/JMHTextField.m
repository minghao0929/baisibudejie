//
//  JMHTextField.m
//  01-不思不得姐
//
//  Created by Minghao on 16/8/11.
//  Copyright © 2016年 Minghao. All rights reserved.
//

#import "JMHTextField.h"
#import <objc/runtime.h>

@implementation JMHTextField

static NSString * const JMHPlacerholderColorKeypath = @"_placeholderLabel.textColor";
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];

}

+ (void)getIvar
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        
        NSLog(@"%s--%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
}

+ (void)getProperties
{
    unsigned int count = 0;
    objc_property_t *properties = class_getProperty([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        
        // 取出属性
        objc_property_t property = properties[i];
        
        // 打印属性名字
        NSLog(@"%s   <---->   %s",property_getName(property),property_getAttributes(property));
    }
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:JMHPlacerholderColorKeypath];
    
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:JMHPlacerholderColorKeypath];
    
    return [super resignFirstResponder];
}

@end
