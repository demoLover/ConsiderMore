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
#import "MYFooterRefreshView.h"
#import "MYheaderView.h"

@interface MYAllViewController ()
//模型数组
//@property (nonatomic, strong) NSMutableArray *itemArray;

//视图模型数组
@property (nonatomic, strong) NSMutableArray *themeVMArrar;

@property (nonatomic, strong) MYFooterRefreshView *footerView;

//加载数据参数
@property (nonatomic, strong) NSNumber *maxtime;
@property (nonatomic, strong) MYheaderView *headerView;

//会话管理者，为了解决冲突
@property (nonatomic, strong) AFHTTPSessionManager *manager;

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
    [self loadNewData];
    
    //取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加下拉刷新界面
    [self setupFooterRefreshView];
    //添加下拉刷新
    [self setupHeaderView];
}


/*************** 下拉刷新 ***************/

- (void)setupHeaderView
{
    MYheaderView *headerView = [MYheaderView headerView];
    _headerView = headerView;
    CGFloat h = 44;
    //添加到内容上面，y为负值
    headerView.frame = CGRectMake(0, -h, MYScreenW, h);
    
    [self.tableView addSubview:headerView];
}
/*************** 下拉刷新 ***************/



/*************** 创建上啦刷新view ***************/

- (void)setupFooterRefreshView
{
    MYFooterRefreshView *footerView = [MYFooterRefreshView footerView];
    
    _footerView = footerView;
    
    footerView.frame = CGRectMake(0, 0, MYScreenW, 44);
    self.tableView.tableFooterView = footerView;
    
    //判断是否显示，有数据就显示
    footerView.hidden = !self.themeVMArrar.count;
}
/*************** 创建上啦刷新view ***************/

/*************** 请求数据 ***************/
- (void)loadNewData
{
    //取消所有任务
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //获取会话管理者
    _manager = [AFHTTPSessionManager manager];
    //拼接参数
    NSMutableDictionary *pramaters = [NSMutableDictionary dictionary];
    pramaters[@"a"] = @"list";
    pramaters[@"c"] = @"data";
    pramaters[@"type"] = @"1";

    //发送请求并解析数据
    [_manager GET:MYBaseUrl parameters:pramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/admin/Desktop/123.plist" atomically:YES];
        NSArray *dictArr = responseObject[@"list"];
        
        //恢复isloading为no
        _headerView.isLoading = NO;
        //恢复原来的额外显示区域
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(64 + 44, 0, 49, 0);
        }];
        
        _headerView.hidden = YES;
        
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
        
        //判断是否显示，有数据就显示,加载完成再判断
        _footerView.hidden = !self.themeVMArrar.count;
        
        _maxtime = responseObject[@"info"][@"maxtime"];//给请求参数赋值
        
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/*************** 请求数据 ***************/



/*************** 监听滚动 ***************/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self dealHeaderView];
    
    [self dealFooterView];
}
/*************** 监听滚动 ***************/


/*************** 上拉业务处理 ***************/
- (void)dealFooterView
{
    //获取当前偏移量
    CGFloat offsetY = self.tableView.contentOffset.y;
    
    //计算最大偏移量
    CGFloat maxOffsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - MYScreenH;
    
    if (_footerView.isLoading) return;//正在刷新就返回
    
    //偏移量大于最大偏移量就开始刷新数据
    if (offsetY > maxOffsetY) {
        //显示加载页面（根据isloadingset方法中设置）
        
        //加载数据
        [self loadMoreData];
    }

}
/*************** 上拉业务处理 ***************/



/*************** 下拉刷新业务 ***************/

- (void)dealHeaderView
{
    CGFloat offsetY = self.tableView.contentOffset.y;
    
    CGFloat minOffsetY =  -(self.tableView.contentInset.top + _headerView.my_height);
    
    //控制文字和图片
    if (offsetY<= minOffsetY) {
        _headerView.isVisable = YES;
    } else {
        _headerView.isVisable = NO;
    }
}
/*************** 下拉刷新业务 ***************/



/*************** 开始拖拽 ***************/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _headerView.hidden = NO;
}
/*************** 开始拖拽 ***************/


/*************** 松手 ***************/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //
    CGFloat offsetY = self.tableView.contentOffset.y;
    
    CGFloat minOffsetY =  -(self.tableView.contentInset.top + _headerView.my_height);
    
    //让空间显示当前位置，通过额外显示区域实现，加载数据
    if (offsetY<= minOffsetY) {
        _headerView.isLoading = YES;
        
        //显示当前位置
        CGFloat top = self.tableView.contentInset.top + _headerView.my_height;
        CGFloat bottom = self.tableView.contentInset.bottom;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
        }];
        
        //加载数据
        [self loadNewData];
    }
}
/*************** 松手 ***************/

/*************** 加载更多数据 ***************/
- (void)loadMoreData
{
    //取消请求
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //开始设置isloading
    _footerView.isLoading = YES;
    //获取会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //拼接参数
    NSMutableDictionary *pramaters = [NSMutableDictionary dictionary];
    pramaters[@"a"] = @"list";
    pramaters[@"c"] = @"data";
    pramaters[@"type"] = @"1";
    pramaters[@"maxtime"] = _maxtime;
    
    //发送请求并解析数据
    [_manager GET:MYBaseUrl parameters:pramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        
        //刷新数据
        [self.tableView reloadData];
        //给数组添加数据
        [self.themeVMArrar addObjectsFromArray:tempArray];
        
     //在此修改刚刚返回的参数，以备下次刷新使用
        _maxtime = responseObject[@"info"][@"maxtime"];//给请求参数赋值
        
        _footerView.isLoading = NO;
        
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
