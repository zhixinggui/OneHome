//
//  JoinHotCell.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JoinHotModel;
@protocol JoinHotCellDelegate <NSObject>

-(void)didSelectJoinOrQuit:(JoinHotModel *)model withIndex:(NSInteger)index;

@end

@interface JoinHotCell : UITableViewCell


@property (nonatomic,strong) JoinHotModel *model;

@property (nonatomic,weak)  id<JoinHotCellDelegate>delegate;

@property (nonatomic,assign) NSInteger index;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)addsubViews;

+ (NSString *)identifier;


+ (CGFloat)cellHeight;

@end
