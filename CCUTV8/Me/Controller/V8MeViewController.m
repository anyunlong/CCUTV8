//
//  V8MeViewController.m
//  CCUTV8
//
//  Created by Oneself on 16/12/22.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "V8MeViewController.h"

@interface V8MeViewController ()

@end

@implementation V8MeViewController

+ (instancetype)getAInstance {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [board instantiateViewControllerWithIdentifier:@"me"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    
    [self.navigationItem hiddenNextBackItemTitle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
