//
//  NetManager.m
//  WangYe
//
//  Created by Mars on 2017/2/7.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

//注册
+ (id)POSTRegisterPhone:(NSString *)phone pwd:(NSString *)pwd completionHandler:(void(^)(XTJRegisterItem *essences, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/user/register";
    
    NSDictionary * param = @{@"phone_num":phone,@"pwd":pwd};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

//登录
+ (id)POSTloginPhone:(NSString *)phone pwd:(NSString *)pwd completionHandler:(void(^)(XTJLoginItem *essences, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/user/login";
    
    NSDictionary * param = @{@"phone_num":phone,@"pwd":pwd};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJLoginItem Parse:obj], error);
    }];

}



+ (id)GETEssenceItem:(NSString *)lastKey completionHandler:(void (^)(ZXEssenceItem *, NSError *))completionHandler
{
    NSString *path = [NSString stringWithFormat:@"http://app3.qdaily.com/app3/homes/index/%@.json?",lastKey];
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXEssenceItem Parse:obj], error);
    }];
}

+ (id)GetListItemCompletionHandler:(void (^)(NSArray<ZXListItem *> *, NSError *))completionHandler
{
    NSString *path = @"http://baobab.kaiyanapp.com/api/v3/categories.Bak";
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXListItem Parse:obj], error);
    }];
}

+ (id)GETDetailListItem:(NSString *)detailName completionHandler:(void (^)(ZXDetailListItem *, NSError *))completionHandler
{
    NSString *cateName = [detailName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://baobab.kaiyanapp.com/api/v1/videos.bak?categoryName=%@&num=10", cateName];
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXDetailListItem Parse:obj], error);
    }];
}

+ (id)GETDetailListOtherPage:(NSString *)path conpletionHandler:(void (^)(ZXDetailListItem *, NSError *))completionHandler
{
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXDetailListItem Parse:obj], error);
    }];
}


+ (id)GETHomeItemCompletionHandler:(void (^)(ZXHomeItem *, NSError *))completionHandler
{
    NSString *path = @"http://www.moviebase.cn/uread/app/recommend/recommend?platform=1&deviceId=F9864FEA-7A4E-4DAA-AE8E-3ED48E542577&appVersion=1.10.0&versionCode=1104&sysver=ios10.2&channelId=0&resolutionWidth=640&resolutionHeight=1136&deviceModel=iPhone5s";
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXHomeItem Parse:obj], error);
    }];
}

+ (id)GETAgoEssenceCompletionHandler:(void (^)(ZXAgoEssenceItem *, NSError *))completionHandler
{
    NSString *path = @"http://www.moviebase.cn/uread/app/recommend/lastDays?platform=1&deviceId=F9864FEA-7A4E-4DAA-AE8E-3ED48E542577&appVersion=1.10.0&versionCode=1104&sysver=ios10.2&channelId=0&resolutionWidth=640&resolutionHeight=1136&deviceModel=iPhone5s";
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXAgoEssenceItem Parse:obj], error);
    }];
}

+ (id)GETCategoryItemCompletionHandler:(void (^)(ZXCategoryItem *, NSError *))complteionHandler
{
    NSString *path = @"http://www.moviebase.cn/uread/app/category/categoryList?platform=1&deviceId=F9864FEA-7A4E-4DAA-AE8E-3ED48E542577&appVersion=1.10.0&versionCode=1104&sysver=ios10.2&channelId=0&resolutionWidth=640&resolutionHeight=1136&deviceModel=iPhone5s";
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !complteionHandler ?: complteionHandler([ZXCategoryItem Parse:obj], error);
    }];
}


+ (id)GETAllCategory:(NSInteger)page completionHandler:(void (^)(ZXAllCategoryItem *, NSError *))completionHandler
{
    NSString *path = [NSString stringWithFormat:@"http://www.moviebase.cn/uread/app/topic/topicList?pageContext=%ld&platform=1&deviceId=F9864FEA-7A4E-4DAA-AE8E-3ED48E542577&appVersion=1.10.0&versionCode=1104&sysver=ios10.2&channelId=0&resolutionWidth=640&resolutionHeight=1136&deviceModel=iPhone5s", page];
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXAllCategoryItem Parse:obj], error);
    }];
}


+ (id)GETAllDetailCategory:(NSInteger)page ID:(NSString *)ID completionHandler:(void (^)(ZXAllDetailCategoryItem *, NSError *))completionHandler
{
    NSString *path = [NSString stringWithFormat:@"http://www.moviebase.cn/uread/app/topic/topicDetail/articleList?topicId=%@&pageContext=%ld&platform=1&deviceId=F9864FEA-7A4E-4DAA-AE8E-3ED48E542577&appVersion=1.10.0&versionCode=1104&sysver=ios10.2&channelId=0&resolutionWidth=640&resolutionHeight=1136&deviceModel=iPhone5s", ID, page];
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([ZXAllDetailCategoryItem Parse:obj], error);
    }];
}

//社区所有帖子
+ (id)GETAllCommunityID:(NSString *)ID completionHandler:(void(^)(XTJCommunity *allCommunity, NSError *error))completionHandler {
    
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/card/show";
    
    NSDictionary * param = @{@"user_id":ID};

    return [self GET:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJCommunity Parse:obj], error);
    }];
}

//举报帖子
+ (id)POSTReportCardId:(NSString *)cardId userID:(NSString *)userId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/card/report";
    NSDictionary * param = @{@"user_id":userId,@"card_id":cardId};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

//删除帖子
+ (id)POSTDeleteCardId:(NSString *)cardId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/card/delete";
    NSDictionary * param = @{@"card_id":cardId};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

//帖子点赞
+ (id)POSTJoinLikeCardId:(NSString *)cardId userId:(NSString *)userId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/card/join_like";
    NSDictionary * param = @{@"card_id":cardId,@"user_id":userId};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

//帖子取消点赞
+ (id)POSTDeleteLikeCardId:(NSString *)cardId userId:(NSString *)userId completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/card/card/delete_like";
    NSDictionary * param = @{@"card_id":cardId,@"user_id":userId};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

//发帖
+ (id)POSTUploadUserId:(NSString *)userId title:(NSString *)title text:(NSString *)text pic:(NSString *)pic completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/card/upload";
    NSDictionary * param = @{@"user_id":userId,@"title":title,@"text":text,@"pic":pic};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

//个人中心
+ (id)POSTPersonalID:(NSString *)userID completionHandler:(void(^)(XTJMineItem *essences, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/user/personal";
    
    NSDictionary * param = @{@"user_id":userID};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJMineItem Parse:obj], error);
    }];
}

//我的话题
+ (id)POSTMyCardUserId:(NSString *)userId completionHandler:(void(^)(XTJCommunity *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/user/my_card";
    
    NSDictionary * param = @{@"user_id":userId};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJCommunity Parse:obj], error);
    }];
}

//修改用户资料
+ (id)POSTModifyUserId:(NSString *)userId name:(NSString *)name pic:(NSString *)pic completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/user/personal";
    NSDictionary * param = @{@"user_id":userId,@"name":name,@"profile_pic":pic};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

//反馈
+ (id)POSTFeedBackUserId:(NSString *)userId comments:(NSString *)comments completionHandler:(void(^)(XTJRegisterItem *allCommunity, NSError *error))completionHandler {
    NSString *path = @"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_community/back/feedBack";
    NSDictionary * param = @{@"user_id":userId,@"feedBack_Comments":comments};
    return [self POST:path param:param completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([XTJRegisterItem Parse:obj], error);
    }];
}

@end
