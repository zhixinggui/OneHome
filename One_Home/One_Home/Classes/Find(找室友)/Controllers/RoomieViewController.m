//
//  RoomieViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-9.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "RoomieViewController.h"
#import "JoinHotViewController.h"

#import "TopicVIew.h"
#import "CircleView.h"

@interface RoomieViewController ()

@end

@implementation RoomieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"找室友";
     self.view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    
    [self setNavicationButtonWithFrame:CGRectMake(0, 0, 80, 44) title:@"加入圈子" target:self
                                action:@selector(joinHot) isLeft:NO backgroudImgName:nil selectedImgName:nil];
    
    
    
    [self initUI];
    
}
#pragma mark - 布局界面
-(void)initUI{
    TopicVIew *topicView = [[TopicVIew alloc] initWithFrame:CGRectMake(0, 100, OneScreenW, OneScreenH - 64 - 49 - 100)];
    [self.view addSubview:topicView];

}





#pragma mark - 加入圈子
- (void)joinHot{
    JoinHotViewController *joinHotVC = [[JoinHotViewController alloc] init];
    joinHotVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:joinHotVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
