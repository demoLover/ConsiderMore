//
//  MYBaseThemeViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYBaseThemeViewController.h"

#import "MYAllViewController.h"
#import "MYThemeCell.h"
#import <AFNetworking/AFNetworking.h>
#import "MYThemeItem.h"
#import <MJExtension/MJExtension.h>
#import "MYThemeViewModel.h"
#import <MJRefresh/MJRefresh.h>



@interface MYBaseThemeViewController ()
//模型数组
//@property (nonatomic, strong) NSMutableArray *itemArray;

//视图模型数组
@property (nonatomic, strong) NSMutableArray *themeVMArrar;



//加载数据参数
@property (nonatomic, strong) NSNumber *maxtime;


//会话管理者，为了解决冲突
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

static NSString * const ID = @"theme";
@implementation MYBaseThemeViewController

/*
 cell细节处理
 1.cell间距
 2.cell没有选中样式
 3、cell的背景图片
 
 */

//加载控制view先去与控制器同名的storyBoard/xib，没找到就去不带controller的同名storyBoard/xib找，不让系统这么做，就写loadview来自己加载，
- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MYColor(206, 206, 206);
    //注册cell
    [self.tableView registerClass:[MYThemeCell class] forCellReuseIdentifier:ID];
    
    //设置偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    
    //加载数据
    [self loadNewData];
    
    //取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加下拉刷新界面
    [self setupFooterRefreshView];
    //添加下拉刷新
    [self setupHeaderView];
}

//注意：使用MJRefreshNormalHeader框架一定要手动停止
/*************** 下拉刷新 ***************/

- (void)setupHeaderView
{
    //创建控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //设置开始位置透明
    header.automaticallyChangeAlpha = YES;
    
    //添加
    self.tableView.mj_header = header;
}
/*************** 下拉刷新 ***************/



/*************** 创建上啦刷新view ***************/

- (void)setupFooterRefreshView
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    footer.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = footer;
}
/*************** 创建上啦刷新view ***************/

/*************** 请求数据 ***************/
- (void)loadNewData
{
    //取消所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //拼接参数
    NSMutableDictionary *pramaters = [NSMutableDictionary dictionary];
    pramaters[@"a"] = @"list";
    pramaters[@"c"] = @"data";
    pramaters[@"type"] = self.type;
    
    //发送请求并解析数据
    [self.manager GET:MYBaseUrl parameters:pramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/admin/Desktop/123.plist" atomically:YES];
        NSArray *dictArr = responseObject[@"list"];
        
        _maxtime = responseObject[@"info"][@"maxtime"];
        //停止刷新
        [self.tableView.mj_header endRefreshing];
        
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





/*************** 加载更多数据 ***************/
- (void)loadMoreData
{
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //拼接参数
    NSMutableDictionary *pramaters = [NSMutableDictionary dictionary];
    pramaters[@"a"] = @"list";
    pramaters[@"c"] = @"data";
    pramaters[@"type"] = self.type;
    
    
    //发送请求并解析数据
    [self.manager GET:MYBaseUrl parameters:pramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/admin/Desktop/123.plist" atomically:YES];
        NSArray *dictArr = responseObject[@"list"];
        _maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView.mj_footer endRefreshing];
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
        
        //刷新数据
        [self.tableView reloadData];
        //给数组添加数据
        [self.themeVMArrar addObjectsFromArray:tempArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
/*************** 加载更多数据 ***************/


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
