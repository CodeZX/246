//
//  XTJMineHeaderView.m
//  TJShop
//
//  Created by tunjin on 2018/4/17.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMineHeaderView.h"
#define KIconeImageWidth   80

@interface XTJMineHeaderView()


@end

@implementation XTJMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tj_setUI];
    }
    return self;
}

- (void) tj_setUI {
    
    [self addSubview:self.bgImageView];
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(35);
        make.height.mas_equalTo(KIconeImageWidth);
        make.width.mas_equalTo(KIconeImageWidth);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.width.mas_equalTo(self.width);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"icon_portraitbg"];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = KIconeImageWidth * 0.5;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}


@end
