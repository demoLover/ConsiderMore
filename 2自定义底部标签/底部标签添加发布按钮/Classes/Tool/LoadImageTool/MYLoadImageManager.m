//
//  MYLoadImageManager.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYLoadImageManager.h"

@implementation MYLoadImageManager

//将完成后定义为一个block参数，具体做什么由外界决定
+ (void)my_setImageWithURL:(NSString *)urlString placeholderImage:(UIImage *)placeholder imageView:(UIImageView *)imageView progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock
{
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
    
    if (cacheImage) {//有值，给控件赋值（发现没有，就用参数传进来）
        imageView.image = cacheImage;
    } else {//没有就下载
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
    }
}

@end
