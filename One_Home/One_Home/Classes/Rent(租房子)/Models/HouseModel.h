//
//  HouseModel.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-12.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//


#import "JSONModel.h"


@interface HouseModel : NSObject

//id
@property (nonatomic,copy) NSString *room_id;


//类型:套件,主卧
@property (nonatomic,copy) NSString *room_name;

//面积
@property (nonatomic,copy) NSString *room_area;

//房屋朝向 "1009":南 1010:北 1001:南北 1004:东南
@property (nonatomic,copy) NSString *room_direction;

//主图
@property (nonatomic,copy) NSString *main_img_path;

//租金
@property (nonatomic,copy) NSString *room_money;


//区域名称(浦东）
@property (nonatomic,copy) NSString *region_name;

//地区街道()
@property (nonatomic,copy) NSString *scope_name;

//小区
@property (nonatomic,copy) NSString *estate_name;

//有无优惠
@property (nonatomic,copy) NSString *business_coupon;



//付款方式
@property (nonatomic,strong) NSString *pay_method;

//房间类型
@property (nonatomic,strong) NSString *room_type;

//房屋性质
@property (nonatomic,strong) NSString *business_type;

@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *update_time;


@end
