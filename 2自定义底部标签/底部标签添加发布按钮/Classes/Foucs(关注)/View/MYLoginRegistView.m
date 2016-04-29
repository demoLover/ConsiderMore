//
//  MYLoginRegistView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYLoginRegistView.h"
@interface MYLoginRegistView ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation MYLoginRegistView

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


+ (instancetype)registView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib
{
    UIImage *image = _button.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [_button setBackgroundImage:image forState:UIControlStateNormal];
}
@end
