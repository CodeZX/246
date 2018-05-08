//
//  DSBaseViewController.m
//  PeanutFinance
//
//  Created by FS on 2017/7/5.
//  Copyright © 2017年 徐冬苏. All rights reserved.
//

#import "XTJBaseViewController.h"
@interface XTJBaseViewController ()

@end

@implementation XTJBaseViewController

#pragma mark - life cycle method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:!self.closeAnimating];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 控制器消失时要开启动画，保证更有其他方式进入控制器会有动画
    self.closeAnimating = NO;
}



@end
