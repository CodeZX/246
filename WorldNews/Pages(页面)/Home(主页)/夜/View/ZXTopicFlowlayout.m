//
//  ZXTopicFlowlayout.m
//  WangYe
//
//  Created by Mars on 2017/2/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXTopicFlowlayout.h"

@implementation ZXTopicFlowlayout
- (instancetype)init
{
    if (self = [super init]) {
        CGFloat width = (long)(YGScreenW - 30) / 2;
        CGFloat height = width + 70;
        self.itemSize = CGSizeMake(width, height);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
@end
