//
//  UITextField+PlaceHolder.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "UITextField+PlaceHolder.h"
#import <objc/message.h>

@implementation UITextField (PlaceHolder)


/*************** 动态交换方法 ***************/
+ (void)load
{
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    
    Method my_setPlaceholderMethod = class_getInstanceMethod(self, @selector(my_setPlaceholder:));
    
    //交换
    method_exchangeImplementations(setPlaceholderMethod, my_setPlaceholderMethod);
}
/*************** 动态交换方法 ***************/



/*************** 动态添加属性 ***************/

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}
/*************** 动态添加属性 ***************/



/*************** 重写设置占位文字方法 ***************/
- (void)my_setPlaceholder:(NSString *)placeholder
{
    //先调用系统设置方法，但不能直接写系统方法，因为方法实现交换了，会陷入死循环，调用my_setPlaceholder，就是调用系统的方法
    [self my_setPlaceholder:placeholder];
    
    //设置占位文字颜色(调用set 、get方法)
    self.placeholderColor = self.placeholderColor;
}
/*************** 重写设置占位文字方法  ***************/
@end
