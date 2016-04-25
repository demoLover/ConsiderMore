


#import "UIView+MYExtension.h"

@implementation UIView (MYExtension)


/*************** my_x ***************/

- (void)setMy_x:(CGFloat)my_x
{
    CGRect frame = self.frame;
    
    frame.origin.x = my_x;
    
    self.frame = frame;
}

- (CGFloat)my_x
{
    return self.frame.origin.x;
}
/*************** my_x ***************/


/*************** my_y ***************/

- (void)setMy_y:(CGFloat)my_y
{
    CGRect frame = self.frame;
    
    frame.origin.y = my_y;
    
    self.frame = frame;
}

- (CGFloat)my_y
{
    return self.frame.origin.y;
}
/*************** my_y ***************/


/*************** my_width ***************/

- (void)setMy_width:(CGFloat)my_width
{
    CGRect frame = self.frame;
    
    frame.size.width = my_width;
    
    self.frame = frame;
}

-(CGFloat)my_width
{
    return self.frame.size.width;
}
/*************** my_width ***************/



/*************** my_height ***************/

-(void)setMy_height:(CGFloat)my_height
{
    CGRect frame = self.frame;
    
    frame.size.height = my_height;
    
    self.frame = frame;
}

-(CGFloat)my_height
{
    return self.frame.size.height;
}
/*************** my_height ***************/


/*************** my_centerX ***************/

- (void)setMy_centerX:(CGFloat)my_centerX
{
    CGPoint center = self.center;
    
    center.x = my_centerX;
    
    self.center = center;
}

- (CGFloat)my_centerX
{
    return self.center.x;
}
/*************** my_centerX ***************/


/*************** my_centerY ***************/

- (void)setMy_centerY:(CGFloat)my_centerY
{
    CGPoint center = self.center;
    
    center.y = my_centerY;
    
    self.center = center;
}

- (CGFloat)my_centerY
{
    return self.center.y;
}
/*************** my_centerY ***************/


/*************** my_buttom ***************/

- (void)setMy_buttom:(CGFloat)my_buttom
{
    self.my_y = my_buttom - self.my_height;
}

- (CGFloat)my_buttom
{
    return CGRectGetMaxY(self.frame);
}
/*************** my_buttom ***************/


/*************** my_right ***************/

- (void)setMy_right:(CGFloat)my_right
{
    self.my_x = my_right - self.my_width;
}

- (CGFloat)my_right
{
    return CGRectGetMaxX(self.frame);
}
/*************** my_right ***************/

@end
