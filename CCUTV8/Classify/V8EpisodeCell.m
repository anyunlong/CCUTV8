//
//  V8EpisodeCell.m
//  CCUTV8
//
//  Created by Oneself on 16/12/23.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8EpisodeCell.h"
#import "V8Episode.h"

@interface V8EpisodeCell()

@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIButton *finishDownloadbutton;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadSpeedView;

@end

static NSString *EpisodePropertyDownloadStatusName = @"downloadStatus";
static NSString *EpisodePropertyDownloadPercent    = @"downloadPercent";
static NSString *EpisodePropertyDownloadSpeed      = @"downloadSpeed";

@implementation V8EpisodeCell

- (void)setEpisode:(V8Episode *)episode {
    _episode = episode;
    // KVO: cell观察episode属性变化而变化UI
    [_episode addObserver:self forKeyPath:EpisodePropertyDownloadStatusName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [_episode addObserver:self forKeyPath:EpisodePropertyDownloadPercent options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [_episode addObserver:self forKeyPath:EpisodePropertyDownloadSpeed options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // 初始化UI
    self.titleLabel.text = _episode.title;
    [self observeValueForKeyPath:EpisodePropertyDownloadStatusName ofObject:_episode change:nil context:nil];
}

// 被观察属性变化的cell回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // downloadStatus变化
    if ([keyPath isEqualToString:EpisodePropertyDownloadStatusName]) {
        
        switch ([object downloadStatus]) {
                
            case V8EpisodeDownloadStatusUnload:
                
                self.downloadButton.hidden = NO;
                self.downloadSpeedView.hidden = YES;
                self.finishDownloadbutton.hidden = YES;
                self.downloadProgressView.progress = 0;
                [self.activityView stopAnimating];
                break;
                
            case V8EpisodeDownloadStatusLoading:
                
                self.downloadButton.hidden = YES;
                self.downloadSpeedView.hidden = NO;
                self.finishDownloadbutton.hidden = YES;
                [self.activityView startAnimating];
                break;
                
            case V8EpisodeDownloadStatusLoaded:
                
                self.downloadButton.hidden = YES;
                self.downloadSpeedView.hidden = YES;
                self.finishDownloadbutton.hidden = NO;
                self.downloadProgressView.progress = 1;
                [self.activityView stopAnimating];
                break;
        }
    }
    // downloadPercent变化
    if ([keyPath isEqualToString:EpisodePropertyDownloadPercent]) {
        [self.downloadProgressView setProgress:_episode.downloadPercent animated:YES];
    }
    // downloadSpeed变化
    if ([keyPath isEqualToString:EpisodePropertyDownloadSpeed]) {
        self.downloadSpeedView.text = _episode.downloadSpeed;
    }
}

// cell进入缓存池时调用，移除观察者
- (void)prepareForReuse {
    [super prepareForReuse];
    
    [_episode removeObserver:self forKeyPath:EpisodePropertyDownloadStatusName];
    [_episode removeObserver:self forKeyPath:EpisodePropertyDownloadPercent];
    [_episode removeObserver:self forKeyPath:EpisodePropertyDownloadSpeed];
}

- (void)dealloc {
    [_episode removeObserver:self forKeyPath:EpisodePropertyDownloadStatusName];
    [_episode removeObserver:self forKeyPath:EpisodePropertyDownloadPercent];
    [_episode removeObserver:self forKeyPath:EpisodePropertyDownloadSpeed];
}

- (IBAction)onClickDownloadButton:(id)sender {
    _episode.downloadStatus = V8EpisodeDownloadStatusLoading;
    
    // 下载视频
    [_episode resumeTask];
}

@end
