//
//  UIButton+DSAdd.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/15.
//  Copyright © 2017年 徐冬苏. All rights reserved.
//

#import "UIButton+DSAdd.h"

@implementation UIButton (DSAdd)

// 设置button的titleLabel和imageView的布局样式，及间距
- (void)DS_layoutButtonWithEdgeInsetsStyle:(DS_ButtonEdgeInsetsStyle)DS_style
                           imageTitleSpace:(CGFloat)DS_space isSizeToFit:(BOOL)isSizeToFit{
    
    if (isSizeToFit == YES) {
        [self sizeToFit];

    }
    // 得到imageView和titleLabel的宽、高
    
    CGFloat DS_imageWidth  = 0.0;
    CGFloat DS_imageHeight = 0.0;
    
    CGFloat DS_labelWidth  = 0.0;
    CGFloat DS_labelHeight = 0.0;
    
    if (self.currentImage) {
        DS_imageWidth  = self.imageView.bounds.size.width;
        DS_imageHeight = self.imageView.bounds.size.height;
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        DS_labelWidth  = self.titleLabel.intrinsicContentSize.width;
        DS_labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        DS_labelWidth  = self.titleLabel.frame.size.width;
        DS_labelHeight = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets DS_imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets DS_labelEdgeInsets = UIEdgeInsetsZero;
    
    // 根据DS_style和DS_space得到DS_imageEdgeInsets和DS_labelEdgeInsets的值
    switch (DS_style) {
        case DS_ButtonEdgeInsetsStyleTop:
            DS_imageEdgeInsets = UIEdgeInsetsMake(-DS_labelHeight-DS_space/2.0, 0, 0, -DS_labelWidth);
            DS_labelEdgeInsets = UIEdgeInsetsMake(0, -DS_imageWidth, -DS_imageHeight-DS_space/2.0, 0);
            break;
        case DS_ButtonEdgeInsetsStyleLeft:
            DS_imageEdgeInsets = UIEdgeInsetsMake(0, -DS_space/2.0, 0, DS_space/2.0);
            DS_labelEdgeInsets = UIEdgeInsetsMake(0, DS_space/2.0, 0, -DS_space/2.0);
            break;
        case DS_ButtonEdgeInsetsStyleBottom:
            DS_imageEdgeInsets = UIEdgeInsetsMake(0, 0, -DS_labelHeight-DS_space/2.0, -DS_labelWidth);
            DS_labelEdgeInsets = UIEdgeInsetsMake(-DS_imageHeight-DS_space/2.0, -DS_imageWidth, 0, 0);
            break;
        case DS_ButtonEdgeInsetsStyleRight:
            DS_imageEdgeInsets = UIEdgeInsetsMake(0, DS_labelWidth+DS_space/2.0, 0, -DS_labelWidth-DS_space/2.0);
            DS_labelEdgeInsets = UIEdgeInsetsMake(0, -DS_imageWidth-DS_space/2.0, 0, DS_imageWidth+DS_space/2.0);
            break;
        default:
            break;
    }
    self.titleEdgeInsets = DS_labelEdgeInsets;
    self.imageEdgeInsets = DS_imageEdgeInsets;
    if (isSizeToFit == YES) {
        [self sizeToFit];

    }
}

@end
