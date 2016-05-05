//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by xmg on 16/4/25.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

// 返回一张没有被渲染的图片
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    // 返回一张原始图片给你
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
