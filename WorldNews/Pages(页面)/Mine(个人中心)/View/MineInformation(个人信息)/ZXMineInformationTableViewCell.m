//
//  XTJMineInformationTableViewCell.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "ZXMineInformationTableViewCell.h"

@implementation ZXMineInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle =UITableViewCellSelectionStyleNone;

    UITapGestureRecognizer * taps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didIconImage:)];
    
    [self.iconImage addGestureRecognizer:taps];
    
    
}

- (void)didIconImage:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(didIconImage:)]) {
        [self.delegate didIconImage:tap];
    }
    
}


+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
