//
//  MYPhotoManager.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/8.
//  Copyright © 2016年 程涛. All rights reserved.
// 将图片保存到自定义相册的业务类

#import <Foundation/Foundation.h>
@class PHAssetCollection;

@interface MYPhotoManager : NSObject

/**
 *  存入自定义相册
 *
 *  @param image             图片
 *  @param albumTitle        相册名称
 *  @param completionHandler 完成回调
 */
+ (void)addImage:(UIImage *)image toAlbum:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError *error))completionHandler;


/**
 *  获取已有相册
 *
 *  @param title 相册名称
 *
 *  @return 相册
 */
+ (PHAssetCollection *)getAssetCollection:(NSString *)title;
@end
