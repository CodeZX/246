//
//  Const.h
//  WangYe
//
//  Created by Mars on 2017/2/7.
//  Copyright © 2017年 YG. All rights reserved.
//

#ifndef Const_h
#define Const_h

//OC语言
#ifdef __OBJC__
#ifdef DEBUG
#import "AppDelegate.h"
//NSLog调试
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif


// 屏幕宽、高
#define DEVICE_SCREEN_FRAME     ([UIScreen mainScreen].bounds)
#define DEVICE_SCREEN_WIDTH     ([UIScreen mainScreen].bounds.size.width)
#define DEVICE_SCREEN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)

#define is_iPhoneX          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


// 导航栏宽、高
#define NAVIGATIONBAR_WIDTH     DEVICE_SCREEN_WIDTH
#define NAVIGATIONBAR_HEIGHT  (is_iPhoneX ? 88.f : 64.f)
// 标签栏宽、高
#define TABBAR_WIDTH            DEVICE_SCREEN_WIDTH
#define TABBAR_HEIGHT        (is_iPhoneX ? 83.f : 49.f)
// 状态栏高度
#define STATUSBAR_HEIGHT     (is_iPhoneX ? 44.f : 20.f)

//RGB 颜色
#define KRGBA(r,g,b,a)  [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

#define RGB(r,g,b) KRGBA(r,g,b,1.0f)

#define kPushViewController(VC)     [self.navigationController pushViewController:VC animated:YES]

#pragma mark - 判断是否为空
#define NonEmptyString(a)    (a == nil || [a isKindOfClass:[NSNull class]] || a == NULL) ? @"" :a
// 是否为NSDictionary，并且是否为空
#define NSDictionaryMatchAndCount(ownOBJ)    ([ownOBJ isKindOfClass:[NSDictionary class]] && ((NSDictionary *)ownOBJ).allKeys.count > 0)
// 是否为NSArray，并且是否为空
#define NSArrayMatchAndCount(ownOBJ)    ([ownOBJ isKindOfClass:[NSArray class]] && ((NSArray *)ownOBJ).count > 0)
/// 仅支持value为String类型
#define NSDictionaryContentWithKey(dic, key)  [NSString stringWithFormat:@"%@", NonEmptyString([dic objectForKey:key])]
// 是否为NSArray，并且是否为空
#define NSArrayMatchAndCount(ownOBJ)    ([ownOBJ isKindOfClass:[NSArray class]] && ((NSArray *)ownOBJ).count > 0)

// 打印方法调用的宏
#define LogFunc NSLog(@"%s", __func__)

#define YGScreenW [UIScreen mainScreen].bounds.size.width

#define YGScreenH [UIScreen mainScreen].bounds.size.height

// rgb颜色方法
#define YGRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机颜色
#define YGRandomColor YGRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 主题背景颜色
#define YGBgColor YGRGBColor(242, 244, 255)

// AppDelegate
#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#endif

#endif /* Const_h */
