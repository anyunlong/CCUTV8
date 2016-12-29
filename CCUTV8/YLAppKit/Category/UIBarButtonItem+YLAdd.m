//
//  UIBarButtonItem+YLAdd.m
//  CCUTV8
//
//  Created by Oneself on 16/12/24.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UIBarButtonItem+YLAdd.h"

@implementation UIBarButtonItem (YLAdd)

+ (instancetype)itemWithCustomView:(UIView *)view {
    return [[self alloc] initWithCustomView:view];
}

@end
