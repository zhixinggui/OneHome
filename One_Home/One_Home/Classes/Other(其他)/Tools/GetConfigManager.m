//
//  GetConfigManager.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-13.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "GetConfigManager.h"
#import "RegionalModel.h"
#import "JSONModel.h"

@interface GetConfigManager ()

@end

@implementation GetConfigManager

+ (instancetype)sharedManager
{
    //Singleton instance
    static GetConfigManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[[self class] alloc] init];
    });
    return manager;
}


- (void)getOrSaveRegional{
    _regionArr = [NSMutableArray arrayWithCapacity:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"regionScopes.json" ofType:nil];
    id backData =
    [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",backData);
    for (NSDictionary  *dict in backData[@"data"]) {
        RegionalModel *model = [[RegionalModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [model saveOrUpdate];
        [_regionArr  addObject:model];
    }
    
    [HttpTool sendPostWithUrl:REGIONSCOPES_URL parameters:nil success:^(id data) {
        
        
        
        
    } fail:^(NSError *error) {
        
    }];
}



@end
