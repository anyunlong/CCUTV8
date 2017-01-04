//
//  V8Theme.m
//  CCUTV8
//
//  Created by Oneself on 16/12/23.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8Theme.h"

@implementation V8Theme

- (NSString *)name {
    // 去掉前面的"★"
    return [_name substringFromIndex:1];
}

@end
