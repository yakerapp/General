//
//  UIImage+MK.h
//  General
//
//  Created by yaker on 2016/11/15.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MK)

//实例方法

/**
    相片的物理方向校正
*/
- (UIImage *)fixOrientation;

/**
  模糊图片
 */
- (UIImage *)applyLightEffect1;
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyDarkEffect1;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;

/**
 图片裁剪压缩
 */
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;

/**
 图片着色
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

/**
  view转图片
 */
- (UIImage *)capture:(UIView *)view;

@end
