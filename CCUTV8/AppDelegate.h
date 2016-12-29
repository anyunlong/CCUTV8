//
//  AppDelegate.h
//  CCUTV8
//
//  Created by Oneself on 16/12/21.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end
