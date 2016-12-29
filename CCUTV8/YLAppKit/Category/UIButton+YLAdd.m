//
//  UIButton+YLAdd.m
//  CCUTV8
//
//  Created by Oneself on 16/12/24.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UIButton+YLAdd.h"

@implementation UIButton (YLAdd)

- (void)setNormalImageWithName:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setHighlightedImageWithName:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

@end
