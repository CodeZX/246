//
//  ZXCommitViewController.m
//  FiftyOneCraftsman
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 Edgar_Guan. All rights reserved.
//  提交

#import "ZXCommitViewController.h"
#import "OSSImageUploader.h"

#import <TZImagePickerController.h>
#import <TZImageManager.h>
#import <TZLocationManager.h>

static NSString *kTempFolder = @"temp";

@interface ZXCommitViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
{
    NSString *imagePath;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    UIControl * _control;
}

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSString * eval_comments;
@property (strong, nonatomic) UILabel *placeHolder;
@property (strong, nonatomic) UIButton *commitButton;
@property (strong, nonatomic) UITextView *feedBackTextView;
@property (strong, nonatomic) UITextView * titleTextView;
@property (strong, nonatomic) NSMutableArray * imagesArray;

@property (strong, nonatomic) UIButton * imgButton;

@property (strong, nonatomic) NSString * picString;

@property (strong, nonatomic) UIView * picView;

@end

@implementation ZXCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picString = @"";
    _selectedPhotos = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self ds_setCommitView];

}

- (void)ds_setCommitView {
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 200)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    if (![self.title isEqualToString:@"评论"]) {
        self.titleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 5, DEVICE_SCREEN_WIDTH, 44)];
        self.titleTextView.delegate = self;
        self.titleTextView.editable = YES;
        self.titleTextView.backgroundColor = RGB(237, 237, 237);
        self.titleTextView.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:self.titleTextView];
        
        //textView
        _feedBackTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 60, DEVICE_SCREEN_WIDTH, 140)];
        _feedBackTextView.delegate = self;
        _feedBackTextView.editable = YES;
        _feedBackTextView.backgroundColor = RGB(237, 237, 237);
        _feedBackTextView.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_feedBackTextView];
        
        [self.view addSubview:bgView];
        
        //placeHolder
        UILabel * placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, DEVICE_SCREEN_WIDTH, 20)];
        placeHolder.text = @"写评论";
        placeHolder.font = [UIFont systemFontOfSize:14];
        placeHolder.textColor = RGB(51, 51, 51);
        [bgView addSubview:placeHolder];
        self.placeHolder = placeHolder;
        self.placeHolder.userInteractionEnabled = NO;
        
    }else {
        //textView
        _feedBackTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, DEVICE_SCREEN_WIDTH, 140)];
        _feedBackTextView.delegate = self;
        _feedBackTextView.editable = YES;
        _feedBackTextView.backgroundColor = RGB(237, 237, 237);
        _feedBackTextView.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_feedBackTextView];
        
        [self.view addSubview:bgView];
        
        //placeHolder
        UILabel * placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, DEVICE_SCREEN_WIDTH, 20)];
        placeHolder.text = @"写评论";
        placeHolder.font = [UIFont systemFontOfSize:14];
        placeHolder.textColor = RGB(51, 51, 51);
        [bgView addSubview:placeHolder];
        self.placeHolder = placeHolder;
        self.placeHolder.userInteractionEnabled = NO;
    }
    
    //commitButton
    UIButton * commitButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [commitButton setTitle:@"发表" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor lightGrayColor];
    self.commitButton.userInteractionEnabled = NO;

    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.commitButton = commitButton;
    [self.view addSubview:commitButton];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(DEVICE_SCREEN_WIDTH - 60, 44));
        make.bottom.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(30);
    }];
    
    [self.view addSubview:self.imgButton];
    [self.imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.feedBackTextView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
    }];
}

- (void)didIconImage{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [self pushTZImagePickerController];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//打开相册
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.width - 2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    
    imagePickerVc.isStatusBarDefault = NO;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        _selectedPhotos = [NSMutableArray arrayWithArray:photos];
        _selectedAssets = [NSMutableArray arrayWithArray:assets];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    
    [self uploadImages:_selectedPhotos];
    [self setupPhotos];
    [self.view showMessage:@""];
}

#pragma mark - UIImagePickerController
//调用相机
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
    }
}

