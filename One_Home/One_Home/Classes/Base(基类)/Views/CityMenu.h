//
//  CityMenu.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-16.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityModel;

@protocol CityMenuDelegate <NSObject>

- (void)didSelectedCity:(CityModel *)city;

@end

@interface CityMenu : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *menuTable;

@property (nonatomic,strong) NSMutableArray *cityArr;


@property (nonatomic,weak)  id<CityMenuDelegate>delegate;


- (void)addSubviews;

- (void)showCityMenu:(BOOL)isShow;

@end
