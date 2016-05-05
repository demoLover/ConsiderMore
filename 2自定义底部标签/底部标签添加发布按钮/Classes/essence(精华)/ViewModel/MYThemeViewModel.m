//
//  MYThemeViewModel.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYThemeViewModel.h"
#import "MYThemeItem.h"
#import "MYCommentItem.h"

@implementation MYThemeViewModel

- (void)setItem:(MYThemeItem *)item
{
    _item = item;
    
    //根据模型，计算view的frame并最终确定cell高度
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat margin = 10;
    CGFloat topW = MYScreenW;
    CGFloat mintopH = 65;
    
    //获取text
    NSString *text = item.text;
    CGFloat textW = topW - 2 * margin;
    //text文本高度(文本框指定字体和宽度才能计算出高度)
    CGFloat textH = [text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
    CGFloat topH = mintopH + textH;
    _topViewFrame = CGRectMake(topX, topY, topW, topH);
    
    _cellH = CGRectGetMaxY(_topViewFrame) + margin;
    
    //计算中间view的frame
    if (item.type != MYThemeTypeText && item.width) {//不是段子就计算 (高为0，不能做被除数)
        CGFloat middleX = margin;
        CGFloat middleY = CGRectGetMaxY(_topViewFrame) + margin;
        CGFloat middleW = textW;
        CGFloat middleH = middleW / item.width * item.height;//按比例求高度
        
        //处理大图片
        if (middleH > MYScreenH) {
            //高度等于定值
            middleH = 300;
            //记录大图
            item.is_bigPicture = YES;
        }
        _pictureViewFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellH = CGRectGetMaxY(_pictureViewFrame) + margin;
    }
    
    //计算最热评论的frame
    if (item.commentItem) {//有评论在计算
    CGFloat hotX = margin;
    CGFloat hotY = _cellH;
    CGFloat hotW = textW;
    CGFloat hotH = 42;
    //判断是否有文字评论，有就重新计算高度
    if (item.commentItem.content.length) {//有文字评论
        CGFloat textH = [item.commentItem.totalContent sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
        
        hotH = 21 + textH;
    }
        _hotViewFrame = CGRectMake(hotX, hotY, hotW, hotH);
        //高度增加10，frame显示前减去10，就会出现分割线，（原则是显示内容高度不变）
        _cellH = CGRectGetMaxY(_hotViewFrame) + margin;
    }
    
    //计算底部viewframe
    CGFloat bottomX = 0;
    CGFloat bottomY = _cellH;
    CGFloat bottomW = MYScreenW;
    CGFloat bottomH = 35;
    
    _bottomViewFrame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    
    _cellH = CGRectGetMaxY(_bottomViewFrame) + margin;
}
@end
