//
//  NSString+AYLAdd.h
//
//  Created by Oneself on 16/10/12.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface NSString (YLAdd)

/**
 根据字体大小、自定义的最大宽度计算文字尺寸

 @param fontSize  字体大小
 @param textWidth 自定义的最大宽度

 @return 文字尺寸
 */
- (CGSize)textSizeWithFontSize:(CGFloat)fontSize textWidth:(CGFloat)textWidth;

@end
