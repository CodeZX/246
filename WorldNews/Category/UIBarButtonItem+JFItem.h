//
//  UIBarButtonItem+JFItem.h
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JFItem)

+(UIBarButtonItem *)itemWithImage:(UIImage *) image WithHightLighted:(UIImage *) highlightedImage Target:(id)target action:(SEL)action;

+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithtitle:(NSString *)title color:(UIColor *)color Highlighted:(UIColor *)highlightedColor style:(NSString *)style size:(NSInteger)size contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets  Target:(id)target action:(SEL)action;

/**
 返回
 */

+(UIBarButtonItem *) backItemWithImage:(UIImage *) image WithHighLingtedImage:(UIImage *)highlightedImage Target:(id)target action:(SEL)action title:(NSString *) title;

@end
