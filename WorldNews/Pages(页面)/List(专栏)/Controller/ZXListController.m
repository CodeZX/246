//
//  ZXListController.m
//  WangYe
//
//  Created by Mars on 2017/2/8.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXListController.h"
#import "ZXListCell.h"
#import "ZXListItem.h"
#import "ZXListDetailController.h"
@interface ZXListController ()
@property (nonatomic, strong) NSArray *listArr;
@end

@implementation ZXListController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNetManager];
    [self.collectionView registerClass:[ZXListCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
}

- (void)configNetManager
{
    [NetManager GetListItemCompletionHandler:^(NSArray<ZXListItem *> *lists, NSError *error) {
        self.listArr = lists;
        [self.collectionView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    ZXListItem *listItem = self.listArr[indexPath.row];
    [cell.iconIV setImageURL:listItem.bgPicture.yg_URL];
    cell.titLB.text = listItem.name;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake(YGScreenW - 10, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXListItem *listItem = self.listArr[indexPath.row];
    ZXListDetailController *detailVC = [[ZXListDetailController alloc] initWithListName:listItem.name];
    detailVC.title = listItem.name;
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end
