//
//  CONST.h
//  General
//
//  Created by yaker on 2016/11/15.
//  Copyright © 2016年 yaker. All rights reserved.
//

#ifndef CONST_h
#define CONST_h

//屏幕大小边界
#define ScreenBounds [[UIScreen mainScreen] bounds]
//屏幕高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define BackColor  [UIColor colorWithRed:237.0/255.0 green:76.0/255.0 blue:42.0/255.0 alpha:1]

#define  httpHost  [[NSUserDefaults standardUserDefaults]objectForKey:@"httpHost"]

#define APIKEY @"3deabd317093e56d068137f392440fbb"
#define COlOR(R,G,B,A)  [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(A)]

//qq
#define QQAppSecret @"JS6V8hQcw5roQZzv"
#define QQAPPID         @"1104359280"
//微博
#define WBAppSecret @"cbaddb11c8b0ca74f268e0ecf7f6be95"
#define WBAppKey    @"600241016"

//微信
#define WXAppID @"wx46dda2586024da11"
#define WXAppSecret @"a039b7a39d9562e3fcdad030c8facbf2"

//应用分享内容
#define SHARE   @"达达－让浏览更简单 下载地址：http://jiatc.com/down/newdada"
//帖子分享内容
#define SHARETIE @"达达"
#define  downHttpHost [[NSUserDefaults standardUserDefaults]objectForKey:@"downHttpHostURL"]
#define  httpVersonURL [[NSUserDefaults standardUserDefaults]objectForKey:@"downVersonHostURL"]

#import "MKNetWorkTool.h"

#define  UID  [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]
#define  USERNAME  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"]

#import "Client.h"
#import "FPLogInTool.h"
#import "NSString+MK.h"

#define kUserDefaultsCookie @"generallogincookie"

#define kCookieDisableOberveKey @"cookietimeout" //cookie过期通知的key


#endif /* CONST_h */
