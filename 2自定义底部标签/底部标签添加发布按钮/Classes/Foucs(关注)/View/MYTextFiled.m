//
//  MYTextFiled.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYTextFiled.h"

@implementation MYTextFiled

- (void)awakeFromNib
{
    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    //设置占位文字方法（方法一：利用系统的富文本属性，设置带有格式的文字作为占位文字）
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
//    self.attributedPlaceholder = str;
    
    //分类设置颜色，运行时
    self.placeholderColor = [UIColor lightGrayColor];
    
    //监听文本框（代理（自己做自己的代理不好）、通知（麻烦）、target）
    [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd];
}


/*************** 开始编辑 ***************/
- (void) editBegin
{
    //占位文字变白色
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    
//    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
//    self.attributedPlaceholder = str;
    
    self.placeholderColor = [UIColor whiteColor];
}
/*************** 开始编辑 ***************/


/*************** 结束编辑 ***************/
- (void) editEnd
{
    //占位文字灰色
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
//    self.attributedPlaceholder = str;
    
    self.placeholderColor = [UIColor lightGrayColor];
}
/*************** 结束编辑 ***************/




@end
