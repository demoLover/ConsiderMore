//
//  MYLoginRegistViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYLoginRegistViewController.h"
#import "MYLoginRegistView.h"
#import "MYFastLoginView.h"

@interface MYLoginRegistViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *loginRegistView;
@property (weak, nonatomic) IBOutlet UIView *fastLoginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingMargin;

@end


/*
 xib使用注意点
 1、如果一个控件从xib加载，默认尺寸和xib一样，但添加到父控件身上，一定要再次确定尺寸和位置
 2、在控制器的viewDidLoad中不会执行子控件约束，会在viewDidLayoutSubview中执行，所以应该在该方法中设置从xib加载的子控件的位置和尺寸
 3/xib中的按钮要和xib的button连线
 */
@implementation MYLoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加登录按钮
    MYLoginRegistView *loginView = [MYLoginRegistView loginView];
    [_loginRegistView addSubview:loginView];
    
    //添加注册按钮
    MYLoginRegistView *registView = [MYLoginRegistView registView];
    [_loginRegistView addSubview:registView];
    
    //添加快速登录
    MYFastLoginView *fastView = [MYFastLoginView fastLoginView];
    [self.fastLoginView addSubview:fastView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*************** 执行约束 ***************/
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //登录按钮位置尺寸确定
    MYLoginRegistView *loginView = self.loginRegistView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.loginRegistView.my_width * 0.5, self.loginRegistView.my_height);
    
    //注册
    MYLoginRegistView *registView = self.loginRegistView.subviews[1];
    registView.frame = CGRectMake(MYScreenW, 0, self.loginRegistView.my_width * 0.5, self.loginRegistView.my_height);
    
    //快速登录
    MYFastLoginView *fastView = self.fastLoginView.subviews[0];
    fastView.frame = self.fastLoginView.bounds;
}
/*************** 执行约束 ***************/



/*************** 关闭按钮 ***************/
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*************** 关闭按钮  ***************/


/*************** 注册按钮点击 ***************/
- (IBAction)loginOrRegist:(UIButton *)sender {
    
    //设置按钮状态
    sender.selected = !sender.selected;
    
    //修改约束
    self.leadingMargin.constant = self.leadingMargin.constant == 0 ? -MYScreenW : 0;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        //刷新(强制布局)
        [self.view layoutIfNeeded];
    }];
}

/*************** 注册按钮点击 ***************/




/*************** 关闭键盘 ***************/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
/*************** 关闭键盘 ***************/
@end
