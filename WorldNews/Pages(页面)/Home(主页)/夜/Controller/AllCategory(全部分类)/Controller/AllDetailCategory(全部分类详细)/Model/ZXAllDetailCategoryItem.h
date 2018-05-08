//
//  ZXAllDetailCategoryItem.h
//  WangYe
//
//  Created by Mars on 2017/2/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXAllDetailCategoryArticlelistItem,ZXAllDetailCategoryArticlelistObjectItem,ZXAllDetailCategoryArticlelistObjectAuthorinfoItem,ZXAllDetailCategoryArticlelistObjectArticlesourceItem,ZXAllDetailCategoryArticlelistObjectShareurlItem,ZXAllDetailCategoryArticlelistObjectAuthorinfosItem;
@interface ZXAllDetailCategoryItem : NSObject

@property (nonatomic, copy) NSString *retMsg;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, copy) NSString *canLoadMore;

@property (nonatomic, assign) NSInteger currentPageContext;

@property (nonatomic, assign) NSInteger retCode;

@property (nonatomic, copy) NSString *requestId;

@property (nonatomic, strong) NSArray<ZXAllDetailCategoryArticlelistItem *> *articleList;

@end
@interface ZXAllDetailCategoryArticlelistItem : NSObject

@property (nonatomic, copy) NSString *objectType;

@property (nonatomic, copy) NSString *requestId;

@property (nonatomic, strong) ZXAllDetailCategoryArticlelistObjectItem *object;

@end

@interface ZXAllDetailCategoryArticlelistObjectItem : NSObject
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *praiseCount;

@property (nonatomic, copy) NSString *isPraise;
//des -> description
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *cssType;

@property (nonatomic, copy) NSString *imageProportion;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, strong) ZXAllDetailCategoryArticlelistObjectArticlesourceItem *articleSource;

@property (nonatomic, assign) NSInteger createDate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *articleContentUrl;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) ZXAllDetailCategoryArticlelistObjectShareurlItem *shareUrl;

@property (nonatomic, strong) ZXAllDetailCategoryArticlelistObjectAuthorinfoItem *authorInfo;

@property (nonatomic, copy) NSString *imgWidth;

@property (nonatomic, strong) NSArray<ZXAllDetailCategoryArticlelistObjectAuthorinfoItem *> *authorInfos;

@property (nonatomic, copy) NSString *imgHeight;

@property(nonatomic, strong) NSString *sourceAuthor;

@property(nonatomic, strong) NSString *coverUrl;

@property(nonatomic, strong) NSString *videoUrl;




@end

@interface ZXAllDetailCategoryArticlelistObjectAuthorinfoItem : NSObject
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *authorName;

@end

@interface ZXAllDetailCategoryArticlelistObjectArticlesourceItem : NSObject

@property (nonatomic, copy) NSString *headImgUrl;
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *nickname;

@end

@interface ZXAllDetailCategoryArticlelistObjectShareurlItem : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *title;
//des -> description
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *imageUrlSrc;

@property (nonatomic, copy) NSString *image;

@end

@interface ZXAllDetailCategoryArticlelistObjectAuthorinfosItem : NSObject
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *authorName;

@end

