//
//  AskTableViewController.m
//  FiftyOneCraftsman
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 Edgar_Guan. All rights reserved.
//

#import "ZXkTableViewController.h"
#import "ASKTableViewCell.h"
#import "ZXCommitViewController.h"
#import "DSCommentDetailsViewController.h"
#import "ASKTableViewCell+CommunityItem.h"
#import "XTJCommunity.h"
#import "ZXLoginViewController.h"
//#import "DSAvatarBrowser.h"
static NSString * const kCellIdentifier = @"ASKCell.identifier";
static NSString * pageNum = @"20";


#define PIC_WIDTH 70
#define PIC_HEIGHT 80
#define COL_COUNT 3

@interface ZXkTableViewController ()<UITableViewDelegate,UITableViewDataSource,ASKTableViewCellDelegate>

@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic,strong) UIButton * addButton;

@property (nonatomic, assign) NSInteger status;   ///< 状态
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrays;  ///< 数据源数组

@property (nonatomic ,strong) NSString * eval_id; ///< 问一问分类

@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNeededRequest;
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation ZXkTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化参数
    [self ds_setupTableView];
    [self.tableView.mj_header beginRefreshing];
    [self ds_setFootView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASKTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.likeButton.tag = indexPath.row;
    cell.reportButton.tag = indexPath.row;
    XTJCommunity_retData * item = self.dataArray[indexPath.row];
    [cell configCellWithModel:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DSCommentDetailsViewController * vc = [[DSCommentDetailsViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"评论详情";
    XTJCommunity_retData * item = self.dataArray[indexPath.row];
    
    vc.card_id = item.card_id;
    
    vc.isPraise = item.is_like;
    vc.iconImageURL = item.user_pic;
    vc.content = item.title;
    vc.commentNum = item.comment;
    kPushViewController(vc);
}


//点赞按钮
- (void)likeButtonAction:(UIButton *)button {
    XTJCommunity_retData * item = self.dataArray[button.tag];
    
    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
        ZXLoginViewController * vc = [[ZXLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (button.selected == NO) {
            [NetManager POSTJoinLikeCardId:item.card_id userId:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
                button.selected = YES;
                
                [self.tableView reloadData];
            }];
        }else {
            [NetManager POSTDeleteLikeCardId:item.card_id userId:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
                button.selected = NO;
                [self.tableView reloadData];
            }];
        }
    }
}

//举报
- (void)reportButtonAction:(UIButton *)button {
    
    XTJCommunity_retData * item = self.dataArray[button.tag];
    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
        ZXLoginViewController * vc = [[ZXLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [NetManager POSTReportCardId:item.card_id userID:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
            [self.view showMessage:allCommunity.msg];
        }];
    }
}

#pragma mark - private method
- (void)ds_setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT+STATUSBAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[ASKTableViewCell nib] forCellReuseIdentifier:kCellIdentifier];
    __weak ZXkTableViewController * weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isRefreshing = YES;
        
        [weakSelf orderNetWorking];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _isRefreshing = NO;
        if (_isNeededRequest) {
            [weakSelf orderNetWorking];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }
    }];
    [self.view addSubview:self.tableView];
    
}

//提问按钮
- (void)ds_setFootView {
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-TABBAR_HEIGHT-30);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
}

- (void)tiwenButtonAction:(UIButton *)button {

    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
        ZXLoginViewController * vc = [[ZXLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ZXCommitViewController * vc = [[ZXCommitViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = @"提问";
        kPushViewController(vc);
    }
}

#pragma mark - 网络请求
- (void)orderNetWorking {
    
        if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
            [NetManager GETAllCommunityID:@"" completionHandler:^(XTJCommunity *allCommunity, NSError *error) {
                self.dataArray = allCommunity.retData ;
                [self.tableView reloadData];
                [self.tableView endHeaderRefresh];
                [self.tableView endFooterRefresh];
            }];
        }else {
            [NetManager GETAllCommunityID:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJCommunity *allCommunity, NSError *error) {
                self.dataArray = allCommunity.retData ;
                [self.tableView reloadData];
                [self.tableView endHeaderRefresh];
                [self.tableView endFooterRefresh];
            }];
        }
    

}

#pragma mark - 懒加载
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_addButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.backgroundColor = YGRGBColor(60 , 158, 243);
        [_addButton addTarget:self action:@selector(tiwenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.layer.cornerRadius = 25;
        _addButton.clipsToBounds = YES;
    }
    return _addButton;
}


@end
