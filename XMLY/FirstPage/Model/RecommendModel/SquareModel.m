//
//  SquareModel.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/5.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "SquareModel.h"

@implementation SquareModel
//KVC的纠错方法：
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
