//
//  UserDataManager.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataManager : NSObject

/**
 *  @brief  存储密码
 *
 *  @param  password    密码内容
 */
+(void)savePassWord:(NSString *)password;

/**
 *  @brief  读取密码
 *
 *  @return 密码内容
 */
+(id)readPassWord;

/**
 *  @brief  删除密码数据
 */
+(void)deletePassWord;



@end
