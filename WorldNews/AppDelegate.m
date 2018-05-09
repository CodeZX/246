//
//  AppDelegate.m
//  WangYe
//
//  Created by Mars on 2017/2/7.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "AppDelegate.h"
#import "YGTabBarController.h"

#import <JPUSHService.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

#import "DSLaunchAnimateViewController.h"
#import "NEAFNetworkingHelper.h"
#import "UIImageView+WebCache.h"

NSString * const kJPushAppKey = @"c2fa18fc5422dcbbf673ba2f";
#define ScreenBounds [UIScreen mainScreen].bounds

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self gotoHomePage];
    //极光推送
    [self jpushInitWith:launchOptions];
    application.applicationIconBadgeNumber = 0;
    
    [self setLaunchAnimateView];
    
    return YES;
}

- (void)gotoHomePage {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YGTabBarController alloc] init];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    
    // 清空缓存
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjects];
}

- (void)jpushInitWith:(NSDictionary *)launchOptions
{
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
     entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
    }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey
     
                          channel:@"App Store"
                 apsForProduction:0
     
            advertisingIdentifier:nil];
    
    //app未运行时，收到推送消息
    
    NSDictionary *resultDic = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (resultDic) {//推送进入APP
        
        NSLog(@"app未启动，推送进入，直接显示预警界面");
        
        //        [self SetMainTabbarController2]; //相应界面跳转方法
        
    }else{//正常进入APP
        
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
}
//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

//注冊消息推送失败

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Register Remote Notifications error:{%@}",error);
}

- (void)getApnsIMDeviceToken{
    /// 需要区分iOS SDK版本和iOS版本。
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else
#endif
    {
        /// 去除warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
#pragma clang diagnostic pop
    }
}


#pragma mark - 接收通知
/*****/
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark - 设置启动页
- (void)setLaunchAnimateView{
    [self getLaunchAnimateUrl];
}
- (void)getLaunchAnimateUrl {
//    [NEAFNetworkingHelper GETWithUrl:@"http://host-119-148-162-231.iphost.gotonets.com:8080/tj_currency/tianxiazixun/logo" params:nil success:^(id response) {
//        NSDictionary *responseDic = (NSDictionary *)response;
//        NSDictionary *dataDic = [responseDic objectForKey:@"retData"];
//
//        UIView *launchView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dataDic[@"logo"]]]];
//        imageView.center = launchView.center;
//        [launchView addSubview:imageView];
//        DSLaunchAnimateViewController *launchCtrl = [[DSLaunchAnimateViewController alloc]initWithContentView:launchView animateType:DSLaunchAnimateTypeFade showSkipButton:YES];
//        [launchCtrl show];
//        //        [NSThread sleepForTimeInterval:1.0];
//    } fail:^(NSError *error) {
//        return ;
//    } showHUD:nil];
    
    
    UIView *launchView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://host-119-148-162-231.iphost.gotonets.com:8080/246flash/img/logo.png"]];
    imageView.center = launchView.center;
    [launchView addSubview:imageView];
    DSLaunchAnimateViewController *launchCtrl = [[DSLaunchAnimateViewController alloc]initWithContentView:launchView animateType:DSLaunchAnimateTypeFade showSkipButton:YES];
    [launchCtrl show];
    [NSThread sleepForTimeInterval:1.0];
}

@end
