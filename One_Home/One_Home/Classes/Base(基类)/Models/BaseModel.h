//
//  BaseModel.h
//  One_Home
//
//  Created by hanxiaocu on 15-9-21.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, strong) NSString *app_id;

@property (nonatomic, strong) NSString *app_icon;

@property (nonatomic, strong) NSString *post_title;

@property (nonatomic, strong) NSString *app_apple_rated;


@property (nonatomic, strong) NSString *app_size;

@property (nonatomic, strong) NSString *app_desc;


@property (nonatomic, strong) NSString *app_price;

@property (assign,nonatomic) int  category;





@end
