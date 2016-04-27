//
//  MYPersonalViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/23.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYPersonalViewController.h"
#import "MYSettingViewController.h"
#import "MYCoinViewController.h"

@interface MYPersonalViewController ()

@end

@implementation MYPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    //设置导航栏
    [self setupNavgationBar];
}


/*************** 设置导航栏 ***************/
- (void)setupNavgationBar
{
    //标题
    self.navigationItem.title = @"我的";
    
    //左边

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_coin_icon"] highlightImage:[UIImage imageNamed:@"nav_coin_icon_click"] target:self action:@selector(leftBtnClick)];
    
    //右边 设置
 
    UIBarButtonItem *item0 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setBtnClick)];
    
    //右边 月亮
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonBtnClick:)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item0];

}
/***************  设置导航栏  ***************/

/*************** 左按钮点击 ***************/

- (void)leftBtnClick
{
    MYCoinViewController *coinVC = [[MYCoinViewController alloc] init];
    
    [self.navigationController pushViewController:coinVC animated:YES];
}
/*************** 左按钮点击 ***************/


/*************** 设置按钮点击 ***************/
- (void)setBtnClick
{
    MYSettingViewController *setVC = [[MYSettingViewController alloc] init];
    
    [self.navigationController pushViewController:setVC animated:YES];
    
}
/*************** 设置按钮点击 ***************/

/*************** 月亮点击 ***************/
- (void)moonBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
}
/*************** 月亮点击 ***************/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
