//
//  MYCommentItem.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MYUserItem;

@interface MYCommentItem : NSObject

// 内容
@property (nonatomic, strong) NSString *content;
// 音频长度
@property (nonatomic, strong) NSString *voicetime;
// 用户
@property (nonatomic, strong) MYUserItem *user;

@property (nonatomic, strong) NSString *totalContent;
@end
