//
//  BaseTabBarViewController.m
//  TaoPiao
//
//  Created by 黎应明 on 2017/8/30.
//  Copyright © 2017年 黎应明. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavViewController.h"
@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor colorWithHexString:@"5AD485"];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    NSString *tabBarImageNameNormal = @"default_tab_icon_home";
    NSString *tabBarImageNameSelected = @"select_tab_icon_home";
    NSString *title = @"首页";

    HomePageViewController *homeVC = [[HomePageViewController alloc] initWithTableViewStyle:1];

    BaseNavViewController *homeNav = [[BaseNavViewController alloc] initWithRootViewController:homeVC];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:tabBarImageNameNormal] selectedImage:[UIImage imageNamed:tabBarImageNameSelected]];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    homeVC.tabBarItem = tabBarItem;
//
//
    ClassificationViewController *classifyVC = [ClassificationViewController alloc];
    BaseNavViewController *classifyNav = [[BaseNavViewController alloc] initWithRootViewController:classifyVC];
    tabBarImageNameNormal = @"default_tab_icon_classificatition";
    tabBarImageNameSelected = @"select_tab_icon_classificatition";
    title = @"分类";
    tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:tabBarImageNameNormal] selectedImage:[UIImage imageNamed:tabBarImageNameSelected]];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    classifyVC.tabBarItem = tabBarItem;
//
//
    ChatViewController *Calerdervc = [[ChatViewController alloc]initWithTableViewStyle:1];
    BaseNavViewController *calerNav = [[BaseNavViewController alloc] initWithRootViewController:Calerdervc];
    tabBarImageNameNormal = @"tab_index";
    tabBarImageNameSelected = @"tab_index_selected";
    title = @"聊天";
    tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:tabBarImageNameNormal] selectedImage:[UIImage imageNamed:tabBarImageNameSelected]];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    Calerdervc.tabBarItem = tabBarItem;
//
//
     MyViewController *myVC = [[MyViewController alloc]initWithNibName:@"MyViewController" bundle:nil];
    BaseNavViewController *myNav = [[BaseNavViewController alloc] initWithRootViewController:myVC];
    tabBarImageNameNormal = @"tab_me";
    tabBarImageNameSelected = @"tab_me_selected";
    title = @"我的";
    tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:tabBarImageNameNormal] selectedImage:[UIImage imageNamed:tabBarImageNameSelected]];
//    tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil selectedImage:nil];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    myVC.tabBarItem = tabBarItem;

    NSArray *navArray = [NSArray arrayWithObjects:homeNav,classifyNav,calerNav,myNav, nil];
    [self setViewControllers:navArray];
   
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    if ([item.title isEqualToString:@"优惠劵"]) {
//        if (![Tool islogin]) {
//            [Tool loginWithAnimated:YES viewController:nil];
//             MLog(@"tabbar%@",item.title);
//        }
    }
   
   
    
    
}


@end
