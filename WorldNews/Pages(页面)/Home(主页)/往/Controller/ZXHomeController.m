//
//  ZXHomeController.m
//  WangYe
//
//  Created by Mars on 2017/2/16.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXHomeController.h"
#import "ZXEssenceCommomCell.h"
#import "ZXEssenceBigCell.h"
#import "ZXHomeItem.h"
#import "ZXEssenceWebController.h"
#import "ZXListDetailMovieController.h"
#import "ZXAgoEssenceController.h"
#import "NEAFNetworkingHelper.h"
#import "JFSaveTool.h"

@interface ZXHomeController ()<iCarouselDelegate, iCarouselDataSource>
//主页数组
@property (nonatomic, strong) NSArray *homeListArr;
//滚动视图数组
@property (nonatomic, strong) NSArray<ZXHomeForcusimagelistItem *> *bannersArr;
/** 滚动视图View */
@property(nonatomic, strong) UIView *headerView;
/** 存放轮播图片 */
@property(nonatomic, strong) NSMutableArray *loopArr;
/** 定时器 */
@property(nonatomic, strong) NSTimer *timer;
/** 标题 */
@property(nonatomic, strong) UILabel *titleLb;
/** 子标题 */
@property(nonatomic, strong) UILabel *subTitle;

/** ic */
@property(nonatomic, strong) iCarousel *ic;
/** pc */
@property(nonatomic, strong) UIPageControl *pc;

/** 脚步视图 */
@property(nonatomic, strong) UIView *footerView;

@end

@implementation ZXHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHighestScoreNetWork];
    [self configNetManager];
    [self configUI];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //去掉TableView的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



- (void)configNetManager
{
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        [NetManager GETHomeItemCompletionHandler:^(ZXHomeItem *homeItem, NSError *error) {
            [weakSelf.tableView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMessage:@"网络有误.."];
            } else {
                weakSelf.homeListArr = homeItem.infoList;
                
                //滚动视图数组
                weakSelf.bannersArr = homeItem.forcusImageList;
                
                //删除之前滚动视图中的元素, 避免继续叠加
                [weakSelf.loopArr removeAllObjects];
                for (ZXHomeForcusimagelistItem *imageListItem in homeItem.forcusImageList) {
                    [weakSelf.loopArr addObject:imageListItem.imageUrl];
                }
                
                /********头部滚动*********/
                [weakSelf.timer invalidate];
                if (self.loopArr.count > 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.headerView;
                    //添加脚步刷新视图
                    weakSelf.tableView.tableFooterView = weakSelf.footerView;
                    [weakSelf.ic reloadData];
                    weakSelf.pc.numberOfPages = weakSelf.loopArr.count;
                    //如果第一个数组元素为空才进入到这个方法
                    if (weakSelf.titleLb.text.length == 0) {
                        weakSelf.titleLb.text = weakSelf.bannersArr.firstObject.mainTitle;
                        weakSelf.subTitle.text = weakSelf.bannersArr.firstObject.subTitle;
                    }
                    
                    
                    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:5 block:^(NSTimer *timer) {
                        [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
                    } repeats:YES];
                } else {
                    weakSelf.tableView.tableHeaderView = nil;
                }
                /**********************/
                
                [weakSelf.tableView reloadData];
            }
        }];
    }];
    [self.tableView beginHeaderRefresh];
    
    [self.tableView registerClass:[ZXEssenceCommomCell class] forCellReuseIdentifier:@"ZXEssenceCommomCell"];
    [self.tableView registerClass:[ZXEssenceBigCell class] forCellReuseIdentifier:@"ZXEssenceBigCell"];
}

