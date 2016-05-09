//
//  MYheaderView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYheaderView.h"

@interface MYheaderView ()
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *refreshLabel;

@property (weak, nonatomic) IBOutlet UIImageView *refreshIcon;

@end

@implementation MYheaderView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}


+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setIsLoading:(BOOL)isLoading
{
    _isLoading = isLoading;
    
    _loadingView.hidden = !isLoading;
    
    _refreshIcon.hidden = isLoading;
    _refreshLabel.hidden = isLoading;
}


- (void)setIsVisable:(BOOL)isVisable
{
    _isVisable = isVisable;
    
    if (isVisable == YES) {//修改文字。旋转图片
        _refreshLabel.text = @"松开即可刷新";
        
        [UIView animateWithDuration:0.25 animations:^{
            //不旋转，临界值加一点点
            _refreshIcon.transform = CGAffineTransformMakeRotation(- M_PI + 0.01);
        }];
    } else {
        _refreshLabel.text = @"下拉即可刷新";
        
        [UIView animateWithDuration:0.25 animations:^{
            //不旋转，临界值加一点点
            _refreshIcon.transform = CGAffineTransformIdentity;
        }];

    }
}
@end
