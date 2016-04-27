

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    // 把按钮包装成UIBarButtonItem，点击范围扩大，把按钮放在UIView,在把UIView包装成UIBarButtonItem
    UIView *contentView = [[UIView alloc] initWithFrame:button.frame];
    
    [contentView addSubview:button];
    
    return [[self alloc] initWithCustomView:contentView];
}


+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    // 把按钮包装成UIBarButtonItem，点击范围扩大，把按钮放在UIView,在把UIView包装成UIBarButtonItem
    UIView *contentView = [[UIView alloc] initWithFrame:button.frame];
    
    [contentView addSubview:button];
    
    return [[self alloc] initWithCustomView:contentView];
    
    return [[self alloc] initWithCustomView:button];
}
@end
