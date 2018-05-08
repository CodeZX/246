//
//  XTJMine.m
//  WorldNews
//
//  Created by tunjin on 2018/5/3.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "XTJMine.h"

@implementation XTJMine

+ (instancetype)mineWithDict:(NSDictionary *)dict {
    return [[self alloc] mineWithDict:dict];

}

- (instancetype)mineWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}

@end
