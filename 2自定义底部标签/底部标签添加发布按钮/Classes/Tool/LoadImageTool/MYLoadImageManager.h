//
//  MYLoadImageManager.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 程涛. All rights reserved.
//


/*
 以后加载图片都用这个类
 */
#import <Foundation/Foundation.h>
#import <UIImageView+WebCache.h>



@interface MYLoadImageManager : NSObject
/**
 *  下载图片，自动缓存，监听进度，完成后可操作
 *
 *  @param urlString      图片网址
 *  @param placeholder    占位图片
 *  @param imageView      图片控件
 *  @param progressBlock  监听进度block
 *  @param completedBlock 下载完成block
 */
+ (void)my_setImageWithURL:(NSString *)urlString placeholderImage:(UIImage *)placeholder imageView:(UIImageView *)imageView progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

@end
