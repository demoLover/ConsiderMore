//
//  MYVoiceView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYVoiceView.h"
#import "MYLoadImageManager.h"
#import "MYThemeItem.h"

@interface MYVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end


@implementation MYVoiceView


//子类重写父类属性的set方法，必须要调用父类的set方法
- (void)setItem:(MYThemeItem *)item
{
    [super setItem:item];
    
    [MYLoadImageManager my_setImageWithURL:item.image0 placeholderImage:nil imageView:self.pictureView progress:nil completed:nil];
    
    //分钟、秒
    NSInteger minute = item.voicetime.integerValue / 60;
    NSInteger second = item.voicetime.integerValue % 60;
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%ld : %ld",minute,second];
    self.playCountLabel.text = [NSString stringWithFormat:@"%@次播放",item.playcount];

}

@end
