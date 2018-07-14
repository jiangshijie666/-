//
//  GuessYouLikeCollectionViewCell.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/7.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "GuessYouLikeCollectionViewCell.h"
#import "defind.h"
#import "GuessYouLikeModel.h"

@implementation GuessYouLikeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        _picImageView=[[UIImageView alloc]init];
        [self addSubview:_picImageView];
        
        _titlerLab=[[UILabel alloc]init];
        [self addSubview:_titlerLab];
        
        _playImageView=[[UIImageView alloc]init];
        [self addSubview:_playImageView];
        
        _numberLab=[[UILabel alloc]init];
        [self addSubview:_numberLab];
    }
    return self;
}

-(void)layoutSubviews{
    _picImageView.frame =CGRectMake(0, 0, (SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(90))/3.0, (SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(90))/3.0);
    _titlerLab.frame=CGRectMake(0, (SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(90))/3.0, (SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(90))/3.0, SCREEN_RATE_640_HEIGHT(140, 1242));
    _titlerLab.font=DES_FONT;
}

- (void)setModel:(BaseModel *)model{
    GuessYouLikeModel *newModel = (GuessYouLikeModel *)model;
    self.titlerLab.text = newModel.title;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:newModel.pic]];
}

@end
