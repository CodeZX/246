//
//  ZXAllCategoryCell.h
//  WangYe
//
//  Created by Mars on 2017/2/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXAllCategoryCell : UICollectionViewCell
/** 图片 */
@property(nonatomic, strong) UIImageView *iconIV;
/** 标题 */
@property(nonatomic, strong) UILabel *titleLB;
//有多少内容
@property (nonatomic, strong) UILabel *numberContent;
@property (nonatomic, strong) UIView *bgView;
@end
