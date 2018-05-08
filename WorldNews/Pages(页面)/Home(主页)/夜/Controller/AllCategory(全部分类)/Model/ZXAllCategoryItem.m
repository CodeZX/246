//
//  ZXAllCategoryItem.m
//  WangYe
//
//  Created by Mars on 2017/2/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ZXAllCategoryItem.h"

@implementation ZXAllCategoryItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"topicList":@"ZXAllCategoryTopiclistItem"
             };
}
@end
@implementation ZXAllCategoryTopiclistItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end


@implementation ZXAllCategoryTopiclistShareinfoItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"des":@"description"
             };
}
@end
