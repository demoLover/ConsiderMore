//
//  MYViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/23.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYViewController.h"
#import "MYTabBar.h"


#define MYScreenW [UIScreen mainScreen].bounds.size.width

@interface MYViewController ()


@end

@implementation MYViewController






#pragma mark 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //添加所有控制器
    [self setupAllChildController];
    
    //替换tabbar
    [self setValue:[[MYTabBar alloc]init] forKey:@"tabBar"];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateSelected];
}



- (void)setupAllChildController
{
    //精华
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    [self setupOneChildController:vc1 title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    
    //新帖
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor grayColor];
    [self setupOneChildController:vc2 title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    
    //关注
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor blueColor];
    [self setupOneChildController:vc4 title:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    
    //我的
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.view.backgroundColor = [UIColor yellowColor];
    [self setupOneChildController:vc5 title:@"我的" image:[UIImage imageNamed:@"tabBar_me_icon"] selImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    

    
}


//添加一个控制器

- (void)setupOneChildController:(UIViewController *)viewController title:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage
{
    
    [self addChildViewController:viewController];
    
    if (image) {
        
        viewController.tabBarItem.title = title;
        viewController.tabBarItem.image = image;
        viewController.tabBarItem.selectedImage = selImage;
    }
}





@end
