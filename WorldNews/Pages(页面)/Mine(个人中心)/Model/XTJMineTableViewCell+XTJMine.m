//
//  XTJMineTableViewCell+XTJMine.m
//  WorldNews
//
//  Created by tunjin on 2018/5/3.
//  Copyright © 2018年 XTJ. All rights reserved.
//

#import "XTJMineTableViewCell+XTJMine.h"
#import "XTJMine.h"

@implementation XTJMineTableViewCell (XTJMine)

- (void)configCellWithModel:(id)model {
    XTJMine * mine = (XTJMine *)model;
    self.textLabel.text = mine.title;
    self.imageView.image = [UIImage imageNamed:mine.image];
}

@end
