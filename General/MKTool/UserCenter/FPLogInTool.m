//
//  FPLogInTool.m
//  fanpian
//
//  Created by yaker on 16/5/23.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import "FPLogInTool.h"
#import "CONST.h"

typedef void (^getReadyDataBlock )(NSMutableDictionary *readyData);

@implementation FPLogInTool

+ (void)logInToolLogIn:(NSString*)password andUserName:(NSString*)username andBlock:(LogInBlock)loginBlock{
    [FPLogInTool getReadyHiddenData:^(NSMutableDictionary *readyData) {
        if (readyData){
            NSString *url = [NSString stringWithFormat:@"%@member.php?mod=logging&action=login&appflag=1&mobile=0",httpHost];
            NSMutableDictionary *parms = [NSMutableDictionary dictionary];
            parms[@"formhash"] = readyData[@"formhash"];
            parms[@"referer"] = readyData[@"referer"];
            parms[@"loginhash"] = readyData[@"loginhash"];
            parms[@"loginsubmit"] = @"yes";
            parms[@"loginfield"] = username;
            parms[@"username"] = username;
            parms[@"password"] = password;
            [[MKNetWorkTool sharedJsonClient]postResponseObjectWithURL:url andParms:parms andBlock:^(id data, NSError *error) {
                if (error){
                    loginBlock(@"-1");
                    return;
                }
                NSDictionary *resDic = data[@"data"];
                NSString *success = [NSString stringWithFormat:@"%@",resDic[@"success"]];
                if ([success intValue] == 1){
                     loginBlock(@"1");
                     [FPLogInTool setDefaultData:resDic];
                     [FPLogInTool setCokieWithUrl:url];
                }else{
                     loginBlock(@"-1");
                }
            }];
        }else{
            loginBlock(@"-1");
        }
    }];
}

+ (void)getReadyHiddenData:(getReadyDataBlock)block{
    NSString *url = [NSString stringWithFormat:@"%@member.php?mod=logging&action=login&appflag=1",httpHost];
    [[MKNetWorkTool sharedJsonClient]getResponseObjectWithURL:url andParms:nil andBlock:^(id data, NSError *error) {
        if (!error) {
            NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:data[@"data"]];
            block(mDic);
        }else{
            block(nil);
        }
    }];
}

+ (void)clearCookie{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kUserDefaultsCookie];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    NSString *url = [NSString stringWithFormat:@"%@member.php?mod=logging&action=logout&appflag=1",httpHost];
    [[MKNetWorkTool sharedJsonClient]getResponseObjectWithURL:url andParms:nil andBlock:^(id data, NSError *error) {
    }];
}
+ (void)loadCookie{
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}
+ (void)setCokieWithUrl:(NSString*)urlstr{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:urlstr]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserDefaultsCookie];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}

+ (void)setDefaultData:(NSDictionary*)userInfo{
    [[NSUserDefaults standardUserDefaults]setObject:userInfo[@"uid"] forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]setObject:userInfo[@"usernmae"] forKey:@"username"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (void)autoLogIn{
    [FPLogInTool loadCookie];
    [FPLogInTool getUserInfo];
}

+ (void)autoLogOut{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [FPLogInTool clearCookie];
}

+ (void)getUserInfo{
    NSString *url = [NSString stringWithFormat:@"%@member.php?mod=baseinfo&appflag=1",httpHost];
    [[MKNetWorkTool sharedJsonClient]getResponseObjectWithURL:url andParms:nil andBlock:^(id data, NSError *error) {
        if (error){
            return ;
        }
        NSDictionary *mDic = data[@"data"];
        NSString *uid = [NSString stringWithFormat:@"%@",mDic[@"uid"]];
        NSString *formhash = [NSString stringWithFormat:@"%@",mDic[@"formhash"]];
        [[NSUserDefaults standardUserDefaults]setObject:formhash forKey:@"fomhash"];
        if([uid intValue] == 0){//登录信息过期通知
            [[NSNotificationCenter defaultCenter]postNotificationName:kCookieDisableOberveKey object:nil];
        }
    }];
}

+ (void)logInToolRestPsw:(NSString*)password andUserName:(NSString*)username andCode:(NSString*)code andBlock:(LogInBlock)loginBlock{
    [FPLogInTool getResetPswHiddenData:^(NSMutableDictionary *readyData) {
        if (readyData){
            NSString *url = [NSString stringWithFormat:@"%@member.php?mod=getpasswdapp&androidflag=1&appfrom=ios&iosversion=3.24",httpHost];

            NSMutableDictionary *parms = [NSMutableDictionary dictionary];
            parms[@"phone"] = username;
            parms[@"formhash"] = readyData[@"formhash"];
            parms[@"gpwdcode"] = code;
            parms[@"newpasswd1"] = password;
            parms[@"newpasswd2"] = password;
            parms[@"getpwsubmit"] = @"1";
            
            [[MKNetWorkTool sharedJsonClient]postResponseObjectWithURL:url andParms:parms andBlock:^(id data, NSError *error) {
                if (error){
                    loginBlock(@"-1");
                    return;
                }
                NSDictionary *mDic = data[@"data"];
                NSString *success = mDic[@"result"];
                loginBlock(success);
            }];
        }else{
            loginBlock(@"-1");
        }
    }];

}
+ (void)getResetPswHiddenData:(getReadyDataBlock)block{
    NSString *url = [NSString stringWithFormat:@"%@member.php?mod=getpasswdapp&androidflag=1&appfrom=ios&iosversion=3.24",httpHost];
    [[MKNetWorkTool sharedJsonClient]getResponseObjectWithURL:url andParms:nil andBlock:^(id data, NSError *error) {
        if (!error) {
            NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:data[@"data"]];
            block(mDic);
        }else{
            block(nil);
        }
    }];
}
@end
