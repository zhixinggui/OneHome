//
//  PayMentViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-9.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "PayMentViewController.h"

@interface PayMentViewController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation PayMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self addTitle:@"付房租"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.handwritingLoader = [[FeHandwriting alloc] initWithView:self.view];
    [self.handwritingLoader showWhileExecutingBlock:^{
        sleep(3.0f);
    } completion:^{
        [self initWeb];
    }];
    [self.view addSubview:self.handwritingLoader];
    
    
}

#pragma mark - webView加载
- (void)initWeb{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, OneScreenW, OneScreenH - 64 - 49)];
    
    //加载网络请求
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.loulifang.com/app/?device=android&temp=fq_index&mobile=18737175644"]]];
    
    webView.delegate = self;
    webView.userInteractionEnabled = YES;
    
    
    webView.scrollView.bounces = NO;
    
    [self.view addSubview:webView];
    _webView = webView;
    
}

@end
