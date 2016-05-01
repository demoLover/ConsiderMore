//
//  MYEssenceViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/23.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYEssenceViewController.h"
#import "MYTagSubViewController.h"

#import "MYAllViewController.h"
#import "MYVideoViewController.h"
#import "MYVoiceViewController.h"
#import "MYPictureTableViewController.h"
#import "MYTextViewController.h"


@interface MYEssenceViewController ()

@end

@implementation MYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    //设置导航条内容
    [self setupNavgationBar];
    
    
    //添加所有子控制器
    [self setupAllChildController];
    
}



/*************** 添加所有子控制器 ***************/
- (void)setupAllChildController
{
    //全部
    MYAllViewController *allVC = [[MYAllViewController alloc] init];
    allVC.title = @"全部";
    [self addChildViewController:allVC];
    
    
    //视频
    MYVideoViewController *videoVC = [[MYVideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    //声音
    MYVoiceViewController *voiceVC = [[MYVoiceViewController alloc] init];
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
    
    //图片
    MYPictureTableViewController *picVC = [[MYPictureTableViewController alloc] init];
    picVC.title = @"图片";
    [self addChildViewController:picVC];
    
    //段子
    MYTextViewController *textVC = [[MYTextViewController alloc] init];
    textVC.title = @"段子";
    [self addChildViewController:textVC];
}
/*************** 添加所有子控制器 ***************/






/*************** 设置导航条内容 ***************/
- (void)setupNavgationBar
{
    //背景颜色
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    //中间标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左边按钮

    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(leftBtnClick)];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highlightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(randomClicked)];
}
/*************** 设置导航条内容 ***************/


/*************** 左按钮点击 ***************/
- (void)leftBtnClick
{
    MYTagSubViewController *tagVC = [[MYTagSubViewController alloc] init];
    
    [self.navigationController pushViewController:tagVC animated:YES];
}
/*************** 左按钮点击 ***************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*************** 右边按钮点击 ***************/
- (void)randomClicked
{
    
}
/*************** 右边按钮点击 ***************/

@end
