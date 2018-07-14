//
//  SquareCollectionViewCell.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/6.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "SquareCollectionViewCell.h"
#import "defind.h"
#import "SquareModel.h"

@implementation SquareCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLab = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        self.picImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:_picImgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.picImgView.frame=CGRectMake(SCREEN_RATE_640_WIDTH(25), SCREEN_RATE_640_HEIGHT(50, 1242), self.contentView.bounds.size.width -SCREEN_RATE_640_WIDTH(50), self.contentView.bounds.size.width-SCREEN_RATE_640_WIDTH(50));
    CFRim *rim =[[CFRim alloc]init];
    [rim cf_rimWithView:_picImgView radius:SCREEN_RATE_640_WIDTH(60) width:0];
    self.titleLab.frame = CGRectMake(0, SCREEN_RATE_640_HEIGHT(160, 1242), self.contentView.frame.size.width, self.contentView.frame.size.height -SCREEN_RATE_640_HEIGHT(160, 1242));
    self.titleLab.font = [UIFont systemFontOfSize:12];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor grayColor];
}

//model赋值：
- (void)setModel:(BaseModel *)model{
    SquareModel *newModel = (SquareModel *)model;
    NSLog(@"------%@",newModel.title);
    self.titleLab.text = newModel.title;
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:newModel.coverPath]];
}

@end
