//
//  XTJMineViewController.m
//  TJShop
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "ZXMineViewController.h"
#import "XTJMineHeaderView.h"
#import "XTJMine.h"
#import "XTJMineTableViewCell.h"
#import "XTJMineTableViewCell+XTJMine.h"
#import "XTJMineInformationViewController.h"
#import "ZXMinePostViewController.h"
#import "XTJFeedBackViewController.h"
#import "XTJSettingViewController.h"
#import "ZXLoginViewController.h"

@interface ZXMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) XTJMineHeaderView * headerView;
@property (nonatomic, strong) NSArray * dataArray;  ///< 数据源数组

@end

@implementation ZXMineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorking];
    [self setHeadView];

    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self netWorking];
    [self.view addSubview:self.tableView];

}

- (void)setHeadView {
    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
        
        self.headerView.iconImageView.image = [UIImage imageNamed:@"icon_portrait80"];
        self.headerView.nameLabel.text = @"请登录";
        
        //给头像添加手势
        self.headerView.iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickTap)];
        [singleTapGestureRecognizer setNumberOfTapsRequired:1];
        [self.headerView.iconImageView addGestureRecognizer:singleTapGestureRecognizer];
    }else {
        self.headerView.nameLabel.text = [JFSaveTool objectForKey:@"UserNameKey"];
        [self.headerView.iconImageView sd_setImageWithURL:[NSURL URLWithString:[JFSaveTool objectForKey:@"UserImageUrlKey"]] placeholderImage:[UIImage imageNamed:@"icon_portrait80"]];
        
    }
}

- (void)didClickTap {
    ZXLoginViewController * vc = [[ZXLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTJMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XTJMine * mine = self.dataArray[indexPath.item];
    [cell configCellWithModel:mine];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
        ZXLoginViewController * vc = [[ZXLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        switch (indexPath.row) {
            case 0:
            {
                XTJMineInformationViewController * vc = [[XTJMineInformationViewController alloc] init];
                vc.title = @"我的信息";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                ZXMinePostViewController * vc = [[ZXMinePostViewController alloc] init];
                vc.title = @"我的话题";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                XTJFeedBackViewController * vc = [[XTJFeedBackViewController alloc] init];
                vc.title = @"意见反馈";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                XTJSettingViewController * vc = [[XTJSettingViewController alloc] init];
                vc.title = @"设置";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }

    
   
}

#pragma mark - 网络请求
- (void)netWorking {
    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {

    }else {
        [NetManager POSTPersonalID:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJMineItem *essences, NSError *error) {
            if ([essences.code isEqualToString:@"0"]) {
                [JFSaveTool setObject:essences.retData.name forKey:@"UserNameKey"];
                [JFSaveTool setObject:essences.retData.profile_pic forKey:@"UserImageUrlKey"];
                [JFSaveTool setObject:essences.retData.phone_num forKey:@"PhoneNumberKey"];
            }
        }];
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[XTJMineTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        
    }
    return _tableView;
}

- (XTJMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[XTJMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 180)];
        _headerView.iconImageView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Mine.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mineArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            XTJMine *mine = [XTJMine mineWithDict:dict];
            [mineArray addObject:mine];
        }
        _dataArray = mineArray;
    }
    return _dataArray;
}

@end
