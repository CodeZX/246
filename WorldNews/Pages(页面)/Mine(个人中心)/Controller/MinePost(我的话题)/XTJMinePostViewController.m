//
//  XTJMinePostViewController.m
//  WorldNews
//
//  Created by tunjin on 2018/5/3.
//  Copyright © 2018年 XTJ. All rights reserved.
//

#import "XTJMinePostViewController.h"
#import "ASKTableViewCell.h"
#import "DSCommitViewController.h"
#import "DSCommentDetailsViewController.h"
#import "ASKTableViewCell+CommunityItem.h"
#import "XTJCommunity.h"
#import "XTJLoginViewController.h"
//#import "DSAvatarBrowser.h"
static NSString * const kCellIdentifier = @"ASKCell.identifier";
static NSString * pageNum = @"20";


#define PIC_WIDTH 70
#define PIC_HEIGHT 80
#define COL_COUNT 3
@interface XTJMinePostViewController ()<UITableViewDelegate,UITableViewDataSource,ASKTableViewCellDelegate>

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

@implementation XTJMinePostViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化参数
    [self ds_setupTableView];
    [self.tableView.mj_header beginRefreshing];
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
        XTJLoginViewController * vc = [[XTJLoginViewController alloc] init];
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
        XTJLoginViewController * vc = [[XTJLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [NetManager POSTReportCardId:item.card_id userID:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
            [self.view showMessage:allCommunity.msg];
            [self.tableView reloadData];
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
    __weak XTJMinePostViewController * weakSelf = self;
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


#pragma mark - 网络请求
- (void)orderNetWorking {
    [NetManager POSTMyCardUserId:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJCommunity *allCommunity, NSError *error) {
        self.dataArray = allCommunity.retData ;
        [self.tableView reloadData];
        [self.tableView endHeaderRefresh];
        [self.tableView endFooterRefresh];
    }];
}




@end
