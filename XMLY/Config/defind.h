//
//  defind.h
//  XiMaLaYa
//
//  Copyright © 2018年 com，baweijiaoyu. All rights reserved.
//

#ifndef defind_h
#define defind_h
// 主屏的宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
// 主屏的高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 获取视图动态宽度
/*
 *通过切图宽度计算不同手机的动态宽度，view_width为切图宽度，计算公式：切图宽度 ／ 切图总宽 ＝ 待求宽度（X）／ SCREEN_WIDTH（动态屏幕宽度）
 */
#define SCREEN_RATE_640_WIDTH(view_width) (view_width / 1242.0) * SCREEN_WIDTH

// 获取视图动态高度
/*
 *通过动态宽度求等比例高度，view_width为切图宽度，view_height为切图高度，计算公式：切图宽度 ／ 切图高度 ＝ 视图动态屏幕宽度｛SCREEN_RATE_640_WIDTH(view_width)｝ ／ 待求动态高度（X）
 */
#define SCREEN_RATE_640_HEIGHT(view_height,view_width) (view_height * (SCREEN_RATE_640_WIDTH(view_width))) / 1242.0

//获取视图的宽度
#define VIEW_WIDTH(view) view.frame.size.width
//获取视图的高度
#define VIEW_HEIGHT(view) view.frame.size.height
//获取视图的X值
#define VIEW_X(view) view.frame.origin.x
//获取视图的Y值
#define VIEW_Y(view) view.frame.origin.y
// 通用字体大小
// 所有 描述类的字体的大小
#define DES_FONT [UIFont systemFontOfSize:14]
// 所有 标题的字体大小
#define TITLE_FONT [UIFont systemFontOfSize:17]
// 第二标题的大小
#define SEC_FONT [UIFont systemFontOfSize:15]


// RGB 颜色
#define RGB_COLOR(RED,GREEN,BLUE) [UIColor colorWithRed:(RED/255.0) green:(GREEN/255.0) blue:(BLUE/255.0) alpha:1.0]
//contentview_width
#define Contenview_Width self.contentView.bounds.size.width
//contentview_height
#define Contenview_Height self.contentView.bounds.size.height


#endif /* defind_h */
