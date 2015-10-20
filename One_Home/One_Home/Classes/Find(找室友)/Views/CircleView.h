//
//  CircleView.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *circleTable;


@property (nonatomic,strong) NSMutableArray *dataArr;

@end
