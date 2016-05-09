//
//  MYheaderView.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYheaderView : UIView

//正在加载
@property (nonatomic, assign) BOOL isLoading;

//是否显示
@property (nonatomic, assign) BOOL isVisable;

+ (instancetype)headerView;
@end
