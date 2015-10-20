//
//  MainNavigationController.m
//  One_Home
//
//  Created by hanxiaocu on 15-9-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor whiteColor];

    
    //获取导航条的文字属性
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],
                                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav_bar"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:OneImage(@"back")]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
