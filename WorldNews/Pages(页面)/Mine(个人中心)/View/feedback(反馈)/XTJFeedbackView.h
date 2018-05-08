//
//  XTJFeedbackView.h
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTJFeedbackViewDelegate <NSObject>

- (void)didContentText:(NSString *)content;

@end


@class XTJTextView;
@interface XTJFeedbackView : UIView

@property(nonatomic,strong)XTJTextView * feedbacktextView;

@property(nonatomic,weak) id<XTJFeedbackViewDelegate> delegate;


-(void) dismissKeyBoard;
@end
