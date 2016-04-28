//
//  MYTagCell.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYTagCell.h"
#import <UIImageView+WebCache.h>
#import "MYTagItem.h"

@interface MYTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end

@implementation MYTagCell

/*
 开发步骤：
 发请求获取数据 -》验证数据正确性- >解析数据（字典转模型） - >展示数据（数据决定展示内容和样式） - >细节处理
 */


- (void)setItem:(MYTagItem *)item
{
    _item = item;
    
    //设置图片
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return ;
        //开启上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //描述裁剪区域
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //添加裁剪区域
        [clipPath addClip];
        
        //绘图
        [image drawAtPoint:CGPointZero];
        //获取新图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        //设置图片
        self.imageView.image = image;
    }];
    
    //设置标题
    self.titleLable.text = item.theme_name;
    
    //子标题
    NSInteger num = [item.sub_number integerValue];
    NSString *subStr = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    
    if (num > 10000) {
        CGFloat newNum =  num / 10000.0;
        
        subStr = [NSString stringWithFormat:@"%.1f万人订阅l",newNum];
    }
    //替换
    subStr = [subStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    self.subLabel.text = subStr;
}

/*************** setFrame ***************/

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    
    //调用父类方法赋值
    [super setFrame:frame];
}
/*************** setFrame ***************/


//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.imageView.frame = CGRectMake(10,10,60,60);
//    float limgW =  self.imageView.image.size.width;
//    if(limgW > 0) {
//        self.textLabel.frame = CGRectMake(80,self.textLabel.frame.origin.y,self.textLabel.frame.size.width,self.textLabel.frame.size.height);
//        self.detailTextLabel.frame = CGRectMake(80,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);
//    }
//}
@end
