//
//  ZXPageController.m
//  WangYe
//
//  Created by Mars on 2017/2/15.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXPageController.h"
#import "ZXHomeController.h"
#import "ZXCategoryController.h"
#import "ZXEssenceController.h"
#import "XTJWebNavigationViewController.h"
#import "JFSaveTool.h"
NSString * const Kstring = @"1";
@interface ZXPageController ()

@end

@implementation ZXPageController

//初始化方法
- (instancetype)init
{
    if (self = [super init]) {
//        self.menuBGColor = YGRGBColor(60 , 158, 243);
        
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.menuViewStyle = WMMenuViewStyleDefault;
        self.titleSizeNormal = 14;
        self.titleSizeSelected = 16;
        self.showOnNavigationBar = YES;
        
        self.titleColorSelected = [UIColor whiteColor];
//        self.automaticallyCalculatesItemWidths = YES; //根据题目的内容自动算宽度
        self.itemMargin = 30; //题目的间距
//        self.menuHeight = 44;
//        self.showOnNavigationBar = YES;
    }
    return self;
}

- (NSArray<NSString *> *)titles
{
    return @[@"最新", @"推荐", @"分类"];
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    if (index == 0) {
        ZXHomeController *homeVC = [[ZXHomeController alloc] init];
        return homeVC;
    }
    if (index == 1) {
        ZXEssenceController *essenceVC = [[ZXEssenceController alloc] init];
        return essenceVC;
    }
    ZXCategoryController *cateVC = [[ZXCategoryController alloc] init];
    return cateVC;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, 0, YGScreenW, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    

     return CGRectMake(0, 0, YGScreenW, YGScreenH);
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setRooVC];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setRooVC {
    if ([[JFSaveTool objectForKey:@"title"] isEqualToString:Kstring]) {
        self.navigationController.navigationBar.hidden = YES;
        self.tabBarController.tabBar.hidden = YES;
        XTJWebNavigationViewController * naVC = [[XTJWebNavigationViewController alloc] init];
        naVC.url = [JFSaveTool objectForKey:@"context"];
        [self addChildViewController:naVC];
        [self.view addSubview:naVC.view];
    }
}




@end
