//
//  DealRecommendData.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/5.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "DealRecommendData.h"

@implementation DealRecommendData
//去空处理：
- (NSArray *)dealdataWithArr:(NSArray *)arr{
    //空数组：
    NSMutableArray *handleArr = [NSMutableArray array];
    //遍历数组：
    for (NSDictionary *dic in arr) {
        NSArray *arr = [dic objectForKey:@"list"];
        if (arr.count != 0) {
            [handleArr addObject:dic];
        }
    }
    return handleArr;
}

- (NSArray *)getModelWithArr:(NSArray *)arr{
    //创建空数组用于承载Model：
    NSMutableArray *modelArr = [NSMutableArray array];
    //去空：
    NSArray *handleArr = [self dealdataWithArr:arr];
    
    for (NSDictionary *dic in handleArr) {
        
       NSString *moduleTypeStr = [dic objectForKey:@"moduleType"];
        
       NSString *firstStr = [moduleTypeStr substringToIndex:1];
        //第一个字符变成大些：
       NSString * modelStr = [[[firstStr uppercaseString] stringByAppendingFormat:@"%@",[moduleTypeStr substringFromIndex:1]] stringByAppendingFormat:@"%@",@"Model"];
        
        id modelClass = NSClassFromString(modelStr);
        NSMutableArray *littleListArr = [NSMutableArray array];
        for (NSDictionary *listDic in [dic objectForKey:@"list"]) {
            id model = [[modelClass alloc] init];
            //使用KVC做数据模型转换：
            [model setValuesForKeysWithDictionary:listDic];
            [littleListArr addObject:model];
        }
        [modelArr addObject:littleListArr];
    }
    return modelArr;
}

@end
