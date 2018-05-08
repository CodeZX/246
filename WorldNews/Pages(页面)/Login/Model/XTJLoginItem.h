//
//  XTJLoginItem.h
//  WorldNews
//
//  Created by tunjin on 2018/5/4.
//  Copyright © 2018年 XTJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTJLoginItem_retData;

@interface XTJLoginItem : NSObject

@property (nonatomic,strong) NSString * msg;
@property (nonatomic,strong) NSString * code;
@property (nonatomic,strong) XTJLoginItem_retData * retData;

@end

@interface XTJLoginItem_retData : XTJLoginItem
@property (nonatomic,strong) NSString * user_id;

@end
