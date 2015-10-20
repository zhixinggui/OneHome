//
//  HouseListCell.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-12.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HouseModel;
@interface HouseListCell : UITableViewCell


@property (nonatomic,strong) HouseModel *model;


+(instancetype)cellWithTableView:(UITableView *)tableView hasHouse:(BOOL)hasHouse;


+(CGFloat) cellHeight;

@end
