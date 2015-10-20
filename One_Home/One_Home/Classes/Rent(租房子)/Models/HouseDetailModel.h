//
//  DetailModel.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-15.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HouseDetailModel : NSObject

@property (nonatomic,strong) NSString *room_id;

@property (nonatomic,strong) NSString *room_name;

@property (nonatomic,strong) NSString *room_type;

@property (nonatomic,strong) NSString *room_area;

@property (nonatomic,strong) NSString *pay_method;

@property (nonatomic,strong) NSString *room_money;

@property (nonatomic,strong) NSString *room_direction;

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *region_name;

@property (nonatomic,strong) NSString *estate_name;

@property (nonatomic,strong) NSString *room_no;

@property (nonatomic,strong) NSString *business_coupon;

@property (nonatomic,strong) NSString *owner_evaluate_cnt;

@property (nonatomic,strong) NSArray *roomies;

@property (nonatomic,strong) NSString *owner_name;

@property (nonatomic,strong) NSArray *owner_like;

@property (nonatomic,strong) NSString *area;

@property (nonatomic,strong) NSString *floor;

@property (nonatomic,strong) NSString *floor_total;

@property (nonatomic,strong) NSString *room_num;

@property (nonatomic,strong) NSString *hall_num;

@property (nonatomic,strong) NSString *wei_num;

@property (nonatomic,strong) NSString *decoration;


/**
 *  是否已经出租
 */
@property (nonatomic,strong) NSString *check_in_state;

/**
 *  房屋描述
 */

@property (nonatomic,strong) NSString *room_description;

@property (nonatomic,strong) NSString *owne_number;


/**
 *  房屋设备
 */
@property (nonatomic,strong) NSArray *room_facility;

@property (nonatomic,strong) NSArray *public_facility;


/**
 *  房屋图片
 */
@property (nonatomic,strong) NSArray *image_urls;

@end
