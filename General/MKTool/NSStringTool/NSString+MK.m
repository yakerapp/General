//
//  NSString+MK.m
//  General
//
//  Created by yaker on 2016/11/15.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import "NSString+MK.h"

@implementation NSString (MK)

+ (NSString *)getDressingStr:(NSString *)string
{
    
    if (string == nil)return @"";
    NSMutableString *str = [NSMutableString stringWithString:string];
    while ([str rangeOfString:@"&amp;"].length > 0) {
        [str replaceCharactersInRange:[str rangeOfString: @"&amp;"] withString:@"&"];
    }
    while ([str rangeOfString:@"&quot;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&quot;"] withString:@"\""];
    }
    
    while ([str rangeOfString:@"&lt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&lt;"] withString:@"<"];
    }
    
    while ([str rangeOfString:@"&gt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&gt;"] withString:@">"];
    }
    
    while ([str rangeOfString:@"&nbsp;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&nbsp;"] withString:@" "];
        
    }
    
    return str;
}

+(NSString *)MPHTMLStrFilterHTML:(NSString *)html
{
    if (html == nil)return @"";
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}

+ (NSString *)getMessageStrStr:(NSString *)string
{
    
    if (string == nil)return @"";
    NSString *str = string;
    
    str = [NSString MPHTMLStrFilterHTML:str];
    str = [NSString getDressingStr:str];
    //去除首尾空格和换行
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return str;
}
/**
 *  判断是否是手机号
 *
 *  @param mobile 电话号码
 *
 *  @return yes 表示正确
 */
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
}

@end
