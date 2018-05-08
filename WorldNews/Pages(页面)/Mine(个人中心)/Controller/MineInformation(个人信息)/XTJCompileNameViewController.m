//
//  XTJCompileNameViewController.m
//  PeanutFinance
//
//  Created by hcios on 2017/8/5.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "XTJCompileNameViewController.h"
#import "XTJCompileNameTableViewCell.h"
#define KBGColor RGB(242, 242, 242)


@interface XTJCompileNameViewController ()<UITableViewDelegate,UITableViewDataSource,XTJCompileNameTableViewCellDelegate>


@property (strong, nonatomic) UITableView * tableView;

@property( nonatomic, strong) UIView * footView;///<

@property( nonatomic, copy) NSString * userName;///< 用户姓名

@end

static NSString * const kCellIdentifier = @"CompileNameCell.identifier";

@implementation XTJCompileNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupNavBar];
    self.title = @"编辑姓名";
    
    self.view.backgroundColor = KBGColor;
    
    [self jf_setupTableView];
}


#pragma mark - private method
- (void)jf_setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];

    self.tableView.estimatedSectionHeaderHeight = 20;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = KBGColor;
    self.tableView.bounces = NO;
    self.tableView.rowHeight = 54;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[XTJCompileNameTableViewCell nib] forCellReuseIdentifier:kCellIdentifier];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footView;

}

#pragma mark -  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XTJCompileNameTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

-(void)jfTextFieldWithText:(NSString *)text{
    self.userName = text;
}

- (void)setupNavBar{
    UIEdgeInsets contentEdgeInset = UIEdgeInsetsMake(10, 0, 10, -5);
    
    UIBarButtonItem * rightItem = [UIBarButtonItem itemWithtitle:@"保存" color:RGB(255, 255, 255) Highlighted:RGB(255, 255, 255) style:@"PingFangSC-Regular" size:17 contentEdgeInsets:contentEdgeInset Target:self action:@selector(didClickExitBtn:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


#pragma mark - 保存按钮点击事件
- (void)didClickExitBtn:(UIButton *)btn{
    if (self.userName != nil) {
        [self.view showMessage:@""];
        [self netWorking];
    }else{
        [self setShowErrorWithTitle:@"您需要填写昵称~"];
    }
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - 网络请求
-(void)netWorking{
//    NSDictionary * parameters = @{@"userName":self.userName};
//
//    [[JFNetworking manager] post:kXGNaemURL parameters:parameters progress:nil success:^(JFNetworkingSuccessResponse * _Nonnull response) {
//
//        NSString * message = response.responseObject[@"message"];
//        NSNumber * code = response.responseObject[@"code"];
//
//        if ([code.description isEqualToString:kCODESUCCESS]) {
//
//            [JFSaveTool setObject:self.userName forKey:JFuserNameKey];
//
//            [MBProgressHUD showSuccess:@"修改成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUD];
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeLogout" object:nil];
//
//        }else if([code.description isEqualToString:kCODECONFLICT]) {
//
//            [JFSaveTool setObject:nil forKey:JFLoginStatedKey];
//
//            [JFSaveTool setObject:@"" forKey:JFAuthorizationKey];
//            [JFSaveTool setObject:@"" forKey:JFIsBindManagerKey];
//
//            NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"currentImage.jpg"];
//            NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:DocumentsPath];
//            for (NSString *fileName in enumerator) {
//                [[NSFileManager defaultManager] removeItemAtPath:[DocumentsPath stringByAppendingPathComponent:fileName] error:nil];
//            }
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:KChangeLogout object:nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KChangeLoginType object:nil];
//
//            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"账号异常" message:message preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                [self.navigationController popToRootViewControllerAnimated:YES];
//
//                JFLog(@"取消");
//
//            }]];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//
//                JFLoginNavControllerViewController * loginVC = [[JFLoginNavControllerViewController alloc] init];
//                [self presentViewController:loginVC animated:YES completion:^{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }];
//                JFLog(@"重新登录");
//
//            }]];
//
//            [self presentViewController:alertController animated:YES completion:nil];
//
//        }else{
//            [self setShowErrorWithTitle:message];
//        }
//        JFLog(@"%@", response.responseObject);
//
//    } failed:^(JFNetworkingFailureResponse * _Nonnull response) {
//        [self setShowErrorWithTitle:kNetworkTimeOut];
//        JFLog(@"%@", response.userInfo);
//    } finished:^{
//        [MBProgressHUD hideHUDForView:self.view];
//    }];
}

//错误时的提示
-(void)setShowErrorWithTitle:(NSString *)title{
    
    [self.view showMessage:title];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideHUD];
    });
}

- (void)didPans:(UITapGestureRecognizer *)pans{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - 懒加载

-(UIView *)footView{
    if (!_footView) {
        
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT * 0.66)];
        _footView.backgroundColor = KBGColor;
        UITapGestureRecognizer * pans = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPans:)];
        [_footView addGestureRecognizer:pans];
        [self.view addSubview:_footView];
        
    }
    return _footView;
}


@end
