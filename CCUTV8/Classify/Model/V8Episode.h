//
//  V8Episode.h
//  CCUTV8
//
//  Created by Oneself on 16/12/23.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// 视频下载状态
typedef NS_ENUM(NSInteger, V8EpisodeDownloadStatus) {
    V8EpisodeDownloadStatusUnload = 0,
    V8EpisodeDownloadStatusLoading,
    V8EpisodeDownloadStatusLoaded,
};

@interface V8Episode : NSObject

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) V8EpisodeDownloadStatus downloadStatus;
@property (nonatomic, copy) NSString *downloadSpeed;
@property (nonatomic, assign) CGFloat downloadPercent;


/**
 下载视频
 */
- (void)resumeTask;

@end
