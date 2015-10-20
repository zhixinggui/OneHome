//
//  JoinAllListViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "JoinAllListViewController.h"

#import "JoinHotModel.h"

#import "JoinHotCell.h"

@interface JoinAllListViewController () <UITableViewDelegate ,UITableViewDataSource,JoinHotCellDelegate>
{
    UITableView         *_listTableView;
    NSMutableArray      *_dataArr;
    
    NSNumber            *_time;
    
    NSInteger           _pageNo;
}
@end

@implementation JoinAllListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitle:@"全部圈子"];
    
    [self initData];
    
    [self initUI];
    
    [self createRefresh];
}


- (void)initData{
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    _time = [NSNumber numberWithInteger:0];
    _pageNo = 1;
}


- (void)initUI{
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, OneScreenW, OneScreenH - 64) style:UITableViewStylePlain];
    _listTableView.separatorStyle = UITableViewCellAccessoryNone;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = [JoinHotCell cellHeight];
    [self.view addSubview:_listTableView];
    
}



#pragma mark - 刷新视图
- (void)createRefresh{
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _listTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _time = [NSNumber numberWithInteger:0];
        [weakSelf loadAllListData:YES];
    }];
    // 马上进入刷新状态
    [_listTableView.header beginRefreshing];
    
    
    // 上拉加载
    _listTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _time = [NSNumber numberWithInteger:[[[_dataArr lastObject] create_time] integerValue]];
        _pageNo ++;
        [weakSelf loadAllListData:NO];
    }];
}

#pragma mark - 加载数据
- (void)loadAllListData:(BOOL)isRemoveAll{
    [ViewTool showHUDWithText:@"正在加载..." toView:self.view];
    if (isRemoveAll) {
        [_dataArr removeAllObjects];
    }
    //包装参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[NSNumber numberWithInteger:20] forKey:@"limit"];
    [dict setValue:[NSNumber numberWithInteger:-1] forKey:@"sort"];
    [dict setValue:[NSNumber numberWithInteger:_pageNo] forKey:@"pageno"];
    [dict setValue:_time forKey:@"time"];
    [HttpTool sendPostWithUrl:ALL_LIST_JOIN_URL parameters:dict success:^(id data) {
        //结束刷新 隐藏缓冲视图
        [_listTableView.header endRefreshing];
        [_listTableView.footer endRefreshing];
        [ViewTool hideHUDFromView:self.view];
        id backData = OneJsonParserWithData(data);
        for (NSDictionary *dict  in backData[@"data"]) {
            JoinHotModel *model = [JoinHotModel objectWithKeyValues:dict];
            [_dataArr addObject:model];
        }
        [_listTableView reloadData];
        if (isRemoveAll) {
            [_listTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    } fail:^(NSError *error) {
        [ViewTool hideHUDFromView:self.view];
        [_listTableView.header endRefreshing];
        [_listTableView.footer endRefreshing];
        [ViewTool showHUDWithText:@"加载失败..." toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ViewTool hideHUDFromView:self.view];
        });
        
    }];
}

#pragma mark - number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

#pragma mark - cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoinHotCell *cell = [JoinHotCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArr[indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}




#pragma mark - 加入或则取消
- (void)didSelectJoinOrQuit:(JoinHotModel *)model withIndex:(NSInteger)index{
    [_dataArr replaceObjectAtIndex:index withObject:model];
    [_listTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
