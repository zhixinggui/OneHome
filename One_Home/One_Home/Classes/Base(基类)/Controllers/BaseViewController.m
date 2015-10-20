//
//  BaseViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"



@interface BaseViewController ()
{
    
   
}
@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _isShowCityMenu = NO;
    //bg_nav_bar@2x
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav_bar"] forBarMetrics:UIBarMetricsDefault];
}



- (void)addTitle:(NSString *)title
{
    self.title = title;
    self.navigationController.navigationBar.contentMode = UIViewContentModeCenter;

}


- (void)setNavicationButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action isLeft:(BOOL)isLeft backgroudImgName:(NSString *)bgImgName selectedImgName:(NSString *)selectedImgName
{
    UIButton *btn = [ViewTool createButtonWithFrame:frame title:title  backgroundImgName:bgImgName selectedImgName:selectedImgName font:OneFont(16.0f) target:target action:action];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
