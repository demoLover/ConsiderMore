//
//  MYTagSubViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYTagSubViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "MYTagItem.h"
#import "MYTagCell.h"

@interface MYTagSubViewController ()

//模型数组
@property (nonatomic, strong) NSArray *tagItemArray;

@end

@implementation MYTagSubViewController

static NSString * const ID = @"tag";
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    self.navigationItem.title = @"推荐订阅";
    
    //加载数据
    [self loadData];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MYTagCell" bundle:nil] forCellReuseIdentifier:ID];
}




/*************** 加载数据 ***************/
- (void)loadData
{
    //创建会话管理者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    //保证请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"tag_recommend";
    dict[@"c"] = @"topic";
    dict[@"action"] =  @"sub";
    
    //发送请求
    [manger GET:MYBaseUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/admin/Desktop/123.plist" atomically:YES];
        
        self.tagItemArray = [MYTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*************** 加载数据 ***************/

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tagItemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建cell
    MYTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    //设置数据
    cell.item = self.tagItemArray[indexPath.row];
    
    return cell;
}



#pragma mark delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
