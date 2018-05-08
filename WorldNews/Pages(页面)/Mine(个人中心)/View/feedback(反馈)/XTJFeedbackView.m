//
//  XTJFeedbackView.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "XTJFeedbackView.h"
#import "XTJTextView.h"
@interface XTJFeedbackView ()<UITextViewDelegate>


@property(nonatomic,strong)UILabel * count;///< 字数统计

@end

@implementation XTJFeedbackView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
    }
    return self;
}


-(void)setupViews{
    
    //创建用户名U TextField
    XTJTextView * feedbacktextView = [[XTJTextView alloc] init];
    
    feedbacktextView.textAlignment = NSTextAlignmentLeft;
//    feedbackTextField.
    feedbacktextView.textColor = RGB(153, 153, 153);
    feedbacktextView.font = [UIFont systemFontOfSize:15];

   
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:feedbacktextView.text attributes:@{NSKernAttributeName:@(8)}];
    
    feedbacktextView.attributedText = attributedString;

    feedbacktextView.placeholder = @"   对我们APP、产品、服务，您还有什么问题或意见吗？";
    feedbacktextView.placeHolderLabel.font = [UIFont systemFontOfSize:15];
    feedbacktextView.placeholderColor = RGB(153, 153, 153);
    
    feedbacktextView.keyboardType = UIKeyboardTypeDefault;
     feedbacktextView.delegate = self;
    [self addSubview:feedbacktextView];

   
    self.feedbacktextView = feedbacktextView;

    self.count = [[UILabel alloc] init];
    self.count.text = @"0/500";
    self.count.textAlignment = NSTextAlignmentRight;
    self.count.font = [UIFont systemFontOfSize:15];
    self.count.backgroundColor = [UIColor clearColor];

    [self.count setTextColor:[UIColor redColor]];
    self.count.textColor = RGB(153, 153, 153);

    [self addSubview:self.count];
    
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = RGB(216, 216, 216);
    [self addSubview:bottomView];
    

    [feedbacktextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top).offset(15);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);

    }];
    
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-9);
        make.top.equalTo(feedbacktextView.mas_bottom).offset(9);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(17);
        
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(DEVICE_SCREEN_WIDTH);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.count.mas_bottom).offset(9);
        
    }];
    
     feedbacktextView.textContainerInset = UIEdgeInsetsMake(0, 18, 0, 20);
}

/**
 内容将要发生改变编辑 限制输入文本长度 监听TextView 点击了ReturnKey 按钮
 
 @param textView textView
 @param range    范围
 @param text     text
 
 @return BOOL
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
    
    if (range.location < 500)
    {
        self.count.textColor = RGB(153, 153, 153);
        

        return  YES;
        
    } else if ([textView.text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }


    
    if (range.location >= 500) {
        
        textView.text = [toBeString substringToIndex:500];

        self.count.textColor = [UIColor redColor];
        return NO;
    }
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([self.delegate respondsToSelector:@selector(didContentText:)]) {
        [self.delegate didContentText:textView.text];
    }
    
    if (!textView.text.length) {
        self.count.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];

        self.feedbacktextView.placeHolderLabel.alpha = 1;
    } else {
        self.count.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
        self.feedbacktextView.placeHolderLabel.alpha = 0;
    }
}


//关闭键盘
-(void) dismissKeyBoard{
    [self.feedbacktextView resignFirstResponder];
}

@end
