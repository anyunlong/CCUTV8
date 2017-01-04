//
//  V8EpisodeListViewController.m
//  CCUTV8
//
//  Created by Oneself on 16/12/23.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8EpisodeListViewController.h"
#import "YLVideoPlayerController.h"
#import "V8EpisodeCell.h"
#import "V8Episode.h"

@interface V8EpisodeListViewController ()

@property (nonatomic, strong) NSMutableArray *episodes;

@end

@implementation V8EpisodeListViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _themeName;
    
    [self loadEpisodeList];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.episodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    V8EpisodeCell *cell = [V8EpisodeCell cellWithTableView:tableView setupBlock:^(UITableViewCell *cell) {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light Italic" size:15];
    }];
    V8Episode *episode = _episodes[indexPath.row];
    cell.episode = episode;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    V8Episode *episode = _episodes[indexPath.row];
    NSURL *url;
    // 根据剧集的下载状态判断加载本地视频还是网络视频
    if (episode.downloadStatus == V8EpisodeDownloadStatusLoaded) {
        url = [NSURL fileURLWithPath:[YLCachesFolderPath stringByAppendingPathComponent:[V8DownloadVideoFolderName stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@", episode.themeName, V8DownloadVideoNameSeparator, episode.title]]]];
    } else {
        url = [NSURL URLWithString:episode.url];
    }
    [self presentViewController:[[YLVideoPlayerController alloc] initWithVideoUrl:url] animated:YES completion:nil];
}

#pragma mark - private methods
- (void)loadEpisodeList {
    [YLNetTool getWithURL:@"cartoon/episodes"
               parameters:@{ @"cartoon": _themeName }
                  success:^(id responseObject) {
                      NSArray *episodeDicts = responseObject[@"episodes"];
                      if (episodeDicts.count) {
                          self.episodes = [V8Episode mj_objectArrayWithKeyValuesArray:responseObject[@"episodes"]];
                          
                          // 将模型对应的文件名匹配视频文件夹中的视频文件名，名字如果存在设为已下载状态
                          NSArray *fileNames = [YLFileManager contentsOfDirectoryAtPath:[YLCachesFolderPath stringByAppendingPathComponent:V8DownloadVideoFolderName] error:NULL];
                          for (int index=0; index<_episodes.count; ++index) {
                              V8Episode *episode = _episodes[index];
                              NSString *fileName = [NSString stringWithFormat:@"%@%@%@", episode.themeName, V8DownloadVideoNameSeparator, episode.title];
                              if ([fileNames containsObject:fileName]) {
                                  episode.downloadStatus = V8EpisodeDownloadStatusLoaded;
                              }
                          }
                          
                          [self.tableView reloadData];
                      } else {
                          UIAlertController *alertController = [[UIAlertController alloc] init];
                          UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"暂无资源" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                              [alertController dismissViewControllerAnimated:YES completion:nil];
                          }];
                          [alertController addAction:alertAction];
                          [self presentViewController:alertController animated:YES completion:nil];
                      }
                  }
                  failure:^(NSError *error) {
                      debugLog(@"%@", error);
                  }];
}

@end
