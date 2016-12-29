//
//  UIColor+YLAdd.m
//
//  Created by Oneself on 16/5/29.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UIColor+YLAdd.h"

@implementation UIColor (YLAdd)

+ (UIColor *)yl_colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b {
    return [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
}

+ (UIColor *)yl_systemTableViewBackgroundColor {
    return [UIColor yl_colorWithR:239 G:239 B:244];
}

+ (UIColor *)yl_colorWithHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [self yl_colorWithR:(float) r G:(float) g B:(float) b];
}

+ (UIColor *)yl_randomColor {
    return [self yl_colorWithR:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256)];
}

@end
