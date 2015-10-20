//
//  HttpTool.m
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "HttpTool.h"



@implementation HttpTool


+ (void)sendGetWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
    
    
}

+ (void)sendPostWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    
    NSString *urlStr = [NSString stringWithFormat:url,Host_And_Port];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    [manager.requestSerializer setValue:@"affb3c12c1056b5cb874639fd950e83e" forHTTPHeaderField:@"Md5"];
    [manager.requestSerializer setValue:@"d7b8ad69-5530-5e8f-c249-75bcc24a5b46" forHTTPHeaderField:@"Session"];
    [manager.requestSerializer setValue:@"865088010143500" forHTTPHeaderField:@"Udid"];
    [manager.requestSerializer setValue:@"text/plain; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [manager.requestSerializer setValue:@"api.loulifang.com.cn" forHTTPHeaderField:@"Host"];
    [manager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
    
    [manager.requestSerializer setValue:@"2.7" forHTTPHeaderField:@"ClientVer"];
    
    [manager.requestSerializer setValue:@"android" forHTTPHeaderField:@"Platform"];
    [manager.requestSerializer setValue:@"Apache-HttpClient/UNAVAILABLE (java 1.4)" forHTTPHeaderField:@"User-Agent"];
    
    // 设置请求行方法为POST，与请求报文第一行对应
    [manager POST:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
    
    
}
















@end
