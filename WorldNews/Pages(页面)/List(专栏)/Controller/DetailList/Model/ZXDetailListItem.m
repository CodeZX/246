//
//  ZXDetailListItem.m
//  WangYe
//
//  Created by Mars on 2017/2/13.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXDetailListItem.h"

@implementation ZXDetailListItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"videoList":@"ZXDetailListVideolistItem"
             };
}
@end
@implementation ZXDetailListVideolistItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"playInfo":@"ZXDetailListVideolistPlayinfoItem"
             };
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             @"des":@"description"
             };
}
@end


@implementation ZXDetailListVideolistConsumptionItem

@end


@implementation ZXDetailListVideolistAuthorItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             @"des":@"description"
             };
}
@end


@implementation ZXDetailListVideolistAuthorFollowItem

@end


@implementation ZXDetailListVideolistProviderItem

@end


@implementation ZXDetailListVideolistPlayinfoItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"urlList":@"ZXDetailListVideolistPlayinfoUrllistItem"
             };
}
@end


@implementation ZXDetailListVideolistPlayinfoUrllistItem

@end

