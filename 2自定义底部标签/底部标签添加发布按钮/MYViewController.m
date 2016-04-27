//
//  MYViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/23.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYViewController.h"
#import "MYTabBar.h"

#import "MYEssenceViewController.h"
#import "MYNewViewController.h"
#import "MYFoucsViewController.h"
#import "MYPersonalViewController.h"

#import "MYNavViewController.h"


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
    
    MYEssenceViewController *vc1 = [[MYEssenceViewController alloc] init];

    [self setupOneChildController:vc1 title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    
    //新帖
    MYNewViewController *vc2 = [[MYNewViewController alloc] init];

    [self setupOneChildController:vc2 title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    
    //关注
    MYFoucsViewController *vc4 = [[MYFoucsViewController alloc] init];

    [self setupOneChildController:vc4 title:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    
    //我的
    MYPersonalViewController *vc5 = [[MYPersonalViewController alloc] init];
    [self setupOneChildController:vc5 title:@"我的" image:[UIImage imageNamed:@"tabBar_me_icon"] selImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    

    
}


//添加一个控制器

- (void)setupOneChildController:(UIViewController *)viewController title:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage
{
    
    MYNavViewController *nav = [[MYNavViewController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];

    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selImage;

}





@end
