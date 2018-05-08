//
//  XTJCompileNameTableViewCell.m
//  PeanutFinance
//
//  Created by hcios on 2017/8/5.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "XTJCompileNameTableViewCell.h"
#import "JFSaveTool.h"
@interface XTJCompileNameTableViewCell ()

@property (nonatomic, copy) NSString * lastTextContent;

@end

@implementation XTJCompileNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.lastTextContent = nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    [self.compileNameTextFiel resignFirstResponder];
    
    [self.compileNameTextFiel setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    self.compileNameTextFiel.font = [UIFont systemFontOfSize:15];
    self.compileNameTextFiel.textColor = RGB(153, 153, 153);
    self.compileNameTextFiel.borderStyle = UITextBorderStyleNone;
    self.compileNameTextFiel.keyboardType = UIKeyboardTypeDefault;
    self.compileNameTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;//输入框中是否有个叉号,用于一次性删除输入框中的内容

    self.compileNameTextFiel.delegate = self;
    self.compileNameTextFiel.placeholder = [JFSaveTool objectForKey:@"UserNameKey"];
    
    [self.compileNameTextFiel addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];

}


//限制只能输入一定长度的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    self.lastTextContent = textField.text;
    return YES;
}

//取消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.compileNameTextFiel resignFirstResponder];
    }];
    
}

- (void)textFieldDidChangeValue:(UITextField *)textField{
    
    //获取文本框内容的字节数
    int bytes = [self stringConvertToInt:self.compileNameTextFiel.text];
    //设置不能超过20个字节，因为不能有半个汉字，所以以字符串长度为单位。
    if (bytes > 10)
    {
        //超出字节数，还是原来的内容
        self.compileNameTextFiel.text = self.lastTextContent;
        
        [self showMessage:@""];
    }else{
        self.lastTextContent = self.compileNameTextFiel.text;
    }
    
    if ([self.delegate respondsToSelector:@selector(jfTextFieldWithText:)]) {
        [self.delegate jfTextFieldWithText:self.lastTextContent];
    }
   
}


//得到字节数函数
- (int)stringConvertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}


+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
