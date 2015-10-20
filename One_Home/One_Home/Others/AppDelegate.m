//
//  AppDelegate.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-2.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "AppDelegate.h"

#import "IQKeyboardManager.h"

#import "MainTabController.h"

#import "WaitingViewController.h"

#import "GetConfigManager.h"

@interface AppDelegate ()
{
    UIScrollView *_scrollView;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.phoneNum = @"123";
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // 设置window的根控制器
    /** 
     判断应用是否是新版本的第一次进入,如果是第一次进入,需要展示新特征介绍页面,否则直接进入主页面.
     实现思路:获取应用的版本号,获取沙盒存储的版本号,如果沙盒存储的版本号与当前应用版本号一致,说明不是第一次进入新版本;不一致,说明是第一次进入新版本.
     获取应用的版本号 1,@"CFBundleVersion" 2,(NSString *)kCFBundleVersionKey
     */
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey];
    NSLog(@"%@:currentVersion", currentVersion);
    
    NSLog(@"%@",NSHomeDirectory());
    
    // 获取沙盒存储的应用版本号
    //  NSString *saveVersion = [UtilSG objectForkey:OneSaveVersion];
    
    //    if ([currentVersion isEqualToString:saveVersion]) {
    // 进入主界面
     [self gotoMainTabbarControll];
    //    } else {
    //        // 进入新特征界面
    //[self gotoScrollView];
    //
    //        // 存储新的版本号
    //        [UtilSG setObject:currentVersion forKey:OneSaveVersion];
    //    }
    
    
    
    
    /**
     *  开启智能键盘
     */
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    keyboardManager.enableAutoToolbar = NO;
    
    
    //GetConfigManager *configManager = [GetConfigManager sharedManager];
    //[configManager getOrSaveRegional];
    
    return YES;
}

#pragma mark 主界面
- (void)gotoMainTabbarControll {
    NSLog(@"进入主界面");
    [UIView animateWithDuration:1.0f animations:^{
        _scrollView.transform = CGAffineTransformMakeScale(2, 2);
        _scrollView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        self.window.rootViewController = [[MainTabController alloc] init];
    }];
}

#pragma mark 新特征界面
- (void)gotoScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, OneScreenW, OneScreenH)];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    
    int imgCount = 4;
    scrollView.contentSize = CGSizeMake(imgCount * OneScreenW, 0);
    
    for (int i = 0; i < imgCount; i ++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * OneScreenW, 0, OneScreenW, OneScreenH)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"newer0%i.png", i + 1]];
        [scrollView addSubview:iv];
        
        if (imgCount - 1 == i) {
            iv.userInteractionEnabled = YES;
            // 最后一张图片需要添加一个进入应用的按钮
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(OneScreenW - 200, 0, 200, 150)];
            btn.backgroundColor = [UIColor clearColor];
            btn.center = CGPointMake(OneScreenW - 100, OneScreenH - 200);
            [btn addTarget:self action:@selector(gotoMainTabbarControll) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:btn];
        }
    }
    
    [self.window addSubview:scrollView];
    _scrollView = scrollView;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
