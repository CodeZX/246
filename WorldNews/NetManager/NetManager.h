//
//  NetManager.h
//  WangYe
//
//  Created by Mars on 2017/2/7.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "BaseNetManager.h"
#import "ZXEssenceItem.h"
#import "ZXListItem.h"
#import "ZXDetailListItem.h"
#import "ZXHomeItem.h"
#import "ZXAgoEssenceItem.h"
#import "ZXCategoryItem.h"
#import "ZXAllCategoryItem.h"
#import "ZXAllDetailCategoryItem.h"
#import "XTJCommunity.h"
#import "XTJRegisterItem.h"
#import "XTJLoginItem.h"
#import "XTJMineItem.h"
@interface NetManager : BaseNetManager

//注册
+ (id)POSTRegisterPhone:(NSString *)phone pwd:(NSString *)pwd completionHandler:(void(^)(XTJRegisterItem *essences, NSError *error))completionHandler;

//登录
+ (id)POSTloginPhone:(NSString *)phone pwd:(NSString *)pwd completionHandler:(void(^)(XTJLoginItem *essences, NSError *error))completionHandler;

//精华页
+ (id)GETEssenceItem:(NSString *)lastKey completionHandler:(void(^)(ZXEssenceItem *essences, NSError *error))completionHandler;
//栏目列表
+ (id)GetListItemCompletionHandler:(void(^)(NSArray<ZXListItem *> *lists, NSError *error))completionHandler;
//栏目详细列表
+ (id)GETDetailListItem:(NSString *)detailName completionHandler:(void(^)(ZXDetailListItem *detailItem, NSError *error))completionHandler;
//栏目详细刷新页
+ (id)GETDetailListOtherPage:(NSString *)path conpletionHandler:(void(^)(ZXDetailListItem *detailItem, NSError *error))completionHandler;

//往
+ (id)GETHomeItemCompletionHandler:(void(^)(ZXHomeItem *homeItem, NSError *error))completionHandler;

//往 往期精选
+ (id)GETAgoEssenceCompletionHandler:(void(^)(ZXAgoEssenceItem *agoItem, NSError *error))completionHandler;

//夜
+ (id)GETCategoryItemCompletionHandler:(void(^)(ZXCategoryItem *cateItem, NSError *error))complteionHandler;

//夜 全部分类
+ (id)GETAllCategory:(NSInteger)page completionHandler:(void(^)(ZXAllCategoryItem *allCategoryItem, NSError *error))completionHandler;

//夜 全部分类 全部分类
+ (id)GETAllDetailCategory:(NSInteger)page ID:(NSString *)ID completionHandler:(void(^)(ZXAllDetailCategoryItem *allDetailCategoryItem, NSError *error))completionHandler;

//社区所有帖子
+ (id)GETAllCommunityID:(NSString *)ID completionHandler:(void(^)(XTJCommunity *allCommunity, NSError *error))completionHandler;

//举报帖子
+ (id)POSTReportCardId:(NSString *)cardId userID:(NSString *)userId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler;

//删除帖子
+ (id)POSTDeleteCardId:(NSString *)cardId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler;

//帖子点赞
+ (id)POSTJoinLikeCardId:(NSString *)cardId userId:(NSString *)userId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler;

//帖子取消点赞
+ (id)POSTDeleteLikeCardId:(NSString *)cardId userId:(NSString *)userId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler;

//发帖
+ (id)POSTUploadUserId:(NSString *)userId title:(NSString *)title text:(NSString *)text pic:(NSString *)pic completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler;


//个人中心
+ (id)POSTPersonalID:(NSString *)userID completionHandler:(void(^)(XTJMineItem *essences, NSError *error))completionHandler;

//我的话题
+ (id)POSTMyCardUserId:(NSString *)userId completionHandler:(void(^)(XTJCommunity *allCommunity, NSError *error))completionHandler;

//修改用户资料
+ (id)POSTModifyUserId:(NSString *)userId name:(NSString *)name pic:(NSString *)pic completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler;
//反馈
+ (id)POSTFeedBackUserId:(NSString *)userId comments:(NSString *)comments completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler;

@end
