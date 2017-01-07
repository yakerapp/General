//
//  NSString+MK.h
//  General
//
//  Created by yaker on 2016/11/15.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MK)

/**
    特殊字符处理
 */
+ (NSString *)getDressingStr:(NSString *)string;

/*
    去除HTML标签
 */
+(NSString *)MPHTMLStrFilterHTML:(NSString *)html;

/*
    规范字符串，去除标签和特殊字符
 */
+ (NSString *)getMessageStrStr:(NSString *)string;

/*
    判断手机号
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;
@end
