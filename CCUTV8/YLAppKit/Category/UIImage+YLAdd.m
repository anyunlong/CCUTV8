//
//  UIImage+YLAdd.m
//
//  Created by Oneself on 16/5/28.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UIImage+YLAdd.h"

@implementation UIImage (YLAdd)

+ (UIImage *)yl_resizedImageWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGSize imageSize = image.size;
    return [image stretchableImageWithLeftCapWidth:imageSize.width * 0.5 topCapHeight:imageSize.height * 0.5];
}

@end
