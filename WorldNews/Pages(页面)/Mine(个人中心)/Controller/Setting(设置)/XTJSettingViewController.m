//
//  XTJSettingViewController.m
//  WorldNews
//
//  Created by tunjin on 2018/5/3.
//  Copyright © 2018年 XTJ. All rights reserved.
//

#import "XTJSettingViewController.h"
#import "AppDelegate.h"
@interface XTJSettingViewController ()

@property (nonatomic, strong) UIButton * logoutButton;

@end

@implementation XTJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setFootView];
    
}

- (void)setFootView {
    [self.view addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(DEVICE_SCREEN_WIDTH - 60);
    }];
}


- (void)logoutButtonAction {
    
    [JFSaveTool setObject:@"" forKey:@"UserID"];
    [JFSaveTool setObject:@"" forKey:@"UserNameKey"];
    [JFSaveTool setObject:@"" forKey:@"UserImageUrlKey"];
    [JFSaveTool setObject:@"" forKey:@"PhoneNumberKey"];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app gotoHomePage];
}

#pragma mark - 懒加载
- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        _logoutButton.backgroundColor = RGB(0,165,234);
        _logoutButton.clipsToBounds = YES;
        _logoutButton.layer.cornerRadius = 10;
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

@end
