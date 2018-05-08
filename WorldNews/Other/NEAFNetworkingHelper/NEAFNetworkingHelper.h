//
//  NEAFNetworkingHelper.h
//  AF2.XHttpHelper
//
//  Created by Nero on 16/5/10.
//  Copyright © 2016年 Nero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#define TimeOut 60.f;

#define APIUIL @"http://202.101.89.197:8091/ailkods-imsws/app/mobile."

typedef enum{
    
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
}NEtworkStatus;

typedef void( ^ NEResponseSuccess)(id response);
typedef void( ^ NEResponseFail)(NSError *error);


@interface NEAFNetworkingHelper : NSObject
/**
 *  获取网络
 */
@property (nonatomic,assign)NEtworkStatus networkStats;
/**
 *  开启网络监测
 */
+ (void)startMonitoring;


/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数 没有参数置nil
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param  如不显示置nil
 */
+(NSURLSessionTask *)GETWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(NEResponseSuccess)success
                           fail:(NEResponseFail)fail
                        showHUD:(NSString *)HUDMessage;

/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数 没有参数置nil
 *  @param success 请求成功返回数据
 *  @param fail    请求失败

 */
+(NSURLSessionTask *)POSTWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(NEResponseSuccess)success
                            fail:(NEResponseFail)fail
                         showHUD:(NSString *)HUDMessage;


@end
