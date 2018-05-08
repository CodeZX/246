//
//  ZXListDetailController.h
//  WangYe
//
//  Created by Mars on 2017/2/13.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXListDetailController : UITableViewController
/** 名称 */
@property(nonatomic, strong) NSString *listName;
- (instancetype)initWithListName:(NSString *)listName;
@end
