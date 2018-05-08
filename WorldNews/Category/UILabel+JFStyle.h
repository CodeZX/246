//
//  UILabel+JFStyle.h
//  PeanutFinance
//
//  Created by hcios on 2017/7/14.
//  Copyright © 2017年 JiFeng. All rights reserved.
//  label的格式

#import <UIKit/UIKit.h>

@interface UILabel (JFStyle)

/**
 lab 风格

 @param size 字体大小
 @param lineSpace 行间距
 @param wordSpace 列间距
 @param coler 文字颜色
 @param isbold 是否加粗

 */
+(void)jf_labelStylewithlabel:(UILabel *)label Withsize:(NSInteger)size withLineSpace:(float)lineSpace WordSpace:(float)wordSpace withColor:(UIColor *)coler withisBold:(BOOL)isbold withTextStyle:(NSString *)textStyle;



@end
