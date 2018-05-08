//
//  ZXAgoEssenceItem.h
//  WangYe
//
//  Created by Mars on 2017/2/17.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXAgoEssenceInfolistItem,ZXAgoEssenceInfolistObjectItem,ZXAgoEssenceInfolistObjectArticlesourceItem;
@interface ZXAgoEssenceItem : NSObject

@property (nonatomic, copy) NSString *retMsg;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, copy) NSString *canLoadMore;

@property (nonatomic, assign) NSInteger currentPageContext;

@property (nonatomic, strong) NSArray<ZXAgoEssenceInfolistItem *> *infoList;

@property (nonatomic, assign) NSInteger retCode;

@property (nonatomic, copy) NSString *requestId;

@end
@interface ZXAgoEssenceInfolistItem : NSObject

@property (nonatomic, strong) ZXAgoEssenceInfolistObjectItem *object;

@property (nonatomic, copy) NSString *objectType;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *month;

@property (nonatomic, copy) NSString *containerId;

@property (nonatomic, copy) NSString *requestId;

@property (nonatomic, assign) NSInteger createDay;

@end

@interface ZXAgoEssenceInfolistObjectItem : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *imageRecommend;

@property (nonatomic, strong) ZXAgoEssenceInfolistObjectArticlesourceItem *articleSource;
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *isRecommend;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *articleContentUrl;

@property (nonatomic, copy) NSString *keyword;
//des -> description
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *requestId;

@property (nonatomic, copy) NSString *descriptionRecommend;

@end

@interface ZXAgoEssenceInfolistObjectArticlesourceItem : NSObject

@property (nonatomic, copy) NSString *headImgUrl;
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *nickname;

@end

