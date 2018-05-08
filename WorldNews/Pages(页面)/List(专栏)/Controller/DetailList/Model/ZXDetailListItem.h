//
//  ZXDetailListItem.h
//  WangYe
//
//  Created by Mars on 2017/2/13.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXDetailListVideolistItem,ZXDetailListVideolistConsumptionItem,ZXDetailListVideolistAuthorItem,ZXDetailListVideolistAuthorFollowItem,ZXDetailListVideolistProviderItem,ZXDetailListVideolistPlayinfoItem,ZXDetailListVideolistPlayinfoUrllistItem;
@interface ZXDetailListItem : NSObject

@property (nonatomic, strong) NSArray<ZXDetailListVideolistItem *> *videoList;

@property (nonatomic, copy) NSString *nextPageUrl;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger total;

@end
@interface ZXDetailListVideolistItem : NSObject

@property (nonatomic, copy) NSString *shareAdTrack;

@property (nonatomic, copy) NSString *coverBlurred;

@property (nonatomic, assign) long long releaseTime;

@property (nonatomic, copy) NSString *dataType;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *webAdTrack;

@property (nonatomic, strong) NSArray<ZXDetailListVideolistPlayinfoItem *> *playInfo;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *favoriteAdTrack;

@property (nonatomic, copy) NSString *rawWebUrl;

@property (nonatomic, assign) BOOL collected;

@property (nonatomic, copy) NSString *webUrlForWeibo;

@property (nonatomic, copy) NSString *coverForFeed;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, strong) ZXDetailListVideolistConsumptionItem *consumption;

@property (nonatomic, assign) BOOL played;

@property (nonatomic, copy) NSString *waterMarks;

@property (nonatomic, copy) NSString *type;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) long long date;

@property (nonatomic, copy) NSString *coverForDetail;

@property (nonatomic, copy) NSString *label;

@property (nonatomic, copy) NSString *playUrl;

@property (nonatomic, copy) NSString *promotion;

@property (nonatomic, copy) NSString *coverForSharing;

@property (nonatomic, strong) ZXDetailListVideolistProviderItem *provider;

@property (nonatomic, copy) NSString *adTrack;

@property (nonatomic, copy) NSString *campaign;

@property (nonatomic, strong) ZXDetailListVideolistAuthorItem *author;
//des -> description
@property (nonatomic, copy) NSString *des;

@end

@interface ZXDetailListVideolistConsumptionItem : NSObject

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, assign) NSInteger shareCount;

@property (nonatomic, assign) NSInteger collectionCount;

@end

@interface ZXDetailListVideolistAuthorItem : NSObject

@property (nonatomic, strong) ZXDetailListVideolistAuthorFollowItem *follow;

@property (nonatomic, assign) NSInteger videoNum;

@property (nonatomic, assign) long long latestReleaseTime;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *adTrack;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *authorType;
//des -> description
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@end

@interface ZXDetailListVideolistAuthorFollowItem : NSObject

@property (nonatomic, assign) NSInteger itemId;

@property (nonatomic, assign) BOOL followed;

@property (nonatomic, copy) NSString *itemType;

@end

@interface ZXDetailListVideolistProviderItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *icon;

@end

@interface ZXDetailListVideolistPlayinfoItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, strong) NSArray<ZXDetailListVideolistPlayinfoUrllistItem *> *urlList;

@end

@interface ZXDetailListVideolistPlayinfoUrllistItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

@end

