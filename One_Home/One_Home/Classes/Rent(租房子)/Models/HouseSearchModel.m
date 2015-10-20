//
//  HouseSearchModel.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-12.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "HouseSearchModel.h"

@implementation HouseSearchModel


- (instancetype)init
{
    if (self = [super init]) {
        self.age_range  = @"";
        
        self.region_id  = @"";
        self.plate_id   = @"";
        
        self.time = [NSNumber numberWithInteger:0];
        
        self.square_max = [NSNumber numberWithInteger:0];
        self.square_min = [NSNumber numberWithInteger:0];
        
        self.money_max = [NSNumber numberWithInteger:0];
        self.money_min = [NSNumber numberWithInteger:0];
        
    }
    return self;
}

@end
