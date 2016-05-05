//
//  MYCommentItem.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYCommentItem.h"
#import "MYUserItem.h"

@implementation MYCommentItem

//当要获取评论内容，就拼接
- (NSString *)totalContent
{
    return [NSString stringWithFormat:@"%@:%@",self.user.username,self.content];
}
@end
