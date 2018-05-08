//
//  ZXHomeItem.m
//  WangYe
//
//  Created by Mars on 2017/2/15.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXHomeItem.h"

@implementation ZXHomeItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"forcusImageList":@"ZXHomeForcusimagelistItem",
             @"infoList":@"ZXHomeInfolistItem"
             };
}
@end
@implementation ZXHomeInfolistItem

@end


@implementation ZXHomeInfolistObjectItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             @"des":@"description"
             };
}


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"authorInfos":@"ZXHomeInfolistObjectAuthorinfoItem"
             };
}
@end


@implementation ZXHomeInfolistObjectAuthorinfoItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             };
}
@end


@implementation ZXHomeInfolistObjectArticlesourceItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             };
}
@end


@implementation ZXHomeInfolistObjectAuthorinfosItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             };
}
@end


@implementation ZXHomeForcusimagelistItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             };
}
@end
