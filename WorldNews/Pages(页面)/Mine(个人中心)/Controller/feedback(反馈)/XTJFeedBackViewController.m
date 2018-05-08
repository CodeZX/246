//
//  XTJFeedBackViewController.m
//  WorldNews
//
//  Created by tunjin on 2018/5/3.
//  Copyright © 2018年 XTJ. All rights reserved.
//

#import "XTJFeedBackViewController.h"
#import "XTJFeedbackView.h"
#define KBGColor RGB(255,255,255)

@interface XTJFeedBackViewController ()<XTJFeedbackViewDelegate>

@property(nonatomic,strong)XTJFeedbackView * feedBackView;

@property(nonatomic,strong)NSString * content;///< 意见反馈内容

@end

@implementation XTJFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];

    self.feedBackView = [[XTJFeedbackView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT * 0.3)];
    self.feedBackView.delegate = self;
    [self.view addSubview:self.feedBackView];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.feedBackView dismissKeyBoard];
    
}

-(void)setupNavBar{
    
    UIEdgeInsets contentEdgeInset = UIEdgeInsetsMake(10, 0, 10, -5);
    
    UIBarButtonItem * rightItem = [UIBarButtonItem itemWithtitle:@"提交" color:KBGColor Highlighted:KBGColor style:@"PingFangSC-Regular" size:17 contentEdgeInsets:contentEdgeInset Target:self action:@selector(didClickBtn:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)didClickBtn:(UIBarButtonItem *)item{
    if (self.content != nil) {
        [self.view showMessage:@""];
        
        [self.feedBackView dismissKeyBoard];
        [self netWorking];
    }else{
        [self setShowErrorWithTitle:@"请先填写您的意见"];
    }
}

#pragma mark - XTJFeedbackViewDelegate

- (void)didContentText:(NSString *)content{
    
    self.content = content;
}

#pragma mark - netWorking
-(void)netWorking{
    [NetManager POSTFeedBackUserId:[JFSaveTool objectForKey:@"UserID"] comments:self.content completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
       
        [self.view showMessage:allCommunity.msg];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
//错误时的提示
-(void)setShowErrorWithTitle:(NSString *)title{
    
    [self.view showMessage:title];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideHUD];
    });
}

@end
