//
//  MYVideoView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYVideoView.h"
#import "MYThemeItem.h"
#import "MYLoadImageManager.h"

@interface MYVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@end


@implementation MYVideoView

- (void)setItem:(MYThemeItem *)item
{
    [super setItem:item];
    
    //设置图片
    [MYLoadImageManager my_setImageWithURL:item.image0 placeholderImage:nil imageView:self.pictureView progress:nil completed:nil];
    //设置时间，播放次数
    NSInteger minute = item.voicetime.integerValue / 60;
    NSInteger second = item.voicetime.integerValue % 60;
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%ld : %ld",minute,second];
    self.playCountLabel.text = [NSString stringWithFormat:@"%@次播放",item.playcount];
}

@end
