//
//  MKNetWorkTool.h
//  duiban
//
//  Created by yaker on 15/11/13.
//  Copyright © 2015年 yaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MKNetWorkTool : NSObject

+(MKNetWorkTool *)sharedJsonClient;

- (void)getResponseObjectWithURL:(NSString*)urlStr andParms:(NSDictionary*)parms andBlock:(void (^)(id data, NSError *error))block;

- (void)postResponseObjectWithURL:(NSString*)urlStr andParms:(NSDictionary*)parms andBlock:(void (^)(id data, NSError *error))block;

- (void)uploadImage:(UIImage *)image url:(NSString *)url
       successBlock:(void (^)(id responseObject,NSMutableDictionary *prams))success
       failureBlock:(void (^)(NSError *error))failure
      progerssBlock:(void (^)(CGFloat progressValue))progress;

- (void)uploadImage:(UIImage*)imageHeader withUrl:(NSString*)url andBlock:(void (^)(id data, NSError *error))block;

- (void)getTextResponseObjectWithURL:(NSString*)urlStr andBlock:(void (^)(NSString *string))block;

@end
