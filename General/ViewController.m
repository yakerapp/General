//
//  ViewController.m
//  General
//
//  Created by yaker on 2016/11/15.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import "ViewController.h"
#import "CONST.h"
#import "PYPhotosView.h"
#import "ViewController1.h"
#import "MKAlertView.h"

@interface ViewController ()

- (IBAction)logOut:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, 100)];
    textView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:17];
    textView.text = @"13927384985";
    [self.view addSubview:textView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTextView:)];
    [textView addGestureRecognizer:tapRecognizer];
    
    MKAlertView *alert = [[MKAlertView alloc]init];
    [alert alertWithTitle:@"提示" andImage:[UIImage imageNamed:@"钥匙提示框"] andButtons:@[@"先不开",@"开车门"] andColor:[UIColor blackColor] buttonIndex:^(int index){
        if (index == 0){
        }
    }];
}

- (void)_initView{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cookieOuttime) name:kCookieDisableOberveKey object:nil];
    
    // 1. 创建图片链接数组
    NSMutableArray *thumbnailImageUrls = [NSMutableArray array];
    // 添加图片(缩略图)链接
    [thumbnailImageUrls addObject:@"http://ww3.sinaimg.cn/thumbnail/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"];
    [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"];
    [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    [thumbnailImageUrls addObject:@"http://ww4.sinaimg.cn/thumbnail/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg"];
    [thumbnailImageUrls addObject:@"http://ww2.sinaimg.cn/thumbnail/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
    [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
    [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
    [thumbnailImageUrls addObject:@"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg"];
    [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/86afb21egw1f6bq3lq0itj20gg0c2myt.jpg"];
    
    // 1.2 创建图片原图链接数组
    NSMutableArray *originalImageUrls = [NSMutableArray array];
    // 添加图片(原图)链接
    [originalImageUrls addObject:@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    [originalImageUrls addObject:@"http://ww4.sinaimg.cn/large/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg"];
    [originalImageUrls addObject:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
    [originalImageUrls addObject:@"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/86afb21egw1f6bq3lq0itj20gg0c2myt.jpg"];
    
    // 2.1 创建一个流水布局photosView(默认为流水布局)
    PYPhotosView *flowPhotosView = [PYPhotosView photosView];
    flowPhotosView.photosMaxCol = 3;
    flowPhotosView.photoWidth = (self.view.py_width-10)/3.0;
    flowPhotosView.photoHeight = (self.view.py_width-10)/3.0;
    // 设置缩略图数组
    flowPhotosView.thumbnailUrls = thumbnailImageUrls;
    // 设置原图地址
    flowPhotosView.originalUrls = originalImageUrls;
    // 设置分页指示类型
    flowPhotosView.pageType = PYPhotosViewPageTypeLabel;
    flowPhotosView.py_centerX = self.view.py_centerX;
    flowPhotosView.py_y = 0;
    
    // 2.2创建线性布局
    PYPhotosView *linePhotosView = [PYPhotosView photosViewWithThumbnailUrls:thumbnailImageUrls originalUrls:originalImageUrls layoutType:PYPhotosViewLayoutTypeLine];
    // 设置Frame
    linePhotosView.py_y = CGRectGetMaxY(flowPhotosView.frame) + PYMargin * 2;
    linePhotosView.py_x = PYMargin;
    linePhotosView.py_width = self.view.py_width - linePhotosView.py_x * 2;
    
    // 3. 添加到指定视图中
    [self.view addSubview:flowPhotosView];
    [self.view addSubview:linePhotosView];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)cookieOuttime{
    NSLog(@"登录信息过期");
}
- (IBAction)logOut:(id)sender {
    [FPLogInTool autoLogOut];
    
    ViewController1 *vc = [[ViewController1 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tappedTextView:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    UITextView *textView = (UITextView *)tapGesture.view;
    CGPoint tapLocation = [tapGesture locationInView:textView];
    UITextPosition *textPosition = [textView closestPositionToPoint:tapLocation];
    NSDictionary *attributes = [textView textStylingAtPosition:textPosition inDirection:UITextStorageDirectionForward];
    
    NSURL *url = attributes[NSLinkAttributeName];
    
    if (url) {
        NSLog(@"%@",url);
    }
}


@end
