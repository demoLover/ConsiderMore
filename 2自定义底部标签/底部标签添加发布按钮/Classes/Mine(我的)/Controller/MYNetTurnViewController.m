//
//  MYNetTurnViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYNetTurnViewController.h"
#import "MYExcelItem.h"
#import <WebKit/WebKit.h>

@interface MYNetTurnViewController ()
@property (weak, nonatomic) IBOutlet UIView *webview;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

//wkView
@property (nonatomic, weak) WKWebView *wkView;

@end

@implementation MYNetTurnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题

    
    //创建wkwebview
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.webview addSubview:webView];
    self.wkView = webView;
    //webview加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.item.url]];
    
    [webView loadRequest:request];
    
    //使用进度标题属性（kvo）
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}


/*************** 监听属性值变化就会调用 ***************/

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.progressView.progress = self.wkView.estimatedProgress;
    //网页加载完成，隐藏进度条
    self.progressView.hidden = self.wkView.estimatedProgress >= 1;
    
    self.title = self.wkView.title;
}
/*************** 监听属性值变化就会调用 ***************/


/*************** 移除监听者 ***************/
- (void)dealloc
{
    [self.wkView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkView removeObserver:self forKeyPath:@"title"];
}
/*************** 移除监听者 ***************/

//返回
- (IBAction)goBack:(id)sender {
    
    [self.wkView goBack];
}
- (IBAction)goFoward:(id)sender {
    [self.wkView goForward];
}
- (IBAction)refrech:(id)sender {
    [self.wkView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
