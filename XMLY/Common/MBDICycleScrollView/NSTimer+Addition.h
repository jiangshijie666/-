//
//  NSTimer+Addition.h
//  CycleScrollViewDemo
//
//  Created by on 16-5-23.
//  Copyright (c) 2016年 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
