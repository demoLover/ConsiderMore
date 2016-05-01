//
//  MYBaseMenusViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYBaseMenusViewController.h"


static NSString *ID = @"essence";
@interface MYBaseMenusViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
//底部view
@property (nonatomic, weak) UICollectionView *cotentView;
//顶部view
@property (nonatomic, weak) UIScrollView *topView;

//按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;

//选中按钮
@property (nonatomic, weak) UIButton *selcteBtn;

//底部选中条
@property (nonatomic, weak) UIView *underView;

//记录是否初始化
@property (nonatomic, assign) BOOL isIntial;

@end

@implementation MYBaseMenusViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加底部View,用collectionview，因为scrollview无法实现循环利用做优化（渲染优化）
    [self setupCotentView];
    
    //添加顶部view
    [self setupTopView];
   
    
    //关闭自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
}


/*************** 添加标题按钮 ***************/
//添加标题按钮要在添加子控制器之后，为了防止外界使用顺序错误，就将其写在viewdidload之后执行的方法中
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //按钮只添加一次，定义属性，记录是否添加，添加了，就不再添加，不能用一次性方法
    if (self.isIntial == NO) {
        [self setupAllTitleButton];
    }
    
    self.isIntial = YES;
}
/*************** 添加标题按钮 ***************/




/*************** 懒加载数组 ***************/
- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
/*************** 懒加载数组 ***************/


/*************** 添加底部view ***************/
- (void)setupCotentView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MYScreenW, MYScreenH);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.cotentView = collectionView;
    
    collectionView.backgroundColor = [UIColor greenColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}
/*************** 添加底部view ***************/




/*************** 添加顶部view ***************/
#pragma mark 添加顶部view
- (void)setupTopView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.topView = scrollView;
    
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    CGFloat x = 0;
    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
    CGFloat w = MYScreenW;
    CGFloat h = 35;
    scrollView.frame = CGRectMake(x, y, w, h);
    
    [self.view addSubview:scrollView];
}
/*************** 添加顶部view ***************/






/*************** 添加标题按钮 ***************/
- (void)setupAllTitleButton
{
    NSInteger count = self.childViewControllers.count;
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.topView.my_width / count;
    CGFloat buttonH = self.topView.my_height;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        NSString *title = self.childViewControllers[i].title;
        [button setTitle:title forState:UIControlStateNormal];
        //设置颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        //监听点击
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.topView addSubview:button];
        
        [self.btnArray addObject:button];
        
        //默认选中第一个
        if (i == 0) {
            [self selectedButton:button];
            
            //添加底部的选中条
            UIView *underView = [[UIView alloc] init];
            
            underView.backgroundColor = [UIColor redColor];
            underView.my_height = 2;
            underView.my_width = [title sizeWithFont:[UIFont systemFontOfSize:15]].width;
            underView.my_y = self.topView.my_height - underView.my_height;
            underView.my_centerX = button.my_centerX;
            self.underView = underView;
            
            [self.topView addSubview:underView];
            
        }
    }
}
/*************** 添加标题按钮 ***************/



/*************** 按钮点击 ***************/
- (void)btnClicked:(UIButton *)button
{
    NSInteger i = button.tag;
    //选中按钮
    [self selectedButton:button];
    //collectionview滚动
    self.cotentView.contentOffset = CGPointMake(i * MYScreenW, 0);
    
    /*
     问题：点击标题，拿不到cell，返回cell方法根本就没有调用
     分析：返回cell方法为什么没有调用 因为没有滚动
     即使滚动了 也拿不到，contentOffset 延迟 ，并不是马上滚动。
     
     */
}
/*************** 按钮点击 ***************/





/*************** 按钮选中 ***************/
- (void)selectedButton:(UIButton *)button
{
    self.selcteBtn.selected = NO;
    button.selected = YES;
    self.selcteBtn = button;
    
    //移动底部选中条
    [UIView animateWithDuration:0.25 animations:^{
        self.underView.my_centerX = button.my_centerX;
    }];
}
/*************** 按钮选中 ***************/







#pragma mark - collectionview data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.cotentView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //在cell即将出现的时候就添加子控制器的view，在添加一个新的view，就要将之前的移除，否则屏幕上会有多个，被渲染，浪费内存
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //添加子控制view
    UIViewController *vc = self.childViewControllers[indexPath.row];
    //在讲子控件添加到cell之前，一定要先设置尺寸和位置。否则会y = 20;
    vc.view.frame = CGRectMake(0, 0, MYScreenW, MYScreenH);
    [cell.contentView addSubview:vc.view];
    
    return cell;
}



#pragma mark 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / MYScreenW;
    
    //选中对应标题按钮
    [self selectedButton:self.btnArray[i]];
}
@end
