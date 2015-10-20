//
//  DBManager.h
//  LimitFreeComplete
//
//  Created by Yuen on 15/6/7.
//  Copyright (c) 2015年 Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBManager : NSObject


//单例模式
+ (instancetype)shareManager;


/*
 增删改查
 */


/*
 是否存在
 */


/*
 获取所有数据
 */
- (NSArray *)getAll;



@end
