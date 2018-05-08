//
//  ZXListItem.m
//  WangYe
//
//  Created by Mars on 2017/2/13.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXListItem.h"

@implementation ZXListItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             @"des":@"description"
             };
}
@end
