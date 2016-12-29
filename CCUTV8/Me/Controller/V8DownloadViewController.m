//
//  V8DownloadViewController.m
//  CCUTV8
//
//  Created by Oneself on 16/12/24.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8DownloadViewController.h"
#import "V8DownloadEpisodeCell.h"
#import "V8DownloadVideoItem.h"

#import <MobileVLCKit/VLCMedia.h>

#import "YLVideoPlayerController.h"

@interface V8DownloadViewController ()

@property (nonatomic, strong) NSMutableArray *downloadVideoItems;
@property (nonatomic, strong) UIBarButtonItem *deleteItem;

@end

@implementation V8DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已下载";
    
    [self loadDownloadVideoItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.deleteItem.customView.yl_size = CGSizeMake(YLNavigationBarHeight, YLNavigationBarHeight);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 先删文件再删模型
        V8DownloadVideoItem *item = _downloadVideoItems[indexPath.row];
        [YLFileManager removeItemAtURL:[NSURL fileURLWithPath:item.path] error:NULL];
        [self.downloadVideoItems removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)loadDownloadVideoItems {
    NSString *downloadVideoFolderPath = [YLCachesFolderPath stringByAppendingPathComponent:V8DownloadVideoFolderName];
    NSMutableArray *videoNames = [[YLFileManager contentsOfDirectoryAtPath:downloadVideoFolderPath error:NULL] mutableCopy];
    [videoNames removeObject:@".DS_Store"];
    for (int index=0; index<videoNames.count; ++index) {
        NSString *videoName = videoNames[index];
        NSString *videoPath = [downloadVideoFolderPath stringByAppendingPathComponent:videoName];
        VLCMedia *media = [[VLCMedia alloc] initWithPath:videoPath];
        double videoSize = [YLFileManager attributesOfItemAtPath:videoPath error:NULL].fileSize/1024.0/1024.0;
        if (videoSize < 0.1) continue;
        
        V8DownloadVideoItem *item = [[V8DownloadVideoItem alloc] init];
        NSArray *componentStrings = [videoName componentsSeparatedByString:V8DownloadVideoNameSeparator];
        item.title = [NSString stringWithFormat:@"%@%@%@", componentStrings.firstObject, @" - ", componentStrings.lastObject];
        item.size = [NSString stringWithFormat:@"%.1lfM", videoSize];
        // VLC计算视频时间的方法会阻塞当前线程(主线程)，所以将此任务扔到后台线程，计算结束后在主线程更新UI
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            item.time = [media lengthWaitUntilDate:[[NSDate alloc] initWithTimeIntervalSinceNow:0.15]].stringValue;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
        item.path = videoPath;
        [self.downloadVideoItems addObject:item];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.downloadVideoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    V8DownloadEpisodeCell *cell = [V8DownloadEpisodeCell cellWithTableView:tableView];
    cell.item = _downloadVideoItems[indexPath.row];
    return cell;
}

- (NSMutableArray *)downloadVideoItems {
    if (!_downloadVideoItems) {
        _downloadVideoItems = [[NSMutableArray alloc] init];
    } return _downloadVideoItems;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    V8DownloadVideoItem *item = _downloadVideoItems[indexPath.row];
    [self presentViewController:[[YLVideoPlayerController alloc] initWithVideoUrl:[NSURL fileURLWithPath:item.path]] animated:YES completion:nil];
}

@end
