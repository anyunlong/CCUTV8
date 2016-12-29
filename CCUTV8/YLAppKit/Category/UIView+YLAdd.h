//
//  UIView+YLAdd.h
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface UIView (YLAdd)

@property (nonatomic, assign) CGFloat yl_centerX;
@property (nonatomic, assign) CGFloat yl_centerY;
@property (nonatomic, assign) CGFloat yl_x;
@property (nonatomic, assign) CGFloat yl_y;
@property (nonatomic, assign) CGPoint yl_orign;

@property (nonatomic, assign) CGFloat yl_left;
@property (nonatomic, assign) CGFloat yl_right;
@property (nonatomic, assign) CGFloat yl_top;
@property (nonatomic, assign) CGFloat yl_bottom;

@property (nonatomic, assign) CGFloat yl_width;
@property (nonatomic, assign) CGFloat yl_height;
@property (nonatomic, assign) CGSize  yl_size;

- (void)yl_circleView;
- (void)yl_circularBeadViewWithRadius:(CGFloat)radius;

@end
