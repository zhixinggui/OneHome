//
//  CacheManager.h
//  影讯
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

typedef void(^Fail)(NSString *failMessage);
typedef void(^Success)(NSString *successMessage);

@interface CacheManager : NSObject

//获取图片缓存大小
+ (NSString *)getCacheSize;

//清除图片缓存
+ (void)clearCache:(NSUInteger)size success:(Success)successMessage fail:(Fail)failMessage;


@end
