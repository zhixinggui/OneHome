//
//  STKeychain.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface STKeychain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service ;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service ;

@end