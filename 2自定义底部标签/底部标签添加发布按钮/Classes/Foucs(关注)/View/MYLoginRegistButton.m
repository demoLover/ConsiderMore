//
//  MYLoginRegistButton.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYLoginRegistButton.h"

@implementation MYLoginRegistButton

/*************** 布局子控件 ***************/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.my_x = (self.my_width - self.imageView.my_width) * 0.5;
    self.imageView.my_y = 0;

    [self.titleLabel sizeToFit];

    self.titleLabel.my_y = self.imageView.my_buttom;
    self.titleLabel.my_x = (self.my_width - self.titleLabel.my_width) * 0.5;
}
/*************** 布局子控件 ***************/

@end
