//
//  UtilSG.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-8.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilSG : NSObject


// 存值
+ (void)setObject:(id)obj forKey:(NSString *)key;
+ (void)setBool:(BOOL)b forKey:(NSString *)key;

// 取值
+ (id)objectForkey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;


@end
