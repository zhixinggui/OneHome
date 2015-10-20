//
//  CircleView.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "CircleView.h"

#import "CircleCell.h"

@implementation CircleView

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self  = [super initWithFrame:frame]) {
        [self loadData];
        _circleTable = [[UITableView alloc] initWithFrame:self.bounds];
        _circleTable.delegate = self;
        _circleTable.dataSource = self;
        [self addSubview:_circleTable];
    }
    return self;
}

- (void)layoutSubviews{


}

- (void)loadData{


}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count > 0 ? _dataArr.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CircleCell *cell = [CircleCell cellWithTableView:tableView];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

@end
