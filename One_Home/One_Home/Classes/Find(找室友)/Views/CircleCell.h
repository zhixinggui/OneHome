//
//  CircleCell.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JoinHotModel.h"

@interface CircleCell : UITableViewCell

@property (nonatomic,strong) JoinHotModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)addsubViews;

+ (NSString *)identifier;


+ (CGFloat)cellHeight;

@end
