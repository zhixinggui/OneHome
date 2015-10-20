//
//  HttpTool.h
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"


typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(NSError *error);

@interface HttpTool : NSObject


// 封装Get网络请求
+ (void) sendGetWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;


// 封装Post网络请求
+ (void) sendPostWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;



@end
