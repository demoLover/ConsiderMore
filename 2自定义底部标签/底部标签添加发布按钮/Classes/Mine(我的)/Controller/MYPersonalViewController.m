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
#import "MYPersenalCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "MYExcelItem.h"


static NSString * const ID = @"cell";
static float const margin = 1;
static NSInteger const cols = 4;
#define wh ((MYScreenW - (cols - 1) * margin ) / cols)

@interface MYPersonalViewController ()<UICollectionViewDataSource>
//底部视图
@property (nonatomic, weak) UICollectionView *footView;
//模型数组
@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation MYPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //设置导航栏
    [self setupNavgationBar];
    
    //设置fooerView
    [self setupFooterView];
    
    //请求数据
    [self loadData];
    
    //调整组间距
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    //静态cell在导航控制器中会多25（自动内缩会在原来的基础上进行）
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

/*************** 加载数据 ***************/
- (void)loadData
{
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //包装参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";

    //发送请求
    [manager GET:MYBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取字典数组
        NSArray *arr = responseObject[@"square_list"];
        self.itemArray = [MYExcelItem mj_objectArrayWithKeyValuesArray:arr];
        
        //为了解决空缺的格子，重新给数组加空模型
        [self resolveData];
        
        //根据内容修改collectionView的高度
        NSInteger rows = (self.itemArray.count - 1)/ cols + 1;
        
        CGFloat h = rows * wh;
        self.footView.my_height = h;
        //修改了控件高度，要重新设置回去（相当于刷新）
        self.tableView.tableFooterView = self.footView;
        
        //刷新表格
        [self.footView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/*************** 加载数据 ***************/




/*************** 重新处理数据，处理空缺的格子 ***************/
- (void)resolveData
{
    //求空缺格子数
    NSInteger extre = cols - self.itemArray.count % cols;
    
    for (NSInteger i = 0; i < extre; i ++) {
        MYExcelItem *nilItem = [[MYExcelItem alloc] init];
        [self.itemArray addObject:nilItem];
    }
}
/*************** 重新处理数据，处理空缺的格子 ***************/


/*************** 设置底部视图 ***************/
//底部视图添加collection
- (void)setupFooterView
{
    //创建布局参数
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(wh, wh);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    //创建collectionView
    UICollectionView *footerView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    self.footView = footerView;
    footerView.backgroundColor = self.tableView.backgroundColor;

    footerView.dataSource = self;
    footerView.bounces = NO;
    //注册cell
    [footerView registerNib:[UINib nibWithNibName:@"MYPersenalCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    //设置底部视图
    self.tableView.tableFooterView = footerView;
}
/*************** 设置底部视图 ***************/

#pragma mark dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYPersenalCell *cell = [self.footView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.itemArray[indexPath.row];
    return cell;
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