#pragma mark - 添加图片
- (void)setupPhotos {
    
    for (NSInteger i = 0; i < _selectedPhotos.count; i++) {
        CGFloat width = 80;
        CGFloat height = 80;
        CGFloat spaceHor = 20;
        CGFloat spaceVer = 10;
        CGFloat x = spaceHor + (i % 3) * (width + spaceHor);
        CGFloat y = CGRectGetMaxY(self.feedBackTextView.frame) + (i / 3) * (height + spaceVer) + 20;
        
        UIImageView * photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        photoImage.tag = i + 1;
        photoImage.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        photoImage.contentMode = UIViewContentModeScaleAspectFit;
        photoImage.backgroundColor = [UIColor lightGrayColor];
        photoImage.layer.borderWidth = 0.5;
        photoImage.layer.cornerRadius = 4;
        photoImage.layer.masksToBounds = YES;
        photoImage.userInteractionEnabled = YES;
        photoImage.image = _selectedPhotos[i];
        [self.view addSubview:photoImage];

        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"photo_delete.png"] forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(photoImage.frame.size.width - 25, 0, 25, 25);
        deleteBtn.tag = i + 500;
        [deleteBtn addTarget:self action:@selector(didClickdeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.alpha = 0.6;
        [photoImage addSubview:deleteBtn];
        //添加点击图片的手势
        UITapGestureRecognizer * taps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsPressGestures:)];
        [photoImage addGestureRecognizer:taps];
    }
}

- (void)didClickdeleteBtn:(UIButton *)btn {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"是否删除图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [_selectedPhotos removeObjectAtIndex:btn.tag - 500];
        [_selectedAssets removeObjectAtIndex:btn.tag - 500];
        [self setupPhotos];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tapsPressGestures:(UITapGestureRecognizer *)tap {
    NSLog(@"1");
}


//正在改变
- (void)textViewDidChange:(UITextView *)textView {
    self.eval_comments = textView.text;
    if (textView.text.length > 0) {
        self.placeHolder.hidden = YES;
        //允许提交按钮点击操作
        self.commitButton.backgroundColor = RGB(0, 164, 238);
        self.commitButton.userInteractionEnabled = YES;
    }else {
        self.placeHolder.hidden = NO;
        //允许提交按钮点击操作
        self.commitButton.backgroundColor = [UIColor lightGrayColor];
        self.commitButton.userInteractionEnabled = NO;
    }
}

//提交
- (void)commitButtonAction{
    
    if([self.title isEqualToString:@"评论"]) {
        
        [self ds_commentsNetWorkingWithPic:self.picString];
        
    }else {
        
         [self ds_netWorkingWithPic:self.picString];
        
    }
   
}

#pragma mark - 网络请求
//发帖子
- (void)ds_netWorkingWithPic:(NSString *)pic {
    [NetManager POSTUploadUserId:[JFSaveTool objectForKey:@"UserID"] title:self.titleTextView.text text:self.feedBackTextView.text pic:pic completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

//评论
- (void)ds_commentsNetWorkingWithPic:(NSString *)pic {
    
    [NetManager POSTCommentUserId:[JFSaveTool objectForKey:@"UserID"]  text:pic completionHandler:^(XTJRegisterItem *allCommunity, NSError *error) {
         [self.navigationController popViewControllerAnimated:YES];
    }];
}

//上传图片到OSS
- (void)uploadImages:(NSArray<UIImage *> *)images {
    [OSSImageUploader asyncUploadImages:images complete:^(NSArray<NSString *> *names, UploadImageState state) {
        NSMutableArray * imagesArr = [NSMutableArray array];
        for (NSInteger i = 0; i < names.count; i++) {
            NSString * newName = [NSString stringWithFormat:@"http://51gongjiang.oss-cn-shanghai.aliyuncs.com/%@",names[i]];
            [imagesArr addObject:newName];
        }
        NSString *string = [imagesArr componentsJoinedByString:@","];
        self.picString = string;
    }];
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (UIButton *)imgButton {
    if (!_imgButton) {
        _imgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgButton setImage:[UIImage imageNamed:@"icon_frame60"] forState:UIControlStateNormal];
        [_imgButton addTarget:self action:@selector(didIconImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imgButton;
}

@end
