//
//  ZXAgoEssenceItem.m
//  WangYe
//
//  Created by Mars on 2017/2/17.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXAgoEssenceItem.h"

@implementation ZXAgoEssenceItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"infoList":@"ZXAgoEssenceInfolistItem"
             };
}
@end
@implementation ZXAgoEssenceInfolistItem

@end


@implementation ZXAgoEssenceInfolistObjectItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             @"des":@"description"
             };
}
@end


@implementation ZXAgoEssenceInfolistObjectArticlesourceItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end


