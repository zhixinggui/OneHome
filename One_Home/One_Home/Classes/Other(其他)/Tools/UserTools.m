//
//  UserTools.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-9.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "UserTools.h"

@implementation UserTools

+ (BOOL)isLogin
{
    //判断是否登陆，由登陆状态判断启动页面
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    //如果用户未登陆则把根视图控制器改变成登陆视图控制器
    if (name == nil)
    {
        return NO;
    }
    return YES;
}

+ (void)Logout
{
    //获取UserDefaults单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //移除UserDefaults中存储的用户信息
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults synchronize];
    //获取storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取注销后要跳转的页面
    id view = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    
    //模态展示出登陆页面
    //    [self presentViewController:view animated:YES completion:^{
    //    }];
}

@end
