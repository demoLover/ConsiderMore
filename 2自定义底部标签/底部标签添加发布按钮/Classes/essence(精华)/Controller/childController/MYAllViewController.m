//
//  MYAllViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYAllViewController.h"
#import "MYThemeCell.h"
#import <AFNetworking/AFNetworking.h>
#import "MYThemeItem.h"
#import <MJExtension/MJExtension.h>
#import "MYThemeViewModel.h"

@interface MYAllViewController ()
//模型数组
//@property (nonatomic, strong) NSMutableArray *itemArray;

//视图模型数组
@property (nonatomic, strong) NSArray *themeVMArrar;


@end

static NSString * const ID = @"theme";
@implementation MYAllViewController

/*
 cell细节处理
 1.cell间距
 2.cell没有选中样式
 3、cell的背景图片
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MYColor(206, 206, 206);
    //注册cell
    [self.tableView registerClass:[MYThemeCell class] forCellReuseIdentifier:ID];
    
    //设置偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    
    //加载数据
    [self loadData];
    
    //取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/*************** 请求数据 ***************/
- (void)loadData
{
    //获取会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //拼接参数
    NSMutableDictionary *pramaters = [NSMutableDictionary dictionary];
    pramaters[@"a"] = @"list";
    pramaters[@"c"] = @"data";
    pramaters[@"type"] = @"1";

    //发送请求并解析数据
    [manager GET:MYBaseUrl parameters:pramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/admin/Desktop/123.plist" atomically:YES];
        NSArray *dictArr = responseObject[@"list"];
        //转模型数组
        NSArray *themeArray = [MYThemeItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        //模型数组转化为视图模型数组
        NSMutableArray *tempArray = [NSMutableArray array];
        for (MYThemeItem *item in themeArray) {
            //创建视图模型
            MYThemeViewModel *themeVM = [[MYThemeViewModel alloc] init];
            themeVM.item = item; //调用了setitem方法
            [tempArray addObject:themeVM];
        }
        
        self.themeVMArrar = tempArray;
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/*************** 请求数据 ***************/



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.themeVMArrar.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.themeVM = self.themeVMArrar[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.themeVMArrar[indexPath.row] cellH];
}

@end
