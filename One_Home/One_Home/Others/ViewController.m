//
//  ViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-2.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableView 代理和数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ids = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ids];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ids]
        ;    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
