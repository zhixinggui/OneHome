//
//  CityModel.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-16.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic,strong) NSString *city_name;

@property (nonatomic,strong) NSString *city_code;

@property (nonatomic,strong) NSString *request_url;

//开放状态
@property (nonatomic,strong) NSNumber *opened;

@end
