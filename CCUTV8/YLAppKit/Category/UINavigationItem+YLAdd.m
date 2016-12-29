//
//  UINavigationItem+YLAdd.m
//  CCUTV8
//
//  Created by Oneself on 16/12/29.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UINavigationItem+YLAdd.h"

@implementation UINavigationItem (YLAdd)

- (void)hiddenNextBackItemTitle {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"";
    self.backBarButtonItem = barButtonItem;
}

@end
