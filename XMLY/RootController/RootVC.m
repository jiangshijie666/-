//
//  RootVC.m
//  XMLY
//
//  Created by 耿荣林 on 2018/7/4.
//  Copyright © 2018年 耿荣林. All rights reserved.
//

#import "RootVC.h"
#import "FirstPageVC.h"
#import "ListenVC.h"
#import "PlayVC.h"
#import "FindVC.h"
#import "MineVC.h"

@interface RootVC ()

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    FirstPageVC *firstVC = [[FirstPageVC alloc]init];
    firstVC.title = @"首页";
    UINavigationController *firstNC = [[UINavigationController alloc]initWithRootViewController:firstVC];
    
    ListenVC *listenVC = [[ListenVC alloc]init];
    listenVC.title = @"我听";
    UINavigationController *listenNC = [[UINavigationController alloc]initWithRootViewController:listenVC];
    
    PlayVC *playVC = [[PlayVC alloc]init];
    UINavigationController *playNC = [[UINavigationController alloc]initWithRootViewController:playVC];
    
    FindVC *findVC = [[FindVC alloc]init];
    findVC.title = @"发现";
    UINavigationController *findNC = [[UINavigationController alloc]initWithRootViewController:findVC];
    
    MineVC *mineVC = [[MineVC alloc]init];
    mineVC.title = @"个人";
    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    
    self.viewControllers = @[firstNC,listenNC,playNC,findNC,mineNC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
