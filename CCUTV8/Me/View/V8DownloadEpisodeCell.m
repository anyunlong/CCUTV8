//
//  V8DownloadEpisodeCell.m
//  CCUTV8
//
//  Created by Oneself on 16/12/24.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8DownloadEpisodeCell.h"
#import "V8DownloadVideoItem.h"

@interface V8DownloadEpisodeCell()

@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UILabel *sizeView;

@end

@implementation V8DownloadEpisodeCell

- (void)setItem:(V8DownloadVideoItem *)item {
    _item = item;
    
    self.titleView.text = item.title;
    self.timeView.text = item.time;
    self.sizeView.text = item.size;
}

@end
