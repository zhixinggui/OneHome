//
//  TopicCell.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JoinHotModel;
@interface TopicCell : UITableViewCell


@property (nonatomic,strong) JoinHotModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(NSString *)identifier;

+(CGFloat)cellHeight;


@end
