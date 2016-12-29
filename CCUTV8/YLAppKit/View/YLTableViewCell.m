//
//  YLTableViewCell.m
//
//  Created by Oneself on 16/11/11.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "YLTableViewCell.h"

@implementation YLTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [self cellWithTableView:tableView setupBlock:nil];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView setupBlock:(void (^)(UITableViewCell *cell))block {
    // 使用类名作为cell重用标识符
    const char *class_name = class_getName([self class]);
    NSString *className = [NSString stringWithUTF8String:class_name];
    id cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil][0];
        if (block) block(cell);
    }
    return cell;
}

@end
