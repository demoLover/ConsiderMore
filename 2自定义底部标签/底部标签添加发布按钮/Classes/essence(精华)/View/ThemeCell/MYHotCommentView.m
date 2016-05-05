//
//  MYHotCommentView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYHotCommentView.h"
#import "MYThemeItem.h"
#import "MYCommentItem.h"
#import "MYUserItem.h"

@interface MYHotCommentView ()
@property (weak, nonatomic) IBOutlet UILabel *totalComentLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *videoView;


@end


@implementation MYHotCommentView

-(void)setItem:(MYThemeItem *)item
{
    [super setItem:item];
    
    //根据评论文本是否有值，判断显示那个子控件
    if (item.commentItem.content.length) {
        //显示totallabel，隐藏音频
        self.videoView.hidden = YES;
        self.totalComentLabel.hidden = NO;
        
        self.totalComentLabel.text = item.commentItem.totalContent;
    } else {//评论是音频
        self.totalComentLabel.hidden = YES;
        self.videoView.hidden = NO;
        
        self.nameLabel.text = item.commentItem.user.username;
        [self.playButton setTitle:item.commentItem.voicetime forState:UIControlStateNormal];
    }
}

@end
