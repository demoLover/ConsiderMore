//
//  MYBaseView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYBaseView.h"

@implementation MYBaseView

//有的图形乱了，是因为自动缩放的关系
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}


+ (instancetype)viewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
