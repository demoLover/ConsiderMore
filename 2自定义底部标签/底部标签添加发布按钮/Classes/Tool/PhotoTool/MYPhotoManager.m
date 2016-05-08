//
//  MYPhotoManager.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/8.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYPhotoManager.h"
#import <Photos/Photos.h>

@implementation MYPhotoManager


//获取已有相册
- (PHAssetCollection *)getAssetCollection:(NSString *)title
{
    //获取系统相册结构集
    PHFetchResult *results =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //遍历，判断
    for (PHAssetCollection *assetCollection in results) {
        if ([assetCollection.localizedTitle isEqualToString:title]) {
            return assetCollection;
        }
    }
    return nil;
}



+(void)addImage:(UIImage *)image toAlbum:(NSString *)albumTitle completionHandler:(void (^)(BOOL, NSError *))completionHandler
{
    //获取相簿
    PHPhotoLibrary *lib = [PHPhotoLibrary sharedPhotoLibrary];
    
    //自定义相册必须在下列方法中
    [lib performChanges:^{
        //1自定义相册
        PHAssetCollectionChangeRequest *createAssetRequest;
        //先去取，已经有就不创建，用取到的，没有就创件
        PHAssetCollection *assetCollection = [self getAssetCollection:albumTitle];
        
        if (assetCollection) { //已有相册，
            createAssetRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else { //没有就自定义
            createAssetRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        
        
        // 2、创建图片请求对象
        PHAssetChangeRequest *assetRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:image];
        
        // 3/图片请求添加到相册
        [createAssetRequest addAssets:@[assetRequest.placeholderForCreatedAsset]];
        
    } completionHandler:completionHandler];

}




@end