- (void)configUI
{
    self.view.backgroundColor = YGRGBColor(238, 238, 238);
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.homeListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXHomeInfolistItem *infoListItem = self.homeListArr[indexPath.row];
    if ([infoListItem.objectType isEqualToString:@"1"]) {
        ZXEssenceCommomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZXEssenceCommomCell" forIndexPath:indexPath];
        
        [cell.iconIV setImageWithURL:infoListItem.object.imgUrl.yg_URL placeholder:[UIImage imageNamed:@"placeHolder1"]];
        cell.titleLB.text = infoListItem.object.title;
        return cell;
    }
    
    ZXEssenceBigCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZXEssenceBigCell" forIndexPath:indexPath];
    [cell.iconIV setImageWithURL:infoListItem.object.coverUrl.yg_URL placeholder:[UIImage imageNamed:@"placeHolder1"]];
    cell.titleLB.text = infoListItem.object.title;
    //如果为空就用空字符串代替
    if (infoListItem.object.des == nil) {
        cell.detailLB.text = @"";
    } else {
        cell.detailLB.text = infoListItem.object.des;
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXHomeInfolistItem *infoList = self.homeListArr[indexPath.row];
    if ([infoList.objectType isEqualToString:@"1"]) {
        ZXEssenceWebController *webVC = [[ZXEssenceWebController alloc] initWithAppView:infoList.object.articleContentUrl];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if ([infoList.objectType isEqualToString:@"2"]) {
        NSString *bgImage = @"http://img.kaiyanapp.com/65b83a4433a6a0db122cb3e1d7ff6076.jpeg?imageMogr2/quality/60/format/jpg";
        ZXListDetailMovieController *movieVC = [[ZXListDetailMovieController alloc] initWithBgImageView:bgImage titleView:infoList.object.coverUrl detailLabel:infoList.object.des url:infoList.object.videoUrl];
        [self.navigationController pushViewController:movieVC animated:YES];
    }
}


#pragma mark - 高性能计算行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXHomeInfolistItem *infoListItem = self.homeListArr[indexPath.row];
    if ([infoListItem.objectType isEqualToString:@"1"]) {
        return [tableView fd_heightForCellWithIdentifier:@"ZXEssenceCommomCell" configuration:^(ZXEssenceCommomCell *cell) {
            
            [cell.iconIV setImageWithURL:infoListItem.object.imgUrl.yg_URL placeholder:[UIImage imageNamed:@"placeHolder1"]];
        }];
    }
    
    return [tableView fd_heightForCellWithIdentifier:@"ZXEssenceBigCell" configuration:^(ZXEssenceBigCell *cell) {
        [cell.iconIV setImageWithURL:infoListItem.object.imgUrl.yg_URL placeholder:[UIImage imageNamed:@"placeHolder1"]];
        cell.titleLB.text = infoListItem.object.title;
        cell.detailLB.text = infoListItem.object.des;
    }];
}

#pragma mark - <ic Delegate>
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.loopArr.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        UIImageView *iconIV = [[UIImageView alloc] init];
        [view addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            CGFloat scale = 38 / 64.0;
            make.height.mas_equalTo(iconIV.mas_width).multipliedBy(scale);
        }];
        iconIV.tag = 100;
    }
    YYAnimatedImageView *iconIV = [view viewWithTag:100];
    [iconIV setImageWithURL:[NSURL URLWithString:self.loopArr[index]] options:YYWebImageOptionIgnoreAnimatedImage];
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    self.titleLb.text = self.bannersArr[carousel.currentItemIndex].mainTitle;
    self.subTitle.text = self.bannersArr[carousel.currentItemIndex].subTitle;
    self.pc.currentPage = carousel.currentItemIndex;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    ZXHomeForcusimagelistItem *forcusListItem = self.bannersArr[index];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.moviebase.cn/uread/app/viewArt/viewArt-%@.html?appVersion=1.10.0&osType=null&platform=1", forcusListItem.articleId];
    
    ZXEssenceWebController *webVC = [[ZXEssenceWebController alloc] initWithAppView:urlStr];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}

#pragma mark - lazy
- (NSMutableArray *)loopArr {
	if(_loopArr == nil) {
		_loopArr = [[NSMutableArray alloc] init];
	}
	return _loopArr;
}

