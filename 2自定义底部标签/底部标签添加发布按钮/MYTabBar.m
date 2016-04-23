//
//  MYTabBar.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/23.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYTabBar.h"
#import "MYPresentViewController.h"

@interface MYTabBar()

//发不按钮
@property (nonatomic, weak) UIButton *publishBtn;

@end

@implementation MYTabBar

- (UIButton *)publishBtn
{
    if (_publishBtn == nil) {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [publishBtn addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;
    }
    
    return _publishBtn;
}


/*************** 布局子控件 ***************/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //定义按钮宽高
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    CGFloat buttonX = 0;
    
    int index = 0;
    
    //遍历子控件，排除不是按钮的
    for (UIView *subView in self.subviews) {
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        
        int i = index > 1 ? (index + 1) : index;
        
        buttonX = i * buttonW;
        
        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index ++;
    }
    
    //设置发布按钮位置
    self.publishBtn.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}
/*************** 布局子控件 ***************/



#pragma mark 监听点击

- (void)publishBtnClicked
{
    
    
}
@end
