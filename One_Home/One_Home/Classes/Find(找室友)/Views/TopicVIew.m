//
//  TopicVIew.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "TopicVIew.h"

#import "TopicCell.h"

#import "JoinHotModel.h"

@interface TopicVIew ()
{
    
    NSMutableArray      *_hotArr;//热门话题
    NSMutableArray      *_newArr;//最新话题
    
    NSNumber            *_time;
    
    NSInteger           _pageNo;
}
@end

@implementation TopicVIew


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self  = [super initWithFrame:frame]) {
        [self initData];
        [self loadData];
        _topicTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _topicTable.delegate = self;
        _topicTable.dataSource = self;
        _topicTable.rowHeight = [TopicCell cellHeight];
        [self addSubview:_topicTable];
    }
    return self;
}

-(void)layoutSubviews{
    
}

- (void)initData{
    _hotArr = [NSMutableArray array];
    _newArr = [NSMutableArray array];
    _time = [NSNumber numberWithInteger:0];
    _pageNo = 1;
}

- (void)loadData{
    [ViewTool showHUDWithText:@"正在加载..." toView:self];
    //包装参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[NSNumber numberWithInteger:20] forKey:@"limit"];
    [dict setValue:[NSNumber numberWithInteger:-1] forKey:@"sort"];
    [dict setValue:[NSNumber numberWithInteger:_pageNo] forKey:@"pageno"];
    [dict setValue:_time forKey:@"time"];
    [HttpTool sendPostWithUrl:HOT_NEW_URL parameters:dict success:^(id data) {
        id backData = OneJsonParserWithData(data);
        NSDictionary *dataDict = backData[@"data"];
        NSArray  *hotArr = dataDict[@"hot_list"];
        for (NSDictionary *dict in hotArr) {
            JoinHotModel *model = [JoinHotModel objectWithKeyValues:dict];
            [_hotArr addObject:model];
        }
        NSArray  *newArr = dataDict[@"new_list"];
        for (NSDictionary *dict in newArr) {
            JoinHotModel *model = [JoinHotModel objectWithKeyValues:dict];
            [_newArr addObject:model];
        }
         [_topicTable reloadData];
    } fail:^(NSError *error) {
        
    }];

}

#pragma mark - UItableView 代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"热门话题";
    }
    return @"最新话题";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _hotArr.count;
    }else{
        return _newArr.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicCell *cell = [TopicCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.model = _hotArr[indexPath.row];
        
    }else{
        cell.model = _newArr[indexPath.row];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

@end
