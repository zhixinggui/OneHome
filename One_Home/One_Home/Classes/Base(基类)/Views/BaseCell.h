//
//  BaseCell.h
//  One_Home
//
//  Created by hanxiaocu on 15-9-21.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;
@interface BaseCell : UITableViewCell


@property (nonatomic,strong) BaseModel *model;




+ (BaseCell *)cellWithTableView:(UITableView *)tableView;




+ (CGFloat)cellHeight;

@end
