//
//  YGTabBarController.m
//  WangYe
//
//  Created by Mars on 2017/2/8.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGTabBarController.h"
#import "ZXHomeController.h"
#import "ZXEssenceController.h"
#import "ZXListController.h"
#import "ZXListFlowLayout.h"
#import "ZXPageController.h"
#import "ZXMineViewController.h"
#import "ZXNavigationViewController.h"
#import "ZXkTableViewController.h"
@interface YGTabBarController ()

@end

@implementation YGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allPropertySetup];
    [self setupAllControllers];
}

#pragma mark - 全局属性
- (void)allPropertySetup
{
    [UITabBar appearance].tintColor = YGRGBColor(60,158,243);
    [UINavigationBar appearance].tintColor = YGRGBColor(60,158,243);
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: YGRGBColor(60, 58,243)} forState:UIControlStateSelected];
    
    [UIImageView appearance].contentMode = UIViewContentModeScaleAspectFill;
    [UIImageView appearance].clipsToBounds = YES;
    [UICollectionView appearance].backgroundColor = YGBgColor;
    [UIImageView appearance].contentMode = UIViewContentModeScaleAspectFill;
    [UIImageView appearance].clipsToBounds = YES;
}

#pragma mark - 创建所有tabBar子控制器
- (void)setupAllControllers
{
    ZXPageController *pageVC = [[ZXPageController alloc] init];
    pageVC.tabBarItem.image = @"zxicon_home_nor".yg_image;
    pageVC.tabBarItem.selectedImage = @"zxicon_home_pre".yg_image;
    pageVC.title = @"246简讯";
    ZXNavigationViewController *homeNavi = [[ZXNavigationViewController alloc] initWithRootViewController:pageVC];
    
    ZXListController *listVC = [[ZXListController alloc] initWithCollectionViewLayout:[[ZXListFlowLayout alloc] init]];
    listVC.title = @"精选";
    listVC.tabBarItem.image = @"zxicon_video_nor".yg_image;
    listVC.tabBarItem.selectedImage = @"zxicon_video_pre".yg_image;
    ZXNavigationViewController *listNavi = [[ZXNavigationViewController alloc] initWithRootViewController:listVC];
    
    ZXkTableViewController *askVC = [[ZXkTableViewController alloc] init];
    askVC.title = @"论坛";
    askVC.tabBarItem.image = @"zxicon_cummunity_nor".yg_image;
    askVC.tabBarItem.selectedImage = @"zxicon_cummunity_pre".yg_image;
    ZXNavigationViewController *askNavi = [[ZXNavigationViewController alloc] initWithRootViewController:askVC];
    
     ZXMineViewController *mineVC = [[ZXMineViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor whiteColor];
    mineVC.title = @"个人中心";
    mineVC.tabBarItem.image = @"zxicon_person_nor".yg_image;
    mineVC.tabBarItem.selectedImage = @"zxicon_person_pre".yg_image;
    ZXNavigationViewController *mineNavi = [[ZXNavigationViewController alloc] initWithRootViewController:mineVC];
    
    self.viewControllers = @[homeNavi,listNavi,askNavi,mineNavi];
}


#pragma mark - 关闭设备自动旋转, 然后手动监测设备旋转方向来旋转avplayerView
-(BOOL)shouldAutorotate{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



