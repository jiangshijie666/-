//
//  CategoriesForShortModel.h
//  XMLY
//
//  Created by 耿荣林 on 2018/7/5.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "BaseModel.h"

@interface CategoriesForShortModel : BaseModel
@property (nonatomic,copy) NSString *albumId;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *playsCount;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *tracksCount;

@end
