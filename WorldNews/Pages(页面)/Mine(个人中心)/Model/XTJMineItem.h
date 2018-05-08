//
//  XTJMineItem.h
//  WorldNews
//
//  Created by tunjin on 2018/5/4.
//  Copyright © 2018年 XTJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTJMineItem_retData;

@interface XTJMineItem : NSObject
@property (nonatomic,strong) NSString * msg;
@property (nonatomic,strong) NSString * code;
@property (nonatomic,strong) XTJMineItem_retData * retData;

@end

@interface XTJMineItem_retData : XTJMineItem

@property (nonatomic, strong) NSString * user_id;
@property (nonatomic, strong) NSString * phone_num;
@property (nonatomic, strong) NSString * pwd;
@property (nonatomic, strong) NSString * profile_pic;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * sex;
@property (nonatomic, strong) NSString * birthday;

@end
