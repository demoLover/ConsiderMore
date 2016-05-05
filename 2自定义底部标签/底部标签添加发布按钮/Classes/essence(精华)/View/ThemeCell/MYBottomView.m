//
//  MYBottomView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYBottomView.h"
#import "MYThemeItem.h"

@interface MYBottomView ()

@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation MYBottomView

- (void)setItem:(MYThemeItem *)item
{
    [super setItem:item];
    
    [self setButton:self.zanButton withCount:item.ding];
    [self setButton:self.caiButton withCount:item.cai];
    [self setButton:self.reportButton withCount:item.repost];
    [self setButton:self.commentButton withCount:item.comment];
    
}

- (void)setButton:(UIButton *)button withCount:(NSInteger)count
{
    NSString *titleStr = [NSString stringWithFormat:@"%ld",count];
    if (count > 10000) {
        CGFloat countF = count / 10000.0;
        titleStr = [NSString stringWithFormat:@"%.1f",countF];
        titleStr = [titleStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    [button setTitle:titleStr forState:UIControlStateNormal];
}
@end
