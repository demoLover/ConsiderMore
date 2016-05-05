//
//  MYTopView.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYTopView.h"
#import "MYThemeItem.h"
#import <UIImageView+WebCache.h>


@interface MYTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

/*
 业务逻辑处理：点击更多按钮，要从底部弹出对话框，而且，更多按钮在顶部view，因此就找到顶部按钮处理
 */
@implementation MYTopView

- (IBAction)moreButtonClicked {
    /*
    //方案一：用UIActionSheet
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self];
     */
    //方案二：用UIAlertController，要添加UIAlertAction modal出来出来，最快的方法就是拿到根控制器，不用用代理通知麻烦，要多层传递
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"收藏" style:UIPreviewActionStyleDefault handler:nil];
    [alert addAction:action0];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"举报" style:UIPreviewActionStyleDefault handler:nil];
    [alert addAction:action1];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:nil];
    [alert addAction:action2];
    
    //modal
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}
/*************** 创建类方法 ***************/
+ (instancetype)topView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
/*************** 创建类方法 ***************/


/*************** setItem ***************/
- (void)setItem:(MYThemeItem *)item
{
    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = item.name;
    self.timeLabel.text = item.create_time;
    self.textLabel.text = item.text;
    
}
/*************** setItem ***************/
@end
