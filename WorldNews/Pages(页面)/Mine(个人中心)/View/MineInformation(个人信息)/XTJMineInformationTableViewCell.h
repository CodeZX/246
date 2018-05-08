//
//  XTJMineInformationTableViewCell.h
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTJMineInformationTableViewCellDelegate <NSObject>

- (void)didIconImage:(UITapGestureRecognizer *)tap;

@end

@interface XTJMineInformationTableViewCell : UITableViewCell

+ (UINib *)nib;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;

@property(nonatomic,weak) id<XTJMineInformationTableViewCellDelegate> delegate;


@end
