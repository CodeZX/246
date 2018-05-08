//
//  AskContentTableViewCell.h
//  FiftyOneCraftsman
//
//  Created by ting.hu on 2018/1/3.
//  Copyright © 2018年 Edgar_Guan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TYAttributedLabel.h"

@interface AskContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (nonatomic, weak) UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *btnReview;
@property (weak, nonatomic) IBOutlet UIButton *btnSpot;
@property (weak, nonatomic) IBOutlet UIButton *btnReply;

@end
