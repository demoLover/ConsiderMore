//
//  MYSettingViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/24.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYSettingViewController.h"

@interface MYSettingViewController ()

@end
static NSString * const ID = @"set";
@implementation MYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = @"清除缓存";
    
    return cell;
}




@end
