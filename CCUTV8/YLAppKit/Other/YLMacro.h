//
//  YLMacro.h
//
//  Created by Oneself on 16/7/14.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#ifndef YLMacro_h
#define YLMacro_h

/* other */
#ifdef DEBUG // 调试阶段
#define debugLog(...)  NSLog(__VA_ARGS__)
#else // 发布阶段
#define debugLog(...)
#endif

#define WeakSelf __weak typeof(self) weakSelf = self

/* device */
#define YLStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_BOUNDS      [UIScreen mainScreen].bounds
#define SCREEN_SIZE        SCREEN_BOUNDS.size
#define SCREEN_WIDTH       SCREEN_SIZE.width
#define SCREEN_HEIGHT      SCREEN_SIZE.height

/* shareInstance */
#define YLBundle             [NSBundle             mainBundle]
#define YLUserDefaults       [NSUserDefaults       standardUserDefaults]
#define YLNotificationCenter [NSNotificationCenter defaultCenter]
#define YLApplication        [UIApplication        sharedApplication]
#define YLCurrentRunLoop     [NSRunLoop            currentRunLoop]
#define YLFileManager        [NSFileManager        defaultManager]

/* sand box */
#define YLCachesFolderPath NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)[0]

#endif /* YLMacro_h */
