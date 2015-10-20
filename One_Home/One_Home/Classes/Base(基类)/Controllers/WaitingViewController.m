//
//  FeHandwritingViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-9-21.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "WaitingViewController.h"
#import "FeHandwriting.h"
#import "UIColor+flat.h"
#import "MainTabController.h"

@interface WaitingViewController ()
@property (strong, nonatomic) FeHandwriting *handwritingLoader;

@end

@implementation WaitingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];//[UIColor colorWithHexCode:@"#ffe200"];
    
    _handwritingLoader = [[FeHandwriting alloc] initWithView:self.view];
    [self.view addSubview:_handwritingLoader];
    
    [_handwritingLoader showWhileExecutingBlock:^{
        [self myTask];
    } completion:^{
        CATransition *ani = [CATransition animation];
        ani.type = @"rippleEffect";//水波纹
        ani.duration = 2.0f;
        ani.subtype = kCATransitionFromBottom;
        [self.navigationController.view.layer addAnimation:ani forKey:nil];
        [self.navigationController pushViewController:[[MainTabController alloc] init] animated:NO];
         [self removeFromParentViewController];
    }];
}
- (void)myTask
{
     sleep(2);
     self.view.window.rootViewController = [[MainTabController alloc] init];
}

@end
