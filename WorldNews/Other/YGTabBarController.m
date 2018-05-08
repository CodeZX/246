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
#import "XTJMineViewController.h"
#import "ZXNavigationViewController.h"
#import "AskTableViewController.h"
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
    [UITabBar appearance].tintColor = YGRGBColor(67, 67, 67);
    [UINavigationBar appearance].tintColor = YGRGBColor(67, 67, 67);
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: YGRGBColor(67, 67, 67)} forState:UIControlStateSelected];
    
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
    pageVC.tabBarItem.image = @"icon_home_nor".yg_image;
    pageVC.tabBarItem.selectedImage = @"icon_home_pre".yg_image;
    pageVC.title = @"天下资讯";
    ZXNavigationViewController *homeNavi = [[ZXNavigationViewController alloc] initWithRootViewController:pageVC];
    
    ZXListController *listVC = [[ZXListController alloc] initWithCollectionViewLayout:[[ZXListFlowLayout alloc] init]];
    listVC.title = @"视频";
    listVC.tabBarItem.image = @"icon_video_nor".yg_image;
    listVC.tabBarItem.selectedImage = @"icon_video_pre".yg_image;
    ZXNavigationViewController *listNavi = [[ZXNavigationViewController alloc] initWithRootViewController:listVC];
    
    AskTableViewController *askVC = [[AskTableViewController alloc] init];
    askVC.title = @"社区";
    askVC.tabBarItem.image = @"icon_cummunity_nor".yg_image;
    askVC.tabBarItem.selectedImage = @"icon_cummunity_pre".yg_image;
    ZXNavigationViewController *askNavi = [[ZXNavigationViewController alloc] initWithRootViewController:askVC];
    
     XTJMineViewController *mineVC = [[XTJMineViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor whiteColor];
    mineVC.title = @"个人中心";
    mineVC.tabBarItem.image = @"icon_person_nor".yg_image;
    mineVC.tabBarItem.selectedImage = @"icon_person_pre".yg_image;
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



