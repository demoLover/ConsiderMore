//
//  MYPersenalCell.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYPersenalCell.h"
#import "MYExcelItem.h"
#import <UIImageView+WebCache.h>

@interface MYPersenalCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *title;
@end


@implementation MYPersenalCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setItem:(MYExcelItem *)item
{
    _item = item;
    
    
    [self.icon sd_setImageWithURL:item.icon];
    self.title.text = item.name;
}
@end
