//
//  MYFoucsViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/23.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYFoucsViewController.h"
#import "MYSugessionViewController.h"
#import "MYLoginRegistViewController.h"

@interface MYFoucsViewController ()

@end

@implementation MYFoucsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //设置导航栏
    [self setupNavgationBar];
}

/*************** 设置导航栏 ***************/
- (void)setupNavgationBar
{
    //标题
    self.navigationItem.title = @"关注";
    //中间
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(leftBtnClick)];
}
/*************** 设置导航栏 ***************/


/*************** 按钮点击 ***************/
- (void)leftBtnClick
{
    MYSugessionViewController *sugVC = [[MYSugessionViewController alloc] init];
    
    [self.navigationController pushViewController:sugVC animated:YES];
}
/*************** 按钮点击 ***************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登录按钮
- (IBAction)loginRefist {
    MYLoginRegistViewController *logVC = [[MYLoginRegistViewController alloc] init];
    
    [self presentViewController:logVC animated:YES completion:nil];
}


@end
