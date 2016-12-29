//
//  YLVideoPlayerController.h
//
//  Created by Oneself on 16/12/18.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLVideoPlayerController : UIViewController

@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithVideoUrl:(NSURL *)url;

@end
