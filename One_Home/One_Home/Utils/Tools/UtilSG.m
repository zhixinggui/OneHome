//
//  UtilSG.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-8.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "UtilSG.h"

@implementation UtilSG
+ (void)setObject:(id)obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBool:(BOOL)b forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:b forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForkey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (BOOL)boolForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
