//
//  MYSeeBigPictureViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/8.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYSeeBigPictureViewController.h"
#import "MYThemeItem.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <Photos/Photos.h>
#import "MYPhotoManager.h"

@interface MYSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//图片
@property (nonatomic, strong) UIImage *image;

//
@property (nonatomic, weak) UIImageView *imageView;


@end

static NSString * const albumTitle= @"百思不得姐";
@implementation MYSeeBigPictureViewController

//返回
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存照片
- (IBAction)savePicture {
//    //保存到系统相册
//    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //保存到自定义相册
    
    //1.获取相册访问状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized) {
        [MYPhotoManager addImage:_image toAlbum:albumTitle completionHandler:^(BOOL success, NSError *error) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            }
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }

        }]; //允许
    } else if (status == PHAuthorizationStatusNotDetermined) {
        //弹窗提醒
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //完成再判断
            if (status == PHAuthorizationStatusAuthorized) {
                [MYPhotoManager addImage:_image toAlbum:albumTitle completionHandler:^(BOOL success, NSError *error) {
                    if (success) {
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }
                    
                    if (error) {
                        [SVProgressHUD showErrorWithStatus:@"保存失败"];
                    }
                    
                }];
            }
            
        }];
        
    } else { //不允许
        [SVProgressHUD showSuccessWithStatus:@"打开设置，找到应用程序，打开相册，即可存入"];
    }
}

/*
 PHAuthorizationStatusNotDetermined = 0, // 没设置
 PHAuthorizationStatusRestricted,        // 父母控制

 PHAuthorizationStatusDenied,            // 不允许
 PHAuthorizationStatusAuthorized //允许
 */

/*
//获取已有相册
- (PHAssetCollection *)getAssetCollection
{
    //获取系统相册结构集
  PHFetchResult *results =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //遍历，判断
    for (PHAssetCollection *assetCollection in results) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
            return nil;
}

//添加图片到自定义相册

- (void)addPictureToAlbum
{
    //获取相簿
    PHPhotoLibrary *lib = [PHPhotoLibrary sharedPhotoLibrary];
    
    //自定义相册必须在下列方法中
    [lib performChanges:^{
        //1自定义相册
        PHAssetCollectionChangeRequest *createAssetRequest;
        //先去取，已经有就不创建，用取到的，没有就创件
        PHAssetCollection *assetCollection = [self getAssetCollection];
        
        if (assetCollection) { //已有相册，
            createAssetRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else { //没有就自定义
            createAssetRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        
        
        // 2、创建图片请求对象
        PHAssetChangeRequest *assetRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:_image];
        
        // 3/图片请求添加到相册
        [createAssetRequest addAssets:@[assetRequest.placeholderForCreatedAsset]];

    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
        }
    }];
}

*/
       
/*************** 保存完成 ***************/
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) { //错误
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {   //正确
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
/*************** 保存完成 ***************/
         
- (void)viewDidLoad {
    [super viewDidLoad];
    //图片空间，不确定尺寸，就用代码创建
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.item.image0]];
    _imageView = imgView;
    
    _image = imgView.image;
    //尺寸
    CGFloat h = MYScreenW / self.item.width * self.item.height;
    imgView.frame = CGRectMake(0, 0, MYScreenW, h);
    
    //小图中心显示，大图就显示全屏
    if (self.item.is_bigPicture) {//大图，设置滚动范围
        self.scrollView.contentOffset = CGPointMake(0, h);
    } else {
        imgView.center = CGPointMake(MYScreenW * 0.5, MYScreenH * 0.5);
    }
    
    //添加
    [self.scrollView addSubview:imgView];
    
    //缩放图片。设置代理和缩放比例
    self.scrollView.delegate = self;
    
    self.scrollView.minimumZoomScale = 1; //最小比例
    
    if (_item.height > h) {
        self.scrollView.maximumZoomScale = _item.height / h; //最大比例
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}



@end
