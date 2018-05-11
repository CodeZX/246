//
//  MallTableViewController.h
//  zx246News
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 XTJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, NSStringJKScoreOption) {
    NSStringJKScoreOptionNone = 1 << 0,
    NSStringJKScoreOptionFavorSmallerWords = 1 << 1,
    NSStringJKScoreOptionReducedLongStringPenalty = 1 << 2
};


@interface MallTableViewController : UITableViewController

@end
