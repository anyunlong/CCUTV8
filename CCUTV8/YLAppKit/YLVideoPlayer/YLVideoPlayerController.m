//
//  YLVideoPlayerController.m
//
//  Created by Oneself on 16/12/18.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "YLVideoPlayerController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface YLVideoPlayerController () <VLCMediaPlayerDelegate>

@property (nonatomic, strong) VLCMediaPlayer *player;

// 用于播放视频的view
@property (weak, nonatomic) IBOutlet UIImageView *playView;
// 视频链接失效label
@property (weak, nonatomic) IBOutlet UILabel     *videoUrlErrorLabel;
@property (weak, nonatomic) IBOutlet UIControl   *mediaControl;

@property (weak, nonatomic) IBOutlet UIControl *overlay;
@property (weak, nonatomic) IBOutlet UIButton  *fullButton;
@property (weak, nonatomic) IBOutlet UISlider  *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton  *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UILabel   *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel   *totalTimeLabel;

@end

static BOOL isSliding = NO;
static BOOL isFullScreen = NO;

@implementation YLVideoPlayerController

#pragma mark - life cycle
- (instancetype)initWithVideoUrl:(NSURL *)url {
    if (self = [super init]) {
        _url = url;
    } return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupViews];
    [self setupNotifications];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player stop];
}

#pragma mark - VLCMediaPlayerDelegate
- (void)mediaPlayerStateChanged:(NSNotification *)aNotification {
    if (self.player.media.state == VLCMediaStatePlaying) {
        self.progressSlider.minimumValue = 0;
        self.progressSlider.maximumValue = self.player.media.length.value.floatValue;
        self.totalTimeLabel.text = self.player.media.length.stringValue;
    }
    if (self.player.state == VLCMediaPlayerStateEnded) {
        [self.player stop];
    }
    if (self.player.state == VLCMediaPlayerStateStopped) {
        self.currentTimeLabel.text = self.totalTimeLabel.text = @"--:--";
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    }
}

- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification {
    if (!isSliding) {
        self.progressSlider.value = self.player.time.value.floatValue;
        self.currentTimeLabel.text = self.player.time.stringValue;
    }
}

#pragma mark - event response
- (IBAction)sliderValueChanged:(id)sender {
    self.currentTimeLabel.text = [[VLCTime alloc] initWithNumber:@(_progressSlider.value)].stringValue;
}

- (IBAction)sliderTouchDown:(id)sender {
    isSliding = YES;
}

- (IBAction)sliderTouchUpInside:(id)sender {
    self.player.time = [[VLCTime alloc] initWithNumber:@(_progressSlider.value)];
    isSliding = NO;
}

- (IBAction)onClickMediaControl:(id)sender {
    self.overlay.hidden = NO;
}

- (IBAction)onClickOverlay:(id)sender {
    self.overlay.hidden = YES;
}

- (IBAction)onClickPlayOrPauseButton:(id)sender {
    if (self.player.playing) {
        [self.player pause];
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    } else {
        [self.player play];
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
    }
}

- (IBAction)closePlayer:(id)sender {
    if (isFullScreen) {
        isFullScreen = NO;
        [self forceChangeOrientation:UIInterfaceOrientationPortrait];
        self.fullButton.hidden = NO;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
 ======================================== !
 */
- (IBAction)onClickFullButton:(id)sender {
    isFullScreen = YES;
    [self forceChangeOrientation:UIInterfaceOrientationLandscapeRight];
    self.fullButton.hidden = YES;
}
/*
 ========================================
 */

#pragma mark - notification response
- (void)applicationWillEnterForegroundOperation {
    [self.player play];
}

- (void)applicationWillResignActiveOperation {
    [self.player pause];
}

#pragma mark - private methods
/*
 ======================================== !
 */
- (void)forceChangeOrientation:(UIInterfaceOrientation)orientation
{
    int val = orientation;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
/*
 ========================================
 */

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupViews {
    if (!_url) self.videoUrlErrorLabel.hidden = NO;
    
    UIImage *slidingBlockImage = [UIImage imageNamed:@"player_block"];
    [self.progressSlider setThumbImage:slidingBlockImage forState:UIControlStateHighlighted];
    [self.progressSlider setThumbImage:slidingBlockImage forState:UIControlStateNormal];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForegroundOperation)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActiveOperation)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

#pragma mark - getters and setters
- (VLCMediaPlayer *)player {
    if (!_player) {
        _player = [[VLCMediaPlayer alloc] init];
        _player.media = [[VLCMedia alloc] initWithURL:_url];
        _player.drawable = self.playView;
        _player.delegate = self;
    }
    return _player;
}

@end
