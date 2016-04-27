

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;
@end
