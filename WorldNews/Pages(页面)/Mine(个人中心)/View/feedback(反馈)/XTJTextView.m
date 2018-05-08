//
//  XTJTextView.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "XTJTextView.h"

@implementation XTJTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews
{
    self.text  = @"";
    
    
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    
    
}

- (void)setText:(NSString *)text {
    [super setText:text];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if( [[self placeholder] length] > 0 )
    {
        if ( _placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(19,0,self.bounds.size.width - 16 - 19,0)];
//            _placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
}



@end
