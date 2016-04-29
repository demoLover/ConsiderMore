//
//  MYFastLoginView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYFastLoginView.h"

@implementation MYFastLoginView

+ (instancetype) fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
