//
//  FPLogInTool.h
//  fanpian
//
//  Created by yaker on 16/5/23.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPLogInTool : NSObject

typedef void (^LogInBlock)(NSString *string);
@property (copy,nonatomic) LogInBlock loginBlock;

+ (void)logInToolLogIn:(NSString*)password andUserName:(NSString*)username andBlock:(LogInBlock)loginBlock;
+ (void)logInToolRestPsw:(NSString*)password andUserName:(NSString*)username andCode:(NSString*)code andBlock:(LogInBlock)loginBlock;

+ (void)autoLogIn;
+ (void)autoLogOut;
+ (void)getUserInfo;
+ (void)loadCookie;
@end
