//
//  UIView+YLAdd.m
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UIView+YLAdd.h"

@implementation UIView (YLAdd)

/**
 *  get or set view's location.
 */
/* get or set view's x & y */
- (CGFloat)yl_centerX {
    return self.center.x;
}
- (void)setYl_centerX:(CGFloat)yl_centerX {
    CGPoint center = self.center;
    center.x = yl_centerX;
    self.center = center;
}
- (CGFloat)yl_centerY {
    return self.center.y;
}
- (void)setYl_centerY:(CGFloat)yl_centerY {
    CGPoint center = self.center;
    center.y = yl_centerY;
    self.center = center;
}
- (CGFloat)yl_x {
    return self.frame.origin.x;
}
- (void)setYl_x:(CGFloat)yl_x {
    CGRect frame = self.frame;
    frame.origin.x = yl_x;
    self.frame = frame;
}
- (CGFloat)yl_y {
    return self.frame.origin.y;
}
- (void)setYl_y:(CGFloat)yl_y {
    CGRect frame = self.frame;
    frame.origin.y = yl_y;
    self.frame = frame;
}
- (CGPoint)yl_orign {
    return self.frame.origin;
}
- (void)setYl_orign:(CGPoint)yl_orign {
    CGRect frame = self.frame;
    frame.origin = yl_orign;
    self.frame = frame;
}
/* get or set view's left & right & top & button. */
- (CGFloat)yl_left {
    return self.yl_x;
}
- (void)setYl_left:(CGFloat)yl_left {
    self.yl_x = yl_left;
}
- (CGFloat)yl_right {
    return self.yl_x + self.yl_width;
}
- (void)setYl_right:(CGFloat)yl_right {
    self.yl_x = yl_right - self.yl_width;
}
- (CGFloat)yl_top {
    return self.yl_y;
}
- (void)setYl_top:(CGFloat)yl_top {
    self.yl_y = yl_top;
}
- (CGFloat)yl_bottom {
    return self.yl_y + self.yl_height;
}
- (void)setYl_bottom:(CGFloat)yl_bottom {
    self.yl_y = yl_bottom - self.yl_height;
}

/**
 *  get or set view's size.
 */
- (CGFloat)yl_width {
    return self.yl_size.width;
}
- (void)setYl_width:(CGFloat)yl_width {
    CGRect frame = self.frame;
    frame.size.width = yl_width;
    self.frame = frame;
}
- (CGFloat)yl_height {
    return self.yl_size.height;
}
- (void)setYl_height:(CGFloat)yl_height {
    CGRect frame = self.frame;
    frame.size.height = yl_height;
    self.frame = frame;
}
- (CGSize)yl_size {
    return self.frame.size;
}
- (void)setYl_size:(CGSize)yl_size {
    CGRect frame = self.frame;
    frame.size = yl_size;
    self.frame = frame;
}

/**
 *  set view's style.
 */
- (void)yl_circleView {
    [self yl_circularBeadViewWithRadius:self.yl_width / 2];
}
- (void)yl_circularBeadViewWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
- (void)yl_setBackgroundImageWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    self.layer.contents = (id)image.CGImage;
}

@end
