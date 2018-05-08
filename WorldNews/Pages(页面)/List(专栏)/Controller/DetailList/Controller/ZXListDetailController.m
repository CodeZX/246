//
//  ZXListDetailController.m
//  WangYe
//
//  Created by Mars on 2017/2/13.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXListDetailController.h"
#import "ZXListDetailCell.h"
#import "ZXDetailListItem.h"
#import "ZXListDetailMovieController.h"
@interface ZXListDetailController ()
/** 详细页数组 */
@property(nonatomic, strong) NSMutableArray *detailArr;
/** 下一页 */
@property(nonatomic, strong) NSString *nextPage;
/** 详情模型 */
@property(nonatomic, strong) ZXDetailListItem *detailListItem;


@end

@implementation ZXListDetailController

- (instancetype)initWithListName:(NSString *)listName
{
    if (self = [super init]) {
        self.listName = listName;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉TableView的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = YGRGBColor(235, 140, 43);
    [self configNetManager];
    self.tableView.rowHeight = 200;
}

- (void)configNetManager
{
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        [NetManager GETDetailListItem:weakSelf.listName completionHandler:^(ZXDetailListItem *detailItem, NSError *error) {
            [weakSelf.tableView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMessage:@"网络出现错误, 请重试..."];
            } else {
                weakSelf.detailListItem = detailItem;
                [weakSelf.detailArr removeAllObjects];
                [weakSelf.detailArr addObjectsFromArray:detailItem.videoList];
                weakSelf.nextPage = detailItem.nextPageUrl;
                [weakSelf.tableView reloadData];
                
                if (detailItem.nextPageUrl == nil) {
                    [weakSelf.tableView endFooterWithNoMore];
                } else {
                    [weakSelf.tableView resetFooter];
                }
            }
            
        }];
    }];
    [self.tableView beginHeaderRefresh];
    [self.tableView registerClass:[ZXListDetailCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView addFooterRefresh:^{
        [NetManager GETDetailListOtherPage:weakSelf.nextPage conpletionHandler:^(ZXDetailListItem *detailItem, NSError *error) {
            [weakSelf.tableView endFooterRefresh];
            if (error) {
                [weakSelf.view showMessage:@"网络出现错误, 请重试..."];
            } else {
                weakSelf.nextPage = detailItem.nextPageUrl;
                [weakSelf.detailArr addObjectsFromArray:detailItem.videoList];
                [weakSelf.tableView reloadData];
                if (self.nextPage == nil) {
                    [weakSelf.tableView endFooterWithNoMore];
                }
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ZXDetailListVideolistItem *videoListItem = self.detailArr[indexPath.row];
    [cell.iconIV setImageWithURL:videoListItem.coverForFeed.yg_URL placeholder:[UIImage imageNamed:@"placeHolder1"]];
    
    NSString *detailLabel = [NSString stringWithFormat:@"#%@ / %02ld'%02ld\"", videoListItem.category, videoListItem.duration / 60, videoListItem.duration % 60];
    cell.detailLB.text = detailLabel;
    cell.titleLB.text = videoListItem.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXDetailListVideolistItem *videoListItem = self.detailArr[indexPath.row];
    ZXListDetailMovieController *movieVC = [[ZXListDetailMovieController alloc] initWithBgImageView:videoListItem.coverBlurred titleView:videoListItem.coverForDetail detailLabel:videoListItem.des url:videoListItem.playUrl];
    movieVC.title = videoListItem.title;
    [self.navigationController pushViewController:movieVC animated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSMutableArray *)detailArr {
    if(_detailArr == nil) {
        _detailArr = [[NSMutableArray alloc] init];
    }
    return _detailArr;
}

@end
