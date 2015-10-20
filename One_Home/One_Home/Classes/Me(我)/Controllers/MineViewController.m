//
//  MineViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-9.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "MineViewController.h"

#import "AppDelegate.h"

#import "MineBar.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "BLKDelegateSplitter.h"

#import "UserDataManager.h"

#import "LoginViewController.h"

@interface MineViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_tableView;
    MineBar         *_mineBar;
    BLKDelegateSplitter *_delegateSplitter;
    
    LoginViewController  *_loginVC;
}


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSString *phoneNum  = [UserDataManager readPassWord];
    NSLog(@"%@",phoneNum);
    if (![phoneNum isEqualToString:@"123"]) {
        _loginVC = [[LoginViewController alloc] init];
        [self presentViewController:_loginVC animated:YES completion:nil];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
    [self addTitle:@"我"];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self createUI];
    
    
}



- (void)createUI{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0,CGRectGetWidth(self.view.frame), OneScreenH  - 49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.rowHeight = 55.0f;
    
    _tableView.sectionFooterHeight = 0.1;
    
    [self.view addSubview:_tableView];
    
    _mineBar = [[MineBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 150)];
    SquareCashStyleBehaviorDefiner *behaviorDefiner = [[SquareCashStyleBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.1];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.1 end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elasticMaximumHeightAtTop = YES;
    _mineBar.behaviorDefiner = behaviorDefiner;
    
    [self.view addSubview:_mineBar];
    
    _delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:behaviorDefiner secondDelegate:self];
    
    _tableView.delegate = (id<UITableViewDelegate>)_delegateSplitter;
    _tableView.contentInset = UIEdgeInsetsMake(_mineBar.maximumBarHeight, 0.0, 0.0, 0.0);
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        cell.textLabel.text = @"cell";
    }
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
