//
//  MBDICycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by on 16-5-23.
//  Copyright (c) 2016年 BOC. All rights reserved.
//

#import "MBDICycleScrollView.h"
#import "NSTimer+Addition.h"

@interface MBDICycleScrollView () <UIScrollViewDelegate>

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;
@property (nonatomic , strong) NSArray *arrayViewSource;
@end

@implementation MBDICycleScrollView

-(void)setArrayView:(NSArray *)arrayView
{
    _arrayViewSource = arrayView;
    _totalPageCount = _arrayViewSource.count;
    if (_totalPageCount > 0) {
        self.pageControl.numberOfPages = _totalPageCount;
        _currentPageIndex = 0;
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignFromBackground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)enterBackground:(NSNotification *)noti
{
    if (self.animationTimer) {
        [self.animationTimer pauseTimer];
    }
}
- (void)resignFromBackground:(NSNotification *)noti
{
    if (self.animationTimer) {
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.clipsToBounds = YES;
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        self.pageControl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 15);
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        self.pageControl.backgroundColor=[UIColor clearColor];
        [self.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
        [self addSubview:self.pageControl];
        [self.pageControl setHidden:YES];
    }
    return self;
}

- (void)pageTurn:(UIPageControl*)sender
{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_arrayViewSource.count == 1) {
        [self.animationTimer pauseTimer];
        UIView *contentView = _arrayViewSource[0];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(0, 0);
            contentView.frame = rightRect;
        contentView.clipsToBounds = YES;
        [self.scrollView addSubview:contentView];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [_scrollView setScrollEnabled:NO];
    }else if(_arrayViewSource.count < 1){
        [self removeFromSuperview];
        [self.animationTimer pauseTimer];
    }else if(_arrayViewSource.count > 1){
        [self setScrollViewContentDataSource];
        NSInteger counter = 0;
        for (UIView *contentView in self.contentViews) {
            contentView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
            [contentView addGestureRecognizer:tapGesture];
            CGRect rightRect = contentView.frame;
            rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
                    contentView.frame = rightRect;
            contentView.clipsToBounds = YES;
            [self.scrollView addSubview:contentView];
        }
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
        self.pageControl.currentPage = _currentPageIndex;
    }
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    [self.contentViews addObject:_arrayViewSource[previousPageIndex]];
    [self.contentViews addObject:_arrayViewSource[_currentPageIndex]];
    [self.contentViews addObject:_arrayViewSource[rearPageIndex]];
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    if ([_arrayViewSource count]>1) {
        CGFloat x = self.scrollView.contentOffset.x;
        NSInteger move = (((NSInteger)x)%((NSInteger)self.scrollView.frame.size.width));
        CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame)-move, self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:newOffset animated:YES];
        [self.pageControl setHidden:NO];
    }else{
        [self.pageControl setHidden:YES];
    }
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
