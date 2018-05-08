//
//  UIBarButtonItem+JFItem.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "UIBarButtonItem+JFItem.h"

@implementation UIBarButtonItem (JFItem)

+(UIBarButtonItem *)itemWithImage:(UIImage *)image WithHightLighted:(UIImage *)highlightedImage Target:(id)target action:(SEL)action{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * contentView = [[UIView alloc] initWithFrame:btn.frame];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
}

+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:SelectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * contentView = [[UIView alloc] initWithFrame:btn.frame];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

+(UIBarButtonItem *)backItemWithImage:(UIImage *)image WithHighLingtedImage:(UIImage *)highlightedImage Target:(id)target action:(SEL)action title:(NSString *)title{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -20);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

+(UIBarButtonItem *)itemWithtitle:(NSString *)title color:(UIColor *)color Highlighted:(UIColor *)highlightedColor style:(NSString *)style size:(NSInteger)size contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets Target:(id)target action:(SEL)action {
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont fontWithName:style size:size];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = contentEdgeInsets;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

@end
