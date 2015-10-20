//
//  HouseSearchModel.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-12.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HouseSearchModel : NSObject
/**
    "age_range": "",
	"region_id": "",
	"plate_id": "",
	"time": 1444806300,
	"money_max": 0,
	"limit": 20,
	"sort": -1,
	"square_max": 0,
	"square_min": 0,
	"gender": -1,
	"money_min": 0
 */

//年龄限制
@property (nonatomic,strong) NSString *age_range;

//区域
@property (nonatomic,strong) NSString *region_id;

//地点
@property (nonatomic,strong) NSString *plate_id;

//更新时间
@property (nonatomic,strong) NSNumber *time;

//最大钱数//最小钱数
@property (nonatomic,strong) NSNumber  *money_max;
@property (nonatomic,strong) NSNumber *money_min;

//最大面积和最小面积
@property (nonatomic,strong) NSNumber *square_max;
@property (nonatomic,strong) NSNumber *square_min;


@end
