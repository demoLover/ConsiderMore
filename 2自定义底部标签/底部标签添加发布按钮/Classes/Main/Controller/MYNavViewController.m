//
//  MYNavViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/23.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYNavViewController.h"

@interface MYNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation MYNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 拿到右滑返回手势指示器，并设置代理
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置全局返回按钮
    //跟控制器不设置，此时还未push,所以子控制器为0，大于等于1，就不是根控制器了
    if (self.childViewControllers.count >= 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [button setTitle:@"返回" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //push隐藏标签条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //必须调用父类的push方法，负责根控制器都push不了
    [super pushViewController:viewController animated:YES];
}

#pragma mark 代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //根控制器也开始手势会造成程序假死
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    
    return YES;
}
@end
