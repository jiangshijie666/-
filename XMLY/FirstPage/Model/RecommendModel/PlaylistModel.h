//
//  PlaylistModel.h
//  XMLY
//
//  Created by 耿荣林 on 2018/7/5.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "BaseModel.h"

@interface PlaylistModel : BaseModel
@property (nonatomic,copy) NSString *coverPath;
@property (nonatomic,copy) NSString *footnote;
@property (nonatomic,copy) NSString *specialId;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;


@end
