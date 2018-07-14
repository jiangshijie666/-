//
//  CFRim.m
//  StudyJapanese
//
//  Created by Devel on 15/12/3.
//  Copyright © 2015年. All rights reserved.
//

#import "CFRim.h"

@implementation CFRim

-(void)cf_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid{
    view.layer.masksToBounds=YES;
    view.layer.borderWidth = wid;
    view.layer.cornerRadius = radius;
}
//Method 2: (important) to set up a UIView border radian, width, and color
-(void)cf_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor*)color{
    view.layer.masksToBounds=YES;
    view.layer.borderWidth = wid;
    view.layer.cornerRadius = radius;
    CGColorRef cgcolor=[color CGColor];
    view.layer.borderColor=cgcolor;
}
//Method 3 (important) : batch set up multiple UIView border radian, width, and color
-(void)cf_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color{
    for (UIView *view  in views) {
        view.layer.masksToBounds=YES;
        view.layer.borderWidth = wid;
        view.layer.cornerRadius = radius;
        CGColorRef cgcolor=[color CGColor];
        view.layer.borderColor=cgcolor;
    }
}
//Method 4: set a UIView border radian, width and color, masksToBounds
-(void)cf_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool{
    view.layer.masksToBounds=isBool;
    view.layer.borderWidth = wid;
    view.layer.cornerRadius = radius;
    CGColorRef cgcolor=[color CGColor];
    view.layer.borderColor=cgcolor;
}
//Method 5: set up multiple batch UIView border radian, width and color, masksToBounds
-(void)cf_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool{
    for (UIView *view  in views) {
        view.layer.masksToBounds=isBool;
        view.layer.borderWidth = wid;
        view.layer.cornerRadius = radius;
        CGColorRef cgcolor=[color CGColor];
        view.layer.borderColor=cgcolor;
    }
}

@end
