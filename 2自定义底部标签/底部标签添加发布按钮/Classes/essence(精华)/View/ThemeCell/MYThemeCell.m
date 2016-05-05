//
//  MYThemeCell.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYThemeCell.h"
#import "MYTopView.h"
#import "MYThemeViewModel.h"
#import "MYPictureView.h"
#import "MYThemeItem.h"
#import "MYVoiceView.h"
#import "MYVideoView.h"
#import "MYHotCommentView.h"
#import "MYBottomView.h"

@interface MYThemeCell ()

/*
 cell细节处理
 1.cell间距
 2.cell没有选中样式
 3、cell的背景图片
 
 */

@property (nonatomic, weak) MYTopView *topView;

@property (nonatomic, weak) MYPictureView *pictureView;
@property (nonatomic, weak) MYVoiceView *voiceView;
@property (nonatomic, weak) MYVideoView *videoView;
@property (nonatomic, weak) MYHotCommentView *hotView;
@property (nonatomic, weak) MYBottomView *bottomView;
@end
@implementation MYThemeCell

/*************** 设置间距 ***************/
- (void)setFrame:(CGRect)frame
{
    //高度减10
    frame.size.height -= 10;
    //y加10,顶部就有间距了
    frame.origin.y += 10;
    [super setFrame:frame];
}
/*************** 设置间距 ***************/



/*************** setItem ***************/
- (void)setThemeVM:(MYThemeViewModel *)themeVM
{
    _themeVM = themeVM;
    
    //设置各个view的模型，及尺寸
    _topView.frame = themeVM.topViewFrame;
    
    _topView.item = themeVM.item;
    
    //判断中间是否是图片，决定frame和隐藏与否，由于cell循环利用，改动了控件一定要改回来
    if (themeVM.item.type == MYThemeTypePicture) { //图片
        //音频、视频隐藏
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = NO;
        
        self.pictureView.frame = themeVM.pictureViewFrame;
        
        self.pictureView.item = themeVM.item;
    } else if (themeVM.item.type == MYThemeTypeVoice){//音频
        //图片、视频隐藏
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        //音频显示
        self.voiceView.hidden = NO;
        
        self.voiceView.frame = themeVM.pictureViewFrame;
        self.voiceView.item = themeVM.item;
        
    } else if (themeVM.item.type == MYThemeTypeVideo) {//视频
        //音频。图片隐藏
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        
        _videoView.frame = themeVM.pictureViewFrame;
        _videoView.item = themeVM.item;
    } else {//纯文本
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    //  判断最热评论是否展示
    if (themeVM.item.commentItem) {//有值，显示、设置最热评论的frame和模型
        self.hotView.hidden = NO;
        
        self.hotView.item = themeVM.item;
        self.hotView.frame = themeVM.hotViewFrame;
    } else {//隐藏
        self.hotView.hidden = YES;
    }
    
    //设置底部按钮frame
    self.bottomView.frame = themeVM.bottomViewFrame;
    self.bottomView.item = themeVM.item;
    
}
/*************** setItem ***************/


/*************** 初始化方法 ***************/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置背景图片
        UIImage *image = [UIImage imageWithOriginalImageName:@"mainCellBackground"];
        self.backgroundView = [[UIImageView alloc] initWithImage:image];
        
        //添加顶部view(view固定不变，从xib加载)
        MYTopView *topView = [MYTopView topView];
        _topView = topView;
        [self.contentView addSubview:topView];
        
        //添加中间view
        
        //2.1添加图片
        MYPictureView *pictureView = [MYPictureView pictureView];
        _pictureView = pictureView;
        [self.contentView addSubview:pictureView];
        
        //添加音频
        MYVoiceView *voiceView = [MYVoiceView viewFromNib];
        _voiceView = voiceView;
        [self.contentView addSubview:voiceView];
        
        //添加视频
        MYVideoView *videoView = [MYVideoView viewFromNib];
        _videoView = videoView;
        [self.contentView addSubview:videoView];
        
        //添加最佳评论
        MYHotCommentView *hotView = [MYHotCommentView viewFromNib];
        _hotView = hotView;
        [self.contentView addSubview:hotView];
        
        //添加底部view
        MYBottomView *bottomView = [MYBottomView viewFromNib];
        _bottomView = bottomView;
        [self.contentView addSubview:bottomView];
        
    }
    
    return self;
}
/*************** 初始化方法 ***************/
@end
