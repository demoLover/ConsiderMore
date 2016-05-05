//
//  MYThemeItem.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MYCommentItem;

//定义全局枚举
typedef enum : NSUInteger {
    MYThemeTypeAll = 1,
    MYThemeTypePicture = 10,
    MYThemeTypeText = 29,
    MYThemeTypeVoice = 31,
    MYThemeTypeVideo = 41,
} MYThemeType;

@interface MYThemeItem : NSObject
/*************** topView ***************/
//name
@property (nonatomic, strong) NSString *profile_image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *text;

/*************** topView ***************/

/*************** piuctureView ***************/
@property (nonatomic, strong) NSString *image0;
@property (nonatomic, strong) NSString *image1;
@property (nonatomic, strong) NSString *image2;

// KVC会自动判断当前类型，转换成当前类型
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
//定义一个属性来保存，是不是大图片，方便查看大图按钮的显示
@property (nonatomic, assign) BOOL is_bigPicture;
@property (nonatomic, assign) MYThemeType type;
/*************** piuctureView ***************/

/*************** 音频 ***************/
// 播放次数
@property (nonatomic, strong) NSString *playcount;
// 视频时长
@property (nonatomic, strong) NSString *videotime;
// 音频时长
@property (nonatomic, strong) NSString *voicetime;
/*************** 音频 ***************/



/*************** 最热评论 ***************/
@property (nonatomic, strong) NSArray *top_cmt;
//评论模型，需要些数组属性的set方法来给模型传数据
@property (nonatomic, strong) MYCommentItem *commentItem;

/*************** 最热评论 ***************/



/*************** 底部view ***************/
@property (nonatomic, assign) NSInteger cai;
@property (nonatomic, assign) NSInteger ding;
@property (nonatomic, assign) NSInteger repost;
@property (nonatomic, assign) NSInteger comment;
/*************** 底部view ***************/

@end
