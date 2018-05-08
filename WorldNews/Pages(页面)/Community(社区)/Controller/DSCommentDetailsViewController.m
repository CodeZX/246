//
//  DSCommentDetailsViewController.m
//  FiftyOneCraftsman
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 Edgar_Guan. All rights reserved.
//

#import "DSCommentDetailsViewController.h"
#import "ASKTableViewCell.h"
#import "DSCommitViewController.h"
#import "UIButton+DSAdd.h"
#import "XTJLoginViewController.h"
//#import "DSAvatarBrowser.h"

static NSString * pageNum = @"20";

#define PIC_WIDTH 70
#define PIC_HEIGHT 80
#define COL_COUNT 3

static NSString * const kCellIdentifier = @"ASKCell.identifier";

@interface DSCommentDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray * dataArrays;
@property (weak, nonatomic) IBOutlet UIView *topView;



@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNeededRequest;
@end

@implementation DSCommentDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self ds_setTopView];

    [self.likeButton DS_layoutButtonWithEdgeInsetsStyle:DS_ButtonEdgeInsetsStyleTop imageTitleSpace:8 isSizeToFit:YES];
    [self.commentButton DS_layoutButtonWithEdgeInsetsStyle:DS_ButtonEdgeInsetsStyleTop imageTitleSpace:8 isSizeToFit:YES];
    if ([self.isPraise isEqualToString:@"0"]) {
        self.likeButton.selected = NO;
    }else {
        self.likeButton.selected = YES;
    }
    
    
    //初始化tableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = self.topView;
    [self.tableView registerNib:[ASKTableViewCell nib] forCellReuseIdentifier:kCellIdentifier];
    
    __weak DSCommentDetailsViewController * weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isRefreshing = YES;
        
        [weakSelf ds_netWorking];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _isRefreshing = NO;
        if (_isNeededRequest) {
            [weakSelf ds_netWorking];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }
    }];
    [self.tableView.mj_header beginRefreshing];

}


- (void)ds_setTopView {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.iconImageURL] placeholderImage:[UIImage imageNamed:@"icon_portrait40"]];
    self.iconImageView.layer.cornerRadius = 20;
    self.contentLabel.text = self.content;
    [self.contentLabel sizeToFit];
    self.commentLabel.text = [NSString stringWithFormat:@"评论(%@)",self.commentNum];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASKTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    [cell.iconImage sd_setImageWithURL:[self.dataArrays[indexPath.row] valueForKey:@"pic_url"]];
    cell.nameLabel.text = [self.dataArrays[indexPath.row] valueForKey:@"creator_id"];
    cell.timeLabel.text = [self.dataArrays[indexPath.row] valueForKey:@"create_time"];
    cell.titleLabel.text = [self.dataArrays[indexPath.row] valueForKey:@"eval_comments"];
    cell.buttonHight.constant = 1.0;
    cell.likeButton.hidden = YES;
    cell.replyButton.hidden = YES;
    
    NSArray * fileArray = [self.dataArrays[indexPath.row] valueForKey:@"fileList"];
    
    if ([fileArray count] > 0) {
        cell.fileView.hidden = NO;
        cell.imageHight.constant = (10 + PIC_HEIGHT) * ((fileArray.count - 1) / COL_COUNT + 1) + 10;
        
        [self ds_setfileImage:fileArray andView:cell.fileView];
    }else {
        cell.imageHight.constant = 1;
        
        cell.fileView.hidden = YES;
    }
    return cell;
}



- (void)ds_setfileImage:(NSArray *)fileArray andView:(UIView *)fileView {
    //    NSLog(@"%@",fileArray);
    for (NSInteger i = 0; i < fileArray.count; i++) {
        //所在行
        NSInteger row = i / COL_COUNT;
        //所在列
        NSInteger col = i % COL_COUNT;
        //间距
        CGFloat margin = (fileView.bounds.size.width - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT + 1);
        CGFloat picX = margin + (PIC_WIDTH + margin) * col;
        CGFloat picY = 10 + (PIC_HEIGHT + 10) * row;
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.layer.borderWidth = 2.0f;
        imageView.layer.borderColor = RGB(230, 230, 230).CGColor;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[fileArray[i] valueForKey:@"file_url"]]];
        [fileView addSubview:imageView];
        //允许交互
        imageView.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        imageView.frame = CGRectMake(picX, picY, PIC_WIDTH, PIC_HEIGHT);
        
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
//评论
- (IBAction)commentButtonAction:(UIButton *)sender {
    
    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
        XTJLoginViewController * vc = [[XTJLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        DSCommitViewController * vc = [[DSCommitViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = @"评论";
        vc.card_id = self.card_id;
        kPushViewController(vc);
    }
}
//点赞
- (IBAction)likeButtonAction:(UIButton *)sender {
    
    if ([[JFSaveTool objectForKey:@"UserID"] isEqualToString:@""] || [JFSaveTool objectForKey:@"UserID"] == NULL) {
        XTJLoginViewController * vc = [[XTJLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (sender.selected == NO) {
            [NetManager POSTJoinLikeCardId:self.card_id userId:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
                sender.selected = YES;
                [self.tableView reloadData];
            }];
        }else {
            [NetManager POSTDeleteLikeCardId:self.card_id userId:[JFSaveTool objectForKey:@"UserID"] completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
                sender.selected = NO;
                [self.tableView reloadData];
            }];
        }
    }}

#pragma mark - 网络请求
- (void)ds_netWorking {
    

}


- (NSMutableArray *)dataArrays {
    if (!_dataArrays) {
        _dataArrays = [NSMutableArray array];
    }
    return _dataArrays;
}
@end
