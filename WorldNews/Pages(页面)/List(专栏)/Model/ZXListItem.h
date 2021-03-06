//
//  ZXListItem.h
//  WangYe
//
//  Created by Mars on 2017/2/13.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXListItem : NSObject
@property (nonatomic, copy) NSString *alias;
//ID -> id
@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *headerImage;
//description -> des
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *bgColor;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *bgPicture;
@end
