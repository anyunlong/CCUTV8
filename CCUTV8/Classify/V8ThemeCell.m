//
//  V8ThemeCell.m
//  CCUTV8
//
//  Created by Oneself on 16/12/22.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8ThemeCell.h"
#import "V8Theme.h"

@interface V8ThemeCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation V8ThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTheme:(V8Theme *)theme {
    _theme = theme;
    
    self.nameLabel.text = _theme.name;
}

@end
