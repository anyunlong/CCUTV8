//
//  V8Episode.m
//  CCUTV8
//
//  Created by Oneself on 16/12/23.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8Episode.h"

@interface V8Episode() <NSURLSessionDownloadDelegate>

/**
 一秒接收的字节数
 */
@property (nonatomic, assign) int64_t recivedBytesPerSecond;

@end

@implementation V8Episode

- (void)resumeTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.discretionary = YES;
    // session对self强引用
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    self.downloadTask = [session downloadTaskWithRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:_url]]];
    [self.downloadTask resume];
    // timer任务每秒执行一次，更新网速、清空recivedBytesPerSecond
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.downloadSpeed = [NSString stringWithFormat:@"%.1lfM/s", self.recivedBytesPerSecond * 1.0 / 1024 / 1024];
        self.recivedBytesPerSecond = 0;
    }];
    [YLCurrentRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark - NSURLSessionDownloadDelegate(均在子线程执行)
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 主线程更新UI
    dispatch_sync(dispatch_get_main_queue(), ^{
        // 更新下载的进度条
        self.downloadPercent = (double_t)totalBytesWritten/totalBytesExpectedToWrite;
        // 累计每秒接收的字节数
        self.recivedBytesPerSecond += bytesWritten;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.downloadStatus = V8EpisodeDownloadStatusLoaded;
        // 缓存好的文件从temp文件夹移动到DownloadVideo文件夹
        NSString *downloadPath = [YLCachesFolderPath stringByAppendingPathComponent:@"DownloadVideo"];
        NSString *fileName = [NSString stringWithFormat:@"%@%@%@", _themeName, V8DownloadVideoNameSeparator, _title];
        [YLFileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:[downloadPath stringByAppendingPathComponent:fileName]] error:NULL];
    });
}

@end
