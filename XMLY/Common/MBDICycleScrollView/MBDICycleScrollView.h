//
//  MBDICycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by on 16-5-23.
//  Copyright (c) 2016年 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MBDICycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：所有view
 **/
@property (nonatomic , copy) NSArray *arrayView;
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);
@end
