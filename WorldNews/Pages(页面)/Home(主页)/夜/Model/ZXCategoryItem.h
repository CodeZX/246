//
//  ZXCategoryItem.h
//  WangYe
//
//  Created by Mars on 2017/2/17.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXCategoryArticlelistItem,ZXCategoryAuthorlistItem,ZXCategoryTopicrecommendlistItem;
@interface ZXCategoryItem : NSObject


@property (nonatomic, strong) NSArray<ZXCategoryTopicrecommendlistItem *> *topicRecommendList;

@property (nonatomic, copy) NSString *retMsg;

@property (nonatomic, assign) NSInteger topicSubscribeUpdateNum;

@property (nonatomic, assign) NSInteger articleSubscribeUpdateNum;

@property (nonatomic, copy) NSString *topicSubscribeUpdateList;

@property (nonatomic, strong) NSArray<ZXCategoryAuthorlistItem *> *authorList;

@property (nonatomic, strong) NSArray<ZXCategoryArticlelistItem *> *articleList;

@property (nonatomic, assign) NSInteger retCode;

@property (nonatomic, copy) NSString *requestId;

@property (nonatomic, strong) NSArray *sourceList;

@end
@interface ZXCategoryArticlelistItem : NSObject
//id - > ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *articleContentUrl;

@property (nonatomic, copy) NSString *praiseCount;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *sourceName;

@property (nonatomic, copy) NSString *articleUrl;

@property (nonatomic, copy) NSString *sourceId;

@end

@interface ZXCategoryAuthorlistItem : NSObject
//id - > ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *nickname;
//des -> description
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *logo;

@end

@interface ZXCategoryTopicrecommendlistItem : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger isSubscribe;

@property (nonatomic, assign) NSInteger subscribeNum;
//id - > ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger articlesNum;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *recommendImgUrl;

@property (nonatomic, copy) NSString *headImgUrl;

@property (nonatomic, copy) NSString *desc;

@end

