//
//  MYFooterRefreshView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYFooterRefreshView.h"

@interface MYFooterRefreshView ()
@property (weak, nonatomic) IBOutlet UIView *loadingView;

@end

@implementation MYFooterRefreshView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)footerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


//重写isloading的set方法，只要外界传值，就设置正在加载界面显示与否
- (void)setIsLoading:(BOOL *)isLoading
{
    _isLoading = isLoading;
    
    //正在加载就显示，加载完成就隐藏
    _loadingView.hidden = !isLoading;
}
@end
