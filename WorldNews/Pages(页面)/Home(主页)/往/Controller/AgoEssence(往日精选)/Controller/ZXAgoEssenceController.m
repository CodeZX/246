//
//  ZXAgoEssenceController.m
//  WangYe
//
//  Created by Mars on 2017/2/17.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXAgoEssenceController.h"
#import "ZXAgoFlowLayout.h"
#import "ZXAgoCell.h"
#import "ZXAgoEssenceItem.h"
#import "ZXEssenceWebController.h"
@interface ZXAgoEssenceController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/** collectionView */
@property(nonatomic, strong) UICollectionView *collectionView;
/** 往期数组 */
@property(nonatomic, strong) NSArray<ZXAgoEssenceInfolistItem *> *agoArr;

@end

@implementation ZXAgoEssenceController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNetManager];
    
    [self.collectionView registerClass:[ZXAgoCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 配置NetManager
- (void)configNetManager
{
    [NetManager GETAgoEssenceCompletionHandler:^(ZXAgoEssenceItem *agoItem, NSError *error) {
        self.agoArr = agoItem.infoList;
        [self.collectionView reloadData];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.agoArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXAgoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ZXAgoEssenceInfolistItem *infoItem = self.agoArr[indexPath.row];
    [cell.iconIV setImageWithURL:infoItem.object.imageRecommend.yg_URL placeholder:[UIImage imageNamed:@"placeHolder1"]];
    cell.titleLB.text = infoItem.object.title;
    if (infoItem.object.des.length == 0) {
        cell.detailLB.numberOfLines = 2;
        cell.detailLB.text = infoItem.object.descriptionRecommend;
    } else {
        cell.detailLB.numberOfLines = 2;
        cell.detailLB.text = infoItem.object.des;
    }
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXAgoEssenceInfolistItem *infoItem = self.agoArr[indexPath.row];
    ZXEssenceWebController *webVC = [[ZXEssenceWebController alloc] initWithAppView:infoItem.object.articleContentUrl];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[ZXAgoFlowLayout alloc] init]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
