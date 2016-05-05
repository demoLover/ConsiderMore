//
//  MYThemeItem.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYThemeItem.h"
#import "MYCommentItem.h"
#import <MJExtension/MJExtension.h>

@implementation MYThemeItem


//告知将哪个数组转哪种模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt":@"MYCommentItem"};
}


//重写数组set方法，给模型属性赋值
- (void)setTop_cmt:(NSArray *)top_cmt
{
    _top_cmt = top_cmt;
    
    _commentItem = [top_cmt firstObject];
}
@end
