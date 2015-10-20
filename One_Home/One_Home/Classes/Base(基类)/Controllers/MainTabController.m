//
//  MainTabController.m
//  One_Home
//
//  Created by hanxiaocu on 15-9-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "MainTabController.h"

#import "BaseViewController.h"
#import "MainNavigationController.h"




@interface MainTabController () 

@end

@implementation MainTabController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //appearance 获取UITabBarItem 的最高权限 ，对它的操作就可以影响整个工程的UITabBarItem ,字体默认12 ，label默认是17
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:OneFont(12.0f)} forState:UIControlStateNormal];
    self.tabBar.backgroundImage = OneImage(@"night_navbar_bg2");
    
    //self.tabBar.backgroundColor = [UIColor blackColor];  //35 138 213
    
    [self createViewControllers];
    
  
    
}


-(void)createViewControllers
{
    NSArray *titles = @[@"租房子",@"找室友",@"打白条",@"我"];
    
    NSArray *classes = @[@"HouseListViewController",@"RoomieViewController",@"PayMentViewController",@"MineViewController"];
    
    NSArray *normalImgArr = @[@"icon_llf_off",@"icon_friend_off",@"icon_payment_off",@"icon_mine_off"];
    
    NSArray *selectedImgArr = @[@"icon_llf_on",@"icon_friend_on",@"icon_payment_on",@"icon_mine_on"];
    
    NSArray *urlArr = @[HOUSE_LIST_URL,HOUSE_LIST_URL,HOUSE_LIST_URL,HOUSE_LIST_URL];
    
    NSMutableArray *controllers = [[NSMutableArray alloc]init];
    
    for(int i = 0 ;i < 4; i ++){
        //将字符串形式的类名转换为类对象
        Class class = NSClassFromString(classes[i]);
        
        //root的对象看具体的class类对象
        BaseViewController *base = [[class alloc] init];
        
        base.urlStr = urlArr[i];
        
        MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:base];
        
        
        UIImage *normalImg = OneOriginalImage(normalImgArr[i]);
        UIImage *selectedImg = OneOriginalImage(selectedImgArr[i]);
        
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titles[i] image:normalImg selectedImage:selectedImg];
        
        item.title = titles[i];
        
        nav.tabBarItem = item;
        
        [controllers addObject:nav];
    }
    self.viewControllers = controllers;
}



























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
