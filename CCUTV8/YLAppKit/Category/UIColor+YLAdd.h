//
//  UIColor+YLAdd.h
//
//  Created by Oneself on 16/5/29.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface UIColor (YLAdd)

/**
 *  @return RGB color with r & g & b.
 */
+ (UIColor *)yl_colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
/**
 *  @return color of system-tableView.
 */
+ (UIColor *)yl_systemTableViewBackgroundColor;
/**
 *  @return hexadecimal color with hexString.
 */
+ (UIColor *)yl_colorWithHexString:(NSString *)hexString;
/**
 *  @return a random color.
 */
+ (UIColor *)yl_randomColor;

@end
