//
//  YLNavigationController.m
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "YLNavigationController.h"

@interface YLNavigationController ()

@end

@implementation YLNavigationController

+ (void)initialize {
    // 1.设置导航栏主题
    [self setupNavBarTheme];
}

+ (void)setupNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 返回按钮颜色
    navBar.tintColor = [UIColor whiteColor];
    // 标题文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont fontWithName:YLFontHelveticaLight size:16];
    [navBar setTitleTextAttributes:attrs];
    // 背景颜色
    [navBar setBarTintColor:[UIColor blackColor]];
}

// 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
