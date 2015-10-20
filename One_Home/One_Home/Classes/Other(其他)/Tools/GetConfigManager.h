//
//  GetConfig.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-13.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetConfigManager : NSObject

//地区数组
@property (nonatomic,strong) NSMutableArray *regionArr;



+ (instancetype)sharedManager;


- (void)getOrSaveRegional;

@end
