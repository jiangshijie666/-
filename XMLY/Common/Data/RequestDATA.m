//
//  RequestDATA.m
//  XiMaLaYa
//
//  Copyright © 2018年 com，baweijiaoyu. All rights reserved.
//

#import "RequestDATA.h"
#import "AFNetworking.h"

@implementation RequestDATA
+(void)getDataWithUrl:(NSString *)url complement:(void(^)(id data))block{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
