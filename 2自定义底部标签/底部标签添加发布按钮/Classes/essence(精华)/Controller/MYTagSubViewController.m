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
#import <SVProgressHUD/SVProgressHUD.h>

@interface MYTagSubViewController ()

//模型数组
@property (nonatomic, strong) NSArray *tagItemArray;

//会话管理者
@property (nonatomic, weak) AFHTTPSessionManager *manger;


@end


/*
 关于tabviewCell
 cell的尺寸和位置是tableview决定的，在显示之前有行数，行高等确定好
 cell在显示之前，会将位置和尺寸计算好，保存到数组中，显示的时候调用setFrame方法。cell.frame = self.frames[0];
 重写cell的setFrame可以重写设置cell的高度
 
 修改cell分割线（让cell高度减小，显示背景色）
 步骤：1.取消系统的分割线
      2.设置cell背景色为分割线颜色
       3、setFrame中减小cell高度
 
 */
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
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置cell背景色
    self.tableView.backgroundColor = MYColor(206, 206, 206);
}




/*************** 加载数据 ***************/
- (void)loadData
{
    //加载数据就弹窗提醒用户正在加载数据
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    
    //创建会话管理者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    _manger = manger;
    
    //保证请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"tag_recommend";
    dict[@"c"] = @"topic";
    dict[@"action"] =  @"sub";
    
    //发送请求
    [manger GET:MYBaseUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //数据加载完成就隐藏弹窗
        [SVProgressHUD dismiss];
        
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/admin/Desktop/123.plist" atomically:YES];
        
        self.tagItemArray = [MYTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //失败也隐藏弹窗
        [SVProgressHUD dismiss];
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
    return 85;
}



/*************** 页面将要消失时隐藏弹窗，取消请求 ***************/
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //隐藏弹窗
    [SVProgressHUD dismiss];
    
    //取消请求
    [_manger.tasks makeObjectsPerformSelector:@selector(cancel)];
}
/*************** 页面将要消失时隐藏弹窗，取消请求 ***************/
@end
