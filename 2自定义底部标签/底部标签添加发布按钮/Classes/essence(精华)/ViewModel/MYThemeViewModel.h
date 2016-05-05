//
//  MYThemeViewModel.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MYThemeItem;

@interface MYThemeViewModel : NSObject
//模型属性
@property (nonatomic, strong) MYThemeItem *item;

//topViewFrame
@property (nonatomic, assign) CGRect topViewFrame;

//pictureViewFrame
@property (nonatomic, assign) CGRect pictureViewFrame;

//hotViewFrame
@property (nonatomic, assign) CGRect hotViewFrame;

//bottomFrame
@property (nonatomic, assign) CGRect bottomViewFrame;

//cellH
@property (nonatomic, assign) CGFloat cellH;



@end
