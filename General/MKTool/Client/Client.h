//
//  Client.h
//  General
//
//  Created by yaker on 2016/11/15.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+Add.h"

@interface Client : NSObject

+ (void)getHostData;

+ (void)showError:(NSString *)error;
+ (void)showSuccess:(NSString *)success;
+ (void)showMessag:(NSString *)message;
+ (void)showLoading:(NSString *)message;
+ (void)hiddenLoading;

@end
