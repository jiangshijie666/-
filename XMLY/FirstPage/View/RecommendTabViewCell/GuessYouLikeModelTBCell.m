//
//  GuessYouLikeModelTBCell.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/6.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "GuessYouLikeModelTBCell.h"
#import "defind.h"

@implementation GuessYouLikeModelTBCell
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.titleLab = [[UILabel alloc]init];
//        self.titleLab.text = @"猜你喜欢";
//        [self.contentView addSubview:_titleLab];
//
//        self.moreBtn = [UIButton buttonWithType:1];
//        [self.moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
//        [self.contentView addSubview:_moreBtn];
//
//        _layout = [[UICollectionViewFlowLayout alloc]init];
//        self.guessListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_RATE_640_WIDTH(30), SCREEN_RATE_640_WIDTH(150), SCREEN_WIDTH- SCREEN_RATE_640_WIDTH(60), ((SCREEN_RATE_640_HEIGHT(140, 1242)+((SCREEN_WIDTH-SCREEN_RATE_640_WIDTH(90))/3.0))*2)) collectionViewLayout:_layout];
//        self.guessListCollectionView.scrollEnabled = NO;
//        [self.contentView addSubview:_guessListCollectionView];
//
//        self.changeBtn = [UIButton buttonWithType:1];
//        [self.changeBtn setTitle:@"换一批&" forState:UIControlStateNormal];
//        [self.contentView addSubview:_changeBtn];
//    }
//    return self;
//}
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.titleLab.frame = CGRectMake(SCREEN_RATE_640_WIDTH(30), 0, SCREEN_RATE_640_WIDTH(400),SCREEN_RATE_640_HEIGHT(150, 1242));
//    self.titleLab.font = [UIFont systemFontOfSize:20];
//    self.moreBtn.frame = CGRectMake(SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(180), 0,SCREEN_RATE_640_WIDTH(150) , SCREEN_RATE_640_HEIGHT(150, 1242));
//    self.moreBtn.titleLabel.textColor = [UIColor grayColor];
//    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    _layout.itemSize = CGSizeMake((SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(60) - SCREEN_RATE_640_WIDTH(15) * 2)/3.0, SCREEN_RATE_640_HEIGHT(140, 1242) + (SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(60) - SCREEN_RATE_640_WIDTH(15) * 2)/3.0);
//    _layout.minimumLineSpacing = 0;
//    _layout.minimumInteritemSpacing = 0;
//    self.changeBtn.frame = CGRectMake(SCREEN_RATE_640_WIDTH(30), VIEW_HEIGHT(_titleLab) + VIEW_HEIGHT(_guessListCollectionView), SCREEN_WIDTH - SCREEN_RATE_640_WIDTH(60), SCREEN_RATE_640_WIDTH(150));
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLab=[[UILabel alloc]init];
        self.titleLab.text=@"猜你喜欢";
        [self.contentView addSubview:_titleLab];
        self.moreBtn=[UIButton buttonWithType:1];
        [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        _layout=[[UICollectionViewFlowLayout alloc]init];
        self.guessListCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_RATE_640_WIDTH(30), SCREEN_RATE_640_WIDTH(150), SCREEN_WIDTH-SCREEN_RATE_640_WIDTH(60), (SCREEN_RATE_640_HEIGHT(140, 1242)+SCREEN_RATE_640_WIDTH(90))/3.0*2) collectionViewLayout:_layout];
        self.guessListCollectionView.scrollEnabled=NO;
        [self.contentView addSubview:_guessListCollectionView];
        self.changeBtn=[UIButton buttonWithType:1];
        [self.changeBtn setTitle:@"换一批***" forState:UIControlStateNormal];
        [self.contentView addSubview: _changeBtn];
    }
    return self;
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
