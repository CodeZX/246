//
//  UIButton+DSAdd.h
//  PeanutFinance
//
//  Created by hcios on 2017/7/15.
//  Copyright © 2017年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DS_ButtonEdgeInsetsStyle) {
    
    DS_ButtonEdgeInsetsStyleTop,    // image在上，title在下
    DS_ButtonEdgeInsetsStyleLeft,   // image在左，title在右
    DS_ButtonEdgeInsetsStyleBottom, // image在下，title在上
    DS_ButtonEdgeInsetsStyleRight   // image在右，title在左
};

@interface UIButton (DSAdd)

/**
 设置button的titleLabel和imageView的布局样式，及间距
 
 @param DS_style titleLabel和imageView的布局样式
 @param DS_space titleLabel和imageView的间距
 */
- (void)DS_layoutButtonWithEdgeInsetsStyle:(DS_ButtonEdgeInsetsStyle)DS_style
                           imageTitleSpace:(CGFloat)DS_space isSizeToFit:(BOOL)isSizeToFit;

@end
