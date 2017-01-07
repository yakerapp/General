//
//  Client.m
//  General
//
//  Created by yaker on 2016/11/15.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import "Client.h"
#import "CONST.h"

#define buttonTitleFont [UIFont systemFontOfSize:16]

#define headLabelBoldFont [UIFont boldSystemFontOfSize:22]
#define titleLabelBoldFont [UIFont boldSystemFontOfSize:18]
#define titleLabelFont [UIFont systemFontOfSize:18]
#define contentLabelFont [UIFont systemFontOfSize:16]


@implementation Client

#pragma mark - 获得根域名
+ (void)getHostData{
    NSString *urlStr = [NSString stringWithFormat:@"http://appconfig.jiatc.com/appconfig.php?appid=104"];

    if (httpHost == nil){
        [[NSUserDefaults standardUserDefaults]setObject:@"http://dadaty.com/" forKey:@"httpHost"];
    }
    [[MKNetWorkTool sharedJsonClient]getResponseObjectWithURL:urlStr andParms:nil andBlock:^(id data, NSError *error) {
        if(error){
            return ;
        }
        NSDictionary *mDic = [NSDictionary dictionaryWithDictionary:data];
        NSString *httpHostuy = [NSString stringWithFormat:@"%@/",mDic[@"data"][@"hostapp"]];
        NSString *hostappdowniosadhoc = [NSString stringWithFormat:@"%@",mDic[@"data"][@"hostappdowniosadhoc"]];
        NSString *versonappdowniosadhoc = [NSString stringWithFormat:@"%@",mDic[@"data"][@"hostappdowniosversion"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:httpHostuy forKey:@"httpHost"];
        [[NSUserDefaults standardUserDefaults]setObject:hostappdowniosadhoc forKey:@"downHttpHostURL"];
        [[NSUserDefaults standardUserDefaults]setObject:versonappdowniosadhoc forKey:@"downVersonHostURL"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"cookiewritesuccess"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
}

#pragma mark - 按钮模式
+ (UIButton*)getButtonWithTitle:(NSString*)title andTitleColor:(UIColor*)titleColor{
    return [self getButtonWithTitle:title andTitleColor:titleColor andSelectColor:titleColor];
}
+ (UIButton*)getButtonWithTitle:(NSString*)title andTitleColor:(UIColor*)titleColor andSelectColor:(UIColor*)selectColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:0];
    [button setTitleColor:titleColor forState:0];
    button.titleLabel.font = buttonTitleFont;
    return button;
}

+ (UIButton*)getButtonWithImage:(UIImage*)image{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:0];
    return button;
}

#pragma mark - 标签模式
+ (UILabel*)getHeadLabel{
    return [self getLabelWithFont:headLabelBoldFont color:[UIColor blackColor]];
}
+ (UILabel*)getTitleLabel{
    return [self getLabelWithFont:titleLabelFont color:[UIColor blackColor]];
}
+ (UILabel*)getcontentLabel{
    return [self getLabelWithFont:contentLabelFont color:[UIColor grayColor]];
}
+ (UILabel*)getLabelWithFont:(UIFont*)font color:(UIColor*)color{
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    label.textColor = color;
    label.font = font;
    return label;
}

#pragma mark -  MBProgressHUD
+ (void)showError:(NSString *)error{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showError:error toView:view];
}
+ (void)showSuccess:(NSString *)success{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showSuccess:success toView:view];
}
+ (void)showMessag:(NSString *)message{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

+ (void)showLoading:(NSString *)message{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tag = 10000;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
}
+ (void)hiddenLoading{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hub = (MBProgressHUD*)[view viewWithTag:10000];
    if (hub){
        [hub hide:YES];
    }
}


@end
