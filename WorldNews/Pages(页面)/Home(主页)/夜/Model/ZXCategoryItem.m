//
//  ZXCategoryItem.m
//  WangYe
//
//  Created by Mars on 2017/2/17.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXCategoryItem.h"

@implementation ZXCategoryItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"topicRecommendList":@"ZXCategoryTopicrecommendlistItem",
             @"authorList":@"ZXCategoryAuthorlistItem",
             @"articleList":@"ZXCategoryArticlelistItem"
             };
}
@end
@implementation ZXCategoryArticlelistItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end


@implementation ZXCategoryAuthorlistItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             @"des":@"description"
             };
}
@end


@implementation ZXCategoryTopicrecommendlistItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end

