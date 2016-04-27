//
//  MYADViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "MYADItem.h"
#import "MYViewController.h"

#define MYCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"


@interface MYADViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *lauchScreenImage;
@property (weak, nonatomic) IBOutlet UIImageView *adView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
//模型
@property (nonatomic, strong) MYADItem *adItem;
//定时器
@property (nonatomic, weak) NSTimer *timer;



@end

@implementation MYADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置启动图片
    [self setupLanchScreenImage];//本质是占位图片
    
    //加载广告数据
    [self loadADData];
    
    //添加定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    self.timer = timer;
}


/*************** 定时器方法 ***************/

- (void)timeChange
{
    static int i = 3;
    
    i--;
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
    
    //时间走完就跳转
    if (i < 0) {
        
        [self jumpBtnClick:nil];
    }
}
/*************** 定时器方法 ***************/


/*************** 设置启动图片 ***************/

//考虑屏幕不同尺寸，做屏幕适配
- (void)setupLanchScreenImage
{
    if (iPhone6P) {
        _lauchScreenImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x.png"];
    } else if (iPhone6) {
        _lauchScreenImage.image = [UIImage imageNamed:@"LaunchImage-800-667h.png"];
    } else if (iPhone5) {
        _lauchScreenImage.image = [UIImage imageNamed:@"LaunchImage-700-568h.png"];
    } else if (iPhone4) {
        _lauchScreenImage.image = [UIImage imageNamed:@"LaunchImage-700.png"];
    }
}
/*************** 设置启动图片 ***************/



/*************** 加载广告数据 ***************/
// 子控件不能点击： 1.子控件有没有尺寸 2.子控件允不允许与用户交互 3.父控件有没有尺寸 4.父控件允不允许与用户交互

// 请求数据 -》 查看接口文档（1.基本url 2.请求参数 3.请求方式） -》 AFN -> 解析数据 -》 设计模型 -》 字典转模型 -》 把模型的内容展示到控件上

- (void)loadADData
{
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //包装请求参数
    NSMutableDictionary *parmarDict = [NSMutableDictionary dictionary];
    parmarDict[@"code2"] = MYCode2;
    
    //发网络请求
    // 加载广告界面 -> 广告数据是活 -》 向服务器请求数据 -> 查看接口文档 -》 验证接口是否正确 -> 解析数据（找出有用的数据）(w_picurl:广告界面,ori_curl:点击广告界面进入网页,w,h)
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parmarDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //得到要转换的字典
        NSDictionary *dict = [responseObject[@"ad"] firstObject];
        
        //转换模型
        MYADItem *adItem = [MYADItem mj_objectWithKeyValues:dict];
        _adItem = adItem;
        
        //创建控件显示图片（代码无法设置xib内控件frame,因为默认有约束，要手动创建）
        UIImageView *adPicView = [[UIImageView alloc] init];
        adPicView.userInteractionEnabled = YES;
        
        if (adItem.w) {//除以一个数要判断这个数不为0
            CGFloat h = MYScreenW / adItem.w * adItem.h;//根据缩放比例求图片高度
            adPicView.frame = CGRectMake(0, 0, MYScreenW, h);
        }
        
        //设置图片
        [adPicView sd_setImageWithURL:[NSURL URLWithString:adItem.w_picurl]];
        [_adView addSubview:adPicView];
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [adPicView addGestureRecognizer:tap];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*************** 加载广告数据 ***************/



/*************** 手势方法 ***************/
- (void)tap
{
    //url
    NSURL *url = [NSURL URLWithString:_adItem.ori_curl];
    //跳转
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
        
    }
}
/*************** 手势方法 ***************/


/*************** 按钮点击 ***************/
- (IBAction)jumpBtnClick:(id)sender {
    
    //跳转
    MYKeyWindow.rootViewController = [[MYViewController alloc] init];
    
    //关闭定时器
    [self.timer invalidate];
}

/*************** 按钮点击 ***************/
@end
