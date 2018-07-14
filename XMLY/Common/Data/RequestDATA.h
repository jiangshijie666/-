//
//  RequestDATA.h
//  XiMaLaYa
//
//  Copyright © 2018年 com，baweijiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestDATA : NSObject
+(void)getDataWithUrl:(NSString *)url complement:(void(^)(id data))block;

@end
