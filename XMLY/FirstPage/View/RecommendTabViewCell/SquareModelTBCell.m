//
//  SquareModelTBCell.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/6.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "SquareModelTBCell.h"
#import "defind.h"
@implementation SquareModelTBCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _menuCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_RATE_640_HEIGHT(240, 1242)) collectionViewLayout:_layout];
        [self.contentView addSubview:_menuCollectionView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _layout.itemSize = CGSizeMake((SCREEN_WIDTH - (SCREEN_RATE_640_WIDTH(30)*7))/6.0, SCREEN_RATE_640_HEIGHT(240, 1242));
 _layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
