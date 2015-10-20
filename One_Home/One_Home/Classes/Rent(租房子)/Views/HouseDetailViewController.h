//
//  HouseDetailViewController.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-12.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "BaseViewController.h"

@class HouseModel;

@interface HouseDetailViewController : BaseViewController

/**
 *  房屋id
 */

@property (nonatomic,strong)  NSString *roomId;


/*
 是否有TabBar
 */
@property (assign,nonatomic) BOOL hasTabbar;

@end
