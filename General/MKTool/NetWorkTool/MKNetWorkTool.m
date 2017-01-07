//
//  MKNetWorkTool.m
//  duiban
//
//  Created by yaker on 15/11/13.
//  Copyright © 2015年 yaker. All rights reserved.
//

#import "MKNetWorkTool.h"
#import "UIImage+MK.h"

@implementation MKNetWorkTool

+(MKNetWorkTool *)sharedJsonClient{
    static MKNetWorkTool *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MKNetWorkTool alloc]init];
    });
    return _sharedClient;
}


- (void)getResponseObjectWithURL:(NSString*)urlStr andParms:(NSDictionary*)parms andBlock:(void (^)(id data, NSError *error))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //[manager setSecurityPolicy:[MKNetWorkTool customSecurityPolicy]];
    [manager GET:urlStr parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"downloadProgress:%lld/%lld",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"sever" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}
- (void)postResponseObjectWithURL:(NSString*)urlStr andParms:(NSDictionary*)parms andBlock:(void (^)(id data, NSError *error))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:urlStr parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}

- (void)uploadImage:(UIImage *)image url:(NSString *)url
       successBlock:(void (^)(id responseObject,NSMutableDictionary *prams))success
       failureBlock:(void (^)(NSError *error))failure
      progerssBlock:(void (^)(CGFloat progressValue))progress{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if ((float)data.length/1024 > 1000) {
        data = UIImageJPEGRepresentation(image, 0.1);
    }
    NSURLSessionDataTask *task = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        success(responseObject,nil);
        //上传成功
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        failure(error);
        //上传失败
    }];
    [task resume];
}

#pragma mark - 上传图片
- (void)uploadImage:(UIImage*)imageHeader withUrl:(NSString*)url andBlock:(void (^)(id data, NSError *error))block
{
    NSMutableDictionary *mDic = [self getParm:imageHeader];
    NSString *filesize = mDic[@"filesize"];
    NSData *data1;
    data1 = UIImageJPEGRepresentation(imageHeader, 0.3);
    if ([filesize floatValue] > 2000000){
        imageHeader = [imageHeader scaleToSize:CGSizeMake(1500 , (imageHeader.size.height/imageHeader.size.width)*1500)];
        data1 = UIImageJPEGRepresentation(imageHeader, 0.3);
    }else{
        data1 = UIImageJPEGRepresentation(imageHeader, 1);
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSURLSessionDataTask *task = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data1
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        block(responseObject,nil);
        //上传成功
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        block(nil,error);
        //上传失败
    }];
    [task resume];
}

//post参数
- (NSMutableDictionary *)getParm:(UIImage*)image
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    int  perMBBytes = 1024*1024;
    
    CGImageRef cgimage = image.CGImage;
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    long lPixelsPerMB  = perMBBytes/bytes_per_pixel;
    long totalPixel = CGImageGetWidth(image.CGImage)*CGImageGetHeight(image.CGImage);
    long totalFileMB = (totalPixel/lPixelsPerMB)*perMBBytes;
    NSString *size = [NSString stringWithFormat:@"%ld",totalFileMB];
    
    [dic setObject:size forKey:@"filesize"];
    NSString *width = [NSString stringWithFormat:@"%f",image.size.width];
    [dic setObject:width forKey:@"width"];
    
    [dic setObject:@"temp.jpg" forKey:@"filename"];
    return dic;
}

- (void)getTextResponseObjectWithURL:(NSString*)urlStr andBlock:(void (^)(NSString *string))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlstr = urlStr;
        NSString *s = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlstr] encoding:NSUTF8StringEncoding error:nil];
        block(s);
    });
}
@end
