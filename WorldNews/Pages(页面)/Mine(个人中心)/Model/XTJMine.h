//
//  XTJMine.h
//  WorldNews
//
//  Created by tunjin on 2018/5/3.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTJMine : NSObject

@property (nonatomic, copy  ) NSString * title;
@property (nonatomic, copy  ) NSString * image;

+ (instancetype)mineWithDict:(NSDictionary *)dict;

- (instancetype)mineWithDict:(NSDictionary *)dict;

@end
