//
//  XTJWebNavigationViewController.m
//  FiftyOneCraftsman
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 Edgar_Guan. All rights reserved.
//

#import "XTJWebNavigationViewController.h"
#import "ATJWebViewController.h"
#import "UIImage+Extension.h"

//RGB 颜色
#define KRGBA(r,g,b,a)  [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

#define RGB(r,g,b) KRGBA(r,g,b,1.0f)

@interface XTJWebNavigationViewController ()

@end

@implementation XTJWebNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ATJWebViewController *webVC = [[ATJWebViewController alloc] init];
        [webVC loadWebURLSring:self.url];
    [self pushViewController:webVC animated:YES];

}

@end
