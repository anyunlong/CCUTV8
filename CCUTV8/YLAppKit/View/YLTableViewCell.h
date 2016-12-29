//
//  YLTableViewCell.h
//
//  Created by Oneself on 16/11/11.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface YLTableViewCell : UITableViewCell

#pragma mark 初始化方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 返回一个可重用cell，初始化后可执行一个block

 @param tableView table
 @param block 初始化后的block回调
 @return 可重用cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView setupBlock:(void (^)(UITableViewCell * cell))block;

@end
