//
//  MKAlertView.m
//  General
//
//  Created by yaker on 2017/1/12.
//  Copyright © 2017年 yaker. All rights reserved.
//

#import "MKAlertView.h"
#import "CONST.h"

@interface MKAlertView (){
    
}

@end

@implementation MKAlertView

- (void)alertWithTitle:(NSString*)title  andImage:(UIImage*)image andButtons:(NSArray*)btnTitles andColor:(UIColor*)color buttonIndex:(alerViewButtonIndex)block{
    self.block = block;
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    CGFloat left = 20;
    CGFloat top = 0;
    CGFloat forViewW = ScreenWidth - 40;
    UIView *forView = [self getForgroundView];
    forView.frame = CGRectMake(left, 0, forViewW, 0);

    UILabel *titleLabel = [self getTitleLabel];
    titleLabel.text = title;
    titleLabel.frame = CGRectMake(10, 0, forViewW - 20, 40);
    [forView addSubview:titleLabel];
    
    top += 50;
    
    CGFloat imgW = image?image.size.width:1;
    CGFloat imgH = image?image.size.height:1;
    CGFloat imgX = 50;
    CGFloat imageW = forViewW - imgX * 2;
    CGFloat imageH = imageW * (imgH/imgW);
    
    UIImageView *imageView = [self getImgeView];
    imageView.image = image;
    imageView.frame = CGRectMake(imgX, top, imageW, imageH);
    [forView addSubview:imageView];
    
    top += imageH + 15;
    
    CGFloat buttonW = forViewW/btnTitles.count;
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, top, forViewW, 1)];
    lineLabel.backgroundColor = [UIColor colorWithWhite:0.890 alpha:1.000];
    [forView addSubview:lineLabel];
    
    for (int i = 0;i<btnTitles.count;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100 + i;
        btn.frame = CGRectMake(i * buttonW, top, buttonW, 40);
        [btn addTarget:self action:@selector(buttonClickedAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnTitles[i] forState:0];
        [btn setTitleColor:color forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [forView addSubview:btn];
        if (i > 0){
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(buttonW*i,top, 1, 40)];
            lineLabel.backgroundColor = [UIColor colorWithWhite:0.890 alpha:1.000];
            [forView addSubview:lineLabel];
        }
    }
    top += 40;
    
    forView.frame = CGRectMake(left, (ScreenHeight - top)/2.0, forViewW, top);
}

- (void)buttonClickedAtIndex:(UIButton*)btn{
    self.hidden = YES;
    self.block(btn.tag - 100);
}

#pragma mark - ForView
- (UIView *)getForgroundView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    return view;
}

#pragma mark - getTitleLabel
- (UILabel *)getTitleLabel{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    return label;
}

#pragma mark - getImageView
- (UIImageView*)getImgeView{
    UIImageView *imageView = [[UIImageView alloc]init];
    return imageView;
}
@end
