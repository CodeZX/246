//
//  UILabel+JFStyle.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/14.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "UILabel+JFStyle.h"

@implementation UILabel (JFStyle)

+(void)jf_labelStylewithlabel:(UILabel *)label Withsize:(NSInteger)size withLineSpace:(float)lineSpace WordSpace:(float)wordSpace withColor:(UIColor *)coler withisBold:(BOOL)isbold withTextStyle:(NSString *)textStyle{
    
    NSString *labelText = label.text;
    
    if (isbold == YES) {
        label.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@ Rounded MT Bold",textStyle]  size:(size)];
    }else{
        label.font = [UIFont fontWithName:textStyle size:size];
    }
    
    label.textColor = coler;
    
    if (label.text != nil) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        
        label.attributedText = attributedString;

    }
    
//    [label sizeToFit];
 
}


@end
