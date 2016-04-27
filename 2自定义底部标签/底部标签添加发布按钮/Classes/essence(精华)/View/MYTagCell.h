//
//  MYTagCell.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTagItem;

@interface MYTagCell : UITableViewCell

//模型属性
@property (nonatomic, strong) MYTagItem *item;

@end