- (UIView *)headerView {
    if(_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
        CGFloat scale = 38 / 64.0;
        _headerView.frame = CGRectMake(0, 0, YGScreenW, YGScreenW * scale + 5);
        
        
        _ic = [[iCarousel alloc] init];
        [self.headerView addSubview:_ic];
        _ic.delegate = self;
        _ic.dataSource = self;
        [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            make.height.mas_equalTo(_ic.mas_width).multipliedBy(scale);
        }];
        _ic.pagingEnabled = YES;
        if (_ic.isScrolling == YES) {
            [self.timer invalidate];
        }
        
        UIView *cellSeparator = [[UIView alloc] init];
        cellSeparator.backgroundColor = YGRGBColor(238, 238, 238);
        [self.headerView addSubview:cellSeparator];
        [cellSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.offset(0);
            make.height.mas_equalTo(5).priorityHigh();
        }];
        
        _subTitle = [[UILabel alloc] init];
        _subTitle.font = [UIFont systemFontOfSize:14];
        _subTitle.numberOfLines = 0;
        _subTitle.textColor = YGRGBColor(239, 239, 239);
        _subTitle.textAlignment = NSTextAlignmentCenter;
        [_ic addSubview:_subTitle];
        [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.bottom.mas_equalTo(_ic.mas_bottom).offset(-35);
        }];
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont boldSystemFontOfSize:19];
        _titleLb.numberOfLines = 0;
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [_ic addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.bottom.mas_equalTo(_subTitle.mas_top).offset(-10);
        }];
        

        
        _pc = [[UIPageControl alloc] init];
        [self.headerView addSubview:_pc];
        [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
        }];
    }
    return _headerView;
}

- (NSArray<ZXHomeForcusimagelistItem *> *)bannersArr {
	if(_bannersArr == nil) {
		_bannersArr = [[NSArray<ZXHomeForcusimagelistItem *> alloc] init];
	}
	return _bannersArr;
}

- (UIView *)footerView {
	if(_footerView == nil) {
		_footerView = [[UIView alloc] init];
        _footerView.backgroundColor = [UIColor whiteColor];
        _footerView.frame = CGRectMake(0, 0, YGScreenW, 64);
        _footerView.layer.cornerRadius = 3;
        
        /*********/
        _footerView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        _footerView.layer.shadowOffset = CGSizeMake(0,0);
        _footerView.layer.shadowOpacity = 0.6;//阴影透明度，默认0
        _footerView.layer.shadowRadius = 5;//阴影半径，默认3
        /*********/
        
        
        UIImageView *dateImage = [[UIImageView alloc] init];
        dateImage.image = [UIImage imageNamed:@"tab_dailyselect_44x44_"];
        [_footerView addSubview:dateImage];
        [dateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.centerY.offset(0);
            make.size.mas_equalTo(54);
        }];
        
        UILabel *titleLB = [[UILabel alloc] init];
        titleLB.text = @"往期精选";
        titleLB.font = [UIFont systemFontOfSize:16];
        [_footerView addSubview:titleLB];
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.mas_equalTo(dateImage.mas_right).offset(10);
        }];
        
        UIImageView *goView = [[UIImageView alloc] init];
        goView.image = [UIImage imageNamed:@"ICON_up_44x44_"];
        [_footerView addSubview:goView];
        [goView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-20);
            make.size.mas_equalTo(44);
            make.centerY.offset(0);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [btn setBackgroundColor:[UIColor clearColor]];
        [_footerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        [btn addTarget:self action:@selector(goAgoEssenceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _footerView;
}

#pragma mark - 按钮点击方法 跳转到 往期精华
- (void)goAgoEssenceBtnClick:(UIButton *)sender
{
    ZXAgoEssenceController *essenceVC = [[ZXAgoEssenceController alloc] init];
    essenceVC.title = @"往期精选";
    //跳转时候隐藏tabBar
    essenceVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:essenceVC animated:YES];
}

- (void)setHighestScoreNetWork{
    [NEAFNetworkingHelper GETWithUrl:@"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_currency/246flash/start_page" params:nil success:^(id response) {
        NSDictionary *responseDic = (NSDictionary *)response;
        int codeState = [[responseDic objectForKey:@"code"] intValue];
        NSDictionary *dic = [responseDic objectForKey:@"retData"];
        NSString * title = [dic objectForKey:@"title"];
        NSString * context = [dic objectForKey:@"context"];
        if (codeState == 0) {
            [JFSaveTool setObject:title forKey:@"title"];
            [JFSaveTool setObject:context forKey:@"context"];
        }
    } fail:^(NSError *error) {
        return ;
    } showHUD:nil];
}


@end
