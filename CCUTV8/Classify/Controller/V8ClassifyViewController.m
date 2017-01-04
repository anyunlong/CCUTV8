//
//  V8ClassifyViewController.m
//  CCUTV8
//
//  Created by Oneself on 16/12/22.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "V8ClassifyViewController.h"
#import "V8EpisodeListViewController.h"
// v
#import "KTDropdownMenuView.h"
#import "V8ThemeCell.h"
// m
#import "V8Theme.h"

@interface V8ClassifyViewController ()

@property (nonatomic, strong) NSMutableArray *themes;

@property (nonatomic, strong) UIBarButtonItem *v8LogoItem;
@property (nonatomic, strong) KTDropdownMenuView *menuView;
@property (nonatomic, strong) UIImageView *ccutLogoView;

@end

@implementation V8ClassifyViewController

static NSString *const reuseIdentifier = @"theme";

#pragma mark - life cycle
- (instancetype)init {
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 每个cell的尺寸
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 3, 50);
    // 设置cell之间的水平间距
    layout.minimumInteritemSpacing = 0;
    // 设置cell之间的垂直间距
    layout.minimumLineSpacing = 0;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.bounces = NO;
    [self.view insertSubview:self.ccutLogoView belowSubview:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItems];
    
    UINib *nib = [UINib nibWithNibName:@"V8ThemeCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.ccutLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.8, SCREEN_WIDTH * 0.8));
    }];
    
    [self loadThemes];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.themes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    V8ThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.theme = self.themes[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    V8EpisodeListViewController *themeC = [[V8EpisodeListViewController alloc] init];
    V8Theme *theme = _themes[indexPath.row];
    themeC.themeName = theme.name;
    [self.navigationController pushViewController:themeC animated:YES];
}

#pragma mark - private methods
- (void)setupNavigationItems {
    self.navigationItem.leftBarButtonItem = self.v8LogoItem;
    self.navigationItem.titleView = self.menuView;
    
    [self.navigationItem hiddenNextBackItemTitle];
}

- (void)loadThemes {
    [YLNetTool getWithURL:@"cartoons"
               parameters:nil
                  success:^(id responseObject) {
                      self.themes = [V8Theme mj_objectArrayWithKeyValuesArray:responseObject[@"cartoons"]];
                      [self.collectionView reloadData];
                  }
                  failure:^(NSError *error) {
                      debugLog(@"%@", error);
                  }];
}

#pragma mark - getters and setters
- (UIImageView *)ccutLogoView {
    if (!_ccutLogoView) {
        UIImageView *ccutLogoView = [[UIImageView alloc] init];
        ccutLogoView.alpha = 0.1;
        ccutLogoView.image = [UIImage imageNamed:@"CCUT_logo"];
        _ccutLogoView = ccutLogoView;
    } return _ccutLogoView;
}

- (UIBarButtonItem *)v8LogoItem {
    if (!_v8LogoItem) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _v8LogoItem = [UIBarButtonItem itemWithCustomView:imageView];
    } return _v8LogoItem;
}

- (KTDropdownMenuView *)menuView {
    if (!_menuView) {
        NSArray *titles = @[@"动漫"];
        KTDropdownMenuView *menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0, 100, YLNavigationBarHeight) titles:titles];
        menuView.textFont = [UIFont fontWithName:@"Helvetica Light" size:16];
        menuView.backgroundAlpha = 0.7;
        menuView.width = SCREEN_WIDTH * 0.7;
        _menuView = menuView;
    } return _menuView;
}

@end
