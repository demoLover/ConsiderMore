//
//  MYFooterRefreshView.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYFooterRefreshView : UIView

//记录是否正在加载数据
@property (nonatomic, assign) BOOL isLoading;

+ (instancetype)footerView;
@end
