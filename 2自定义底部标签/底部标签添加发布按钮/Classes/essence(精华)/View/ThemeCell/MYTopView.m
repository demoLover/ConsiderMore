//
//  MYTopView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYTopView.h"
#import "MYThemeItem.h"
#import <UIImageView+WebCache.h>


@interface MYTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end


@implementation MYTopView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}
/*************** 创建类方法 ***************/
+ (instancetype)topView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
/*************** 创建类方法 ***************/


/*************** setItem ***************/
- (void)setItem:(MYThemeItem *)item
{
    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = item.name;
    self.timeLabel.text = item.create_time;
    self.textLabel.text = item.text;
    
}
/*************** setItem ***************/
@end
