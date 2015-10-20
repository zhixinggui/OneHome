//
//  CacheManager.m
//  影讯
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "CacheManager.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@implementation CacheManager

+ (NSString *)getCacheSize
{   //获取图片缓存大小，默认单位:B
    NSInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    NSString *sizeStr;
    if (cacheSize < 1024) {
        sizeStr =  [NSString stringWithFormat:@"%lu B",cacheSize];
    }else if(cacheSize >= 1024 && cacheSize < 1024 * 1024)
    {
        sizeStr =  [NSString stringWithFormat:@"%.2f KB",cacheSize / 1024.0];
    }else if(cacheSize >= 1024 * 1024 && cacheSize < 1024 * 1024 * 1024)
    {
        sizeStr =  [NSString stringWithFormat:@"%.2f MB",cacheSize / (1024 * 1024.0)];
    }else
    {
        sizeStr =  [NSString stringWithFormat:@"%.2f GB",cacheSize / (1024 * 1024 * 1024.0)];
    }
    
    return sizeStr;
}


+ (void)clearCache:(NSUInteger)size success:(Success)successMessage fail:(Fail)failMessage
{
    [[SDImageCache sharedImageCache]clearDisk];
    if ([[SDImageCache sharedImageCache]getSize] == 0) {
        successMessage(@"清除成功");
    }else
    {
        failMessage(@"清除失败");
    }
}

@end
