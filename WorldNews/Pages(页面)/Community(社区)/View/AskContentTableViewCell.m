//
//  AskContentTableViewCell.m
//  FiftyOneCraftsman
//
//  Created by ting.hu on 2018/1/3.
//  Copyright © 2018年 Edgar_Guan. All rights reserved.
//

#import "AskContentTableViewCell.h"
#import "Masonry.h"

@interface AskContentTableViewCell ()

@end
@implementation AskContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addAtrribuedLabel];
    }
    return self;
}
- (IBAction)clikReply:(UIButton *)sender {
    NSLog(@"回复中请稍后");
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addAtrribuedLabel];
    }
    return self;
}

- (void)addAtrribuedLabel
{
    UILabel *label = [[UILabel alloc]init];
//    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(80);
        make.bottom.equalTo(self.contentView).with.offset(-30);
    }];
    
    _label = label;
    [self bringSubviewToFront:_btnSpot];
    [self bringSubviewToFront:_btnReply];
    [self bringSubviewToFront:_btnReview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
