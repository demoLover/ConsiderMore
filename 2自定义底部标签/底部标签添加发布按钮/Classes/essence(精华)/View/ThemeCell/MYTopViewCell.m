//
//  MYTopViewCell.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYTopViewCell.h"
#import <UIImageView+WebCache.h>
#import "MYThemeItem.h"
@interface MYTopViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end


@implementation MYTopViewCell


+ (instancetype)topView
{
    
}


- (void)setItem:(MYThemeItem *)item
{
    _item = item;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = item.name;
    self.timeLabel.text = item.create_time;
    self.textLabel.text = item.text;
}
@end
