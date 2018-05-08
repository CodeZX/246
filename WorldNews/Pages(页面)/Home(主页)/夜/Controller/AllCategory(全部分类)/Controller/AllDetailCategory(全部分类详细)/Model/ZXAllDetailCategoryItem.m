//
//  ZXAllDetailCategoryItem.m
//  WangYe
//
//  Created by Mars on 2017/2/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXAllDetailCategoryItem.h"

@implementation ZXAllDetailCategoryItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"articleList":@"ZXAllDetailCategoryArticlelistItem"
             };
}

@end
@implementation ZXAllDetailCategoryArticlelistItem

@end


@implementation ZXAllDetailCategoryArticlelistObjectItem

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
            @"authorInfos":@"ZXAllDetailCategoryArticlelistObjectAuthorinfoItem"
             };
}

@end


@implementation ZXAllDetailCategoryArticlelistObjectAuthorinfoItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end


@implementation ZXAllDetailCategoryArticlelistObjectArticlesourceItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end


@implementation ZXAllDetailCategoryArticlelistObjectShareurlItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"des":@"description"
             };
}
@end


@implementation ZXAllDetailCategoryArticlelistObjectAuthorinfosItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end


