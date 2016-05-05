//
//  MYBaseView.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYThemeItem;

@interface MYBaseView : UIView

+ (instancetype)viewFromNib;

//模型属性
@property (nonatomic, strong) MYThemeItem *item;

@end
