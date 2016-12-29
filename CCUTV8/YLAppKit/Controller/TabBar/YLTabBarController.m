//
//  YLTabBarController.m
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "YLTabBarController.h"
#import "YLNavigationController.h"
#import "V8ClassifyViewController.h"
#import "V8MeViewController.h"

@interface YLTabBarController ()

@end

@implementation YLTabBarController

- (instancetype)init {
    if (self = [super init]) {
        // 初始化控制器
        [self setupTabBarController];

        // 设置tabBar背景颜色
        UITabBar *tabBarAppearance = [UITabBar appearance];
        [tabBarAppearance setTintColor:[UIColor yl_systemTableViewBackgroundColor]];

        // 初始化tabBarItem风格
        [self setupTabBarItemStyle];
    }

    return self;
}

#pragma mark 初始化控制器
- (void)setupTabBarController {
    // tabBarController所有子控制器
    NSArray *controllers = [self setupAllSubControllers];
    // tabBarItem内容
    [self setupTabBarItemContent];
    // addControllers
    [self setViewControllers:controllers];
}
- (NSArray<UIViewController *> *)setupAllSubControllers {
    V8ClassifyViewController *cvc = [[V8ClassifyViewController alloc] init];
    YLNavigationController *cvcNc = [[YLNavigationController alloc] initWithRootViewController:cvc];
    
    V8MeViewController *mvc = [V8MeViewController getAInstance];
    YLNavigationController *mvcNc = [[YLNavigationController alloc] initWithRootViewController:mvc];
    
    return @[cvcNc, mvcNc];
}
- (void)setupTabBarItemContent {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"分类",
                            CYLTabBarItemImage : @"tab_classify",
                            CYLTabBarItemSelectedImage : @"tab_classify_p",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"我",
                            CYLTabBarItemImage : @"tab_me",
                            CYLTabBarItemSelectedImage : @"tab_me_p",
                            };
    NSArray *tabBarItemsAttrs = @[dict1, dict2];
    self.tabBarItemsAttributes = tabBarItemsAttrs;
}

#pragma mark 初始化tabBarItem风格
- (void)setupTabBarItemStyle {
    // 文字主题
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    // 两种状态文字的属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    normalAttrs[NSFontAttributeName] = [UIFont fontWithName:YLFontHelveticaRegular size:10];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:87/255.0 green:186/255.0 blue:56/255.0 alpha:1];
    selectedAttrs[NSFontAttributeName] = [UIFont fontWithName:YLFontHelveticaRegular size:10];
    // 设置属性
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
