//
//  JoinHotViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "JoinHotViewController.h"
#import "JoinHotCell.h"
#import "JoinHotModel.h"

#import "JoinAllListViewController.h"

@interface JoinHotViewController () <UITableViewDelegate,UITableViewDataSource,JoinHotCellDelegate>
{
    UITableView         *_tableView;
    
    NSMutableArray      *_dataArr;
    
    NSString            *_time;
    
}
@end

@implementation JoinHotViewController

#pragma mark - 生命周期
#pragma mark - 界面加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTitle:@"加入圈子"];
    
    [self initData];
    
    [self loadData];
    
    [self initUI];
    
}

#pragma mark - 加载初始化界面数据
-(void)loadData{
    [ViewTool showHUDWithText:@"正在拼命加载..." toView:self.view];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //封装参数
    [dict setValue:[NSNumber numberWithInteger:1] forKey:@"pageno"];
    [dict setValue:[NSNumber numberWithInteger:20] forKey:@"limit"];
    [dict setValue:[NSNumber numberWithInteger:0] forKey:@"time"];
    [dict setValue:[NSNumber numberWithInteger:1] forKey:@"sort"];
    [HttpTool sendPostWithUrl:JOIN_HOT_URL parameters:dict success:^(id data) {
        [ViewTool hideHUDFromView:self.view];
        id backData = OneJsonParserWithData(data);
        for (NSDictionary *dict in backData[@"data"]) {
            JoinHotModel *model = [JoinHotModel objectWithKeyValues:dict];
            [_dataArr addObject:model];
        }
        [_tableView reloadData];
    } fail:^(NSError *error) {
        [ViewTool hideHUDFromView:self.view];
        [ViewTool showHUDWithText:@"加载失败" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ViewTool hideHUDFromView:self.view];
        });
    }];
    
}


#pragma mark - 初始化界面
- (void)initUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, OneScreenW, OneScreenH - 64 ) style:UITableViewStylePlain];
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    _tableView.rowHeight = [JoinHotCell cellHeight];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionFooterHeight = 40;
    [self.view addSubview:_tableView];
}


#pragma mark - 数据初始化
- (void)initData{
    _dataArr = [NSMutableArray arrayWithCapacity:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JoinHotCell *cell = [JoinHotCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.model = _dataArr[indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"热门圈子";
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
        UIButton  *btn = [ViewTool createCustomButtonWithFrame:CGRectMake(0, 0, OneScreenW, 40) withCustomRect:CGRectMake(OneScreenW - 50, 5, 30, 0) title:@"查看所有圈子" imgName:@"seeMore" selectedImgName:nil bgImageName:nil font:OneFont(14.0f) target:self action:@selector(seeAll)];
        [btn setBackgroundColor: [UIColor blackColor]];
           return btn;
}


#pragma mark - 查看所有圈子
- (void)seeAll{
    JoinAllListViewController *allListVC = [[JoinAllListViewController alloc] init];
    [self.navigationController pushViewController:allListVC animated:YES];
}


#pragma mark - 加入或则取消
- (void)didSelectJoinOrQuit:(JoinHotModel *)model withIndex:(NSInteger)index{
    [_dataArr replaceObjectAtIndex:index withObject:model];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
