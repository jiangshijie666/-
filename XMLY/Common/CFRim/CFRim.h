//
//  CFRim.h
//  StudyJapanese
//
//  Created by Devel on 15/12/3.
//  Copyright © 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFRim : UIView
//Set a UIView border radian and width (default masksToBounds to YES)
-(void)cf_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid;
//##Set a UIView border radian and width (default masksToBounds to YES)
-(void)cf_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color;
//##(important) batch set up multiple UIView border radian, width and color (default masksToBounds to YES)
-(void)cf_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color;
//Set a UIView border radian, width and color, masksToBounds
-(void)cf_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool;
//The radian of batch set up multiple UIView border, width and color, masksToBounds
-(void)cf_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool;
@end
