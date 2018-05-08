//
//  JFMineSettingTableViewCell+JFConfigureForMineSetting.m
//  PeanutFinance
//
//  Created by hcios on 2017/7/16.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "XTJMineInformationTableViewCell+XTJConfigureForMineInformation.h"
#import "XTJMineInformationModel.h"
#import "JFSaveTool.h"
@implementation XTJMineInformationTableViewCell (XTJConfigureForMineInformation)

- (void)configCellWithModel:(id)model {
    XTJMineInformationModel * mineSetting = (XTJMineInformationModel *)model;
    self.titleLab.text = mineSetting.title;
    
    if ([self.titleLab.text isEqualToString:@"头像"]) {
        self.subTitleLab.hidden = YES;
        self.iconImage.hidden = NO;
     
        //加载首先访问本地沙盒是否存在相关图片
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.jpg"];
        UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];

        if (!savedImage){
            //默认头像
            [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[JFSaveTool objectForKey:@"UserImageUrlKey"]] placeholderImage:[UIImage imageNamed:@"icon_portrait40"]];
        }
        else{
            self.iconImage.image = savedImage;
        }
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = self.iconImage.frame.size.height / 2;
    }else{
        self.iconImage.hidden = YES;
    }

    if ([self.titleLab.text isEqualToString:@"姓名"]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.subTitleLab.text = [JFSaveTool objectForKey:@"UserNameKey"];
    }
    if ([self.titleLab.text isEqualToString:@"手机"]) {
        self.trailing.constant = 28;
        self.subTitleLab.text = [JFSaveTool objectForKey:@"PhoneNumberKey"];
    }
    
    [UILabel jf_labelStylewithlabel:self.titleLab Withsize:15 withLineSpace:0 WordSpace:0 withColor:RGB(51, 51, 51) withisBold:NO withTextStyle:@"PingFangSC-Regular"];
    
    [UILabel jf_labelStylewithlabel:self.subTitleLab Withsize:15 withLineSpace:0 WordSpace:0 withColor:RGB(153, 153, 153) withisBold:NO withTextStyle:@"PingFangSC-Regular"];
    
    
    
}

@end
