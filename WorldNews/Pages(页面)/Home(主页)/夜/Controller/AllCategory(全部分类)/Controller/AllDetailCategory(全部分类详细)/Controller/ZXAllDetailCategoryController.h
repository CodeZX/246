//
//  ZXAllDetailCategoryController.h
//  WangYe
//
//  Created by Mars on 2017/2/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXAllDetailCategoryController : UIViewController
/** 图片 */
@property(nonatomic, strong) NSString *imageName;

/** 分类标题 */
@property(nonatomic, strong) NSString *labelName;

/** ID */
@property(nonatomic, strong) NSString *ID;

- (instancetype)initWithImageName:(NSString *)imageName labelName:(NSString *)labelName ID:(NSString *)ID;
@end
