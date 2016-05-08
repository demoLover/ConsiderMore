//
//  MYPictureView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYPictureView.h"
#import <UIImageView+WebCache.h>
#import "MYThemeItem.h"
#import "MYLoadImageManager.h"
#import <DALabeledCircularProgressView.h>
#import "MYSeeBigPictureViewController.h"

@interface MYPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;
@end


@implementation MYPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}


+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


- (void)setItem:(MYThemeItem *)item
{
    _item = item;
    
    /*
     
     这个方法可以抽一个业务类
    //从磁盘取照片
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.image0];
    
    if (cacheImage) {//从磁盘取到了照片
        self.pictureView.image = cacheImage;
    } else {//没有照片就下载
   
    //该方法内部会进行下载，从缓存。磁盘取数据，会多次调用，就会进行多次绘图，因此将绘图得到的新图存入磁盘，下次判断是否从磁盘取到照片，取到就不来此方法了
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //开启上下文
        CGFloat h = self.my_width / item.width * item.height;
        CGSize size = CGSizeMake(self.my_width, h);
        
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        
        //绘图
        [image drawInRect:CGRectMake(0, 0, size.width, h)];
        image = UIGraphicsGetImageFromCurrentImageContext();//获取图片
        UIGraphicsEndImageContext();//关闭上下文
        //设置图片
        _pictureView.image = image;
        //新图片存入磁盘，替换原来的缓存数据
        [[SDImageCache sharedImageCache] storeImage:image forKey:item.image0];
    }];
    }
     
     */

    
    //获取图片 （用自己封装的业务类方法
    
    [MYLoadImageManager my_setImageWithURL:item.image0 placeholderImage:nil imageView:self.pictureView progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //当网速特别慢的时候，expectedSize为负值，此时进度条不显示
        //不要再调用频繁的方法中打印，影响性能，造成卡顿
        if (expectedSize < 0)  return ;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress * 100];
        self.progressView.progressLabel.textColor = [UIColor whiteColor];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //每次生成一张新的大图，并保存，只有大图才需要重绘
        if (!item.is_bigPicture) return ;
        
        //开启上下文
        CGFloat h = self.my_width / item.width * item.height;
        CGSize size = CGSizeMake(self.my_width, h);
        
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        
        //绘图
        [image drawInRect:CGRectMake(0, 0, size.width, h)];
        image = UIGraphicsGetImageFromCurrentImageContext();//获取图片
        UIGraphicsEndImageContext();//关闭上下文
        //设置图片
        _pictureView.image = image;
        //新图片存入磁盘，替换原来的缓存数据
        [[SDImageCache sharedImageCache] storeImage:image forKey:item.image0];

    }];
    //gif显示
    self.gifView.hidden = !item.is_gif;
    
    //按钮隐藏
    self.seeBigPictureBtn.hidden = !item.is_bigPicture;
    

    
    //解决大图片改变高度后边的难看
    if (item.is_bigPicture) {//(处理后，发现依旧很难看，分析是被sdWebImage压缩的很窄，因此在下载图片完成后进行再次重绘,重绘后跟控件宽度一致，然后取top)
        //修改填充模式
        self.pictureView.contentMode = UIViewContentModeTop;
        
        //多余裁剪不显示
        self.pictureView.clipsToBounds = YES;
    }else {//修改了一定要改回来，循环利用会影响其他的
        self.pictureView.contentMode = UIViewContentModeScaleToFill;
        self.pictureView.clipsToBounds = NO;
    }
}




#pragma mark 点击看大图业务处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建控制器
    MYSeeBigPictureViewController *seeVC = [[MYSeeBigPictureViewController alloc] init];
    seeVC.item = self.item;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeVC animated:YES completion:nil];
}
@end
