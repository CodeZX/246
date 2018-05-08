//
//  XTJMineInformationModel.h
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTJMineInformationModel : NSObject

/** title*/
@property(nonatomic,copy)NSString * title;

/** subtitle*/
@property(nonatomic,copy)NSString * subTitle;

/** image*/
@property(nonatomic,copy)NSString * image;

+ (instancetype)mineSettingWithDict:(NSDictionary *)dict;


@end
