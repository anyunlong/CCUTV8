//
//  NSString+YLAdd.m
//
//  Created by Oneself on 16/10/12.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "NSString+YLAdd.h"

@implementation NSString (YLAdd)

- (CGSize)textSizeWithFontSize:(CGFloat)fontSize textWidth:(CGFloat)textWidth {
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [self boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
