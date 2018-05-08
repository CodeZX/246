//
//  XTJMineInformationModel.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "XTJMineInformationModel.h"

@implementation XTJMineInformationModel


+ (instancetype)mineSettingWithDict:(NSDictionary *)dict{
    XTJMineInformationModel * mineSetting = [[self alloc] init];
    [mineSetting setValuesForKeysWithDictionary:dict];
    return mineSetting;
}


@end
