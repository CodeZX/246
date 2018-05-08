//
//  NEAFNetworkingHelper.m
//  AF2.XHttpHelper
//
//  Created by Nero on 16/5/10.
//  Copyright © 2016年 Nero. All rights reserved.
//

#import "NEAFNetworkingHelper.h"

@implementation NEAFNetworkingHelper

+(NSURLSessionTask *)GETWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(NEResponseSuccess)success
                           fail:(NEResponseFail)fail
                        showHUD:(NSString *)HUDMessage{
    
    
//    NSLog(@"[GET]>>>>[%@]\n请求参数>>>>%@\n",url,params);
    //如果地址为空，则返回nil
    if (url==nil) {
        return nil;
    }

    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager = [self getAFManager];
    NSURLSessionTask *task = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"success>>>>%@",responseObject);

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error>>>>%@",error);
//        if (fail) {
//            fail(error);
//        }
    }];
    return task;
}

+(NSURLSessionTask *)POSTWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(NEResponseSuccess)success
                            fail:(NEResponseFail)fail
                         showHUD:(NSString *)HUDMessage{
    
    if (url==nil) {
        return nil;
    }
    
    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager = [self getAFManager];
    
    NSURLSessionTask *task = [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

//        if (fail) {
//            NSString *errorDescription = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//            NSLog(@"[POST]>>>>[%@]\n请求参数>>>>%@\n",url,params);
//            NSLog(@"error>>>>%@",errorDescription);
//            fail(error);
//        }
    }];
    return task;
}


#pragma makr - 开始监听网络连接
+ (void)startMonitoring{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI网络");
                break;
        }
    }];
    [mgr startMonitoring];
}

+(AFHTTPSessionManager *)getAFManager{
    
    // 指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TimeOut;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //https ipv6的设置
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    return manager;
}

+(NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}


@end




