//
//  XTJCompileNameTableViewCell.h
//  PeanutFinance
//
//  Created by hcios on 2017/8/5.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTJCompileNameTableViewCellDelegate <NSObject>

-(void)jfTextFieldWithText:(NSString *)text;

@end

@interface XTJCompileNameTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField * compileNameTextFiel;

@property (nonatomic, weak) id<XTJCompileNameTableViewCellDelegate> delegate;///<

+ (UINib *)nib;


@end
