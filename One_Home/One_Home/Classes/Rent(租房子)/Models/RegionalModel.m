//
//  RegionalModel.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-13.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "RegionalModel.h"

@implementation RegionalModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.mid = value;
    }
}

@end
