//
//  HousePhotoViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "HousePhotoViewController.h"

@interface HousePhotoViewController () <UIScrollViewDelegate>
{
    UIScrollView        *_scrollview;
    UIImageView         *_imageView;
}
@end

@implementation HousePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle:@"查看大图"];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    
    _scrollview = [[UIScrollView  alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollview];
    
    
    //构造方法，调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
    _imageView = [[UIImageView alloc] initWithImage:_image];
    // 一般setter方法[_imageview setImage:_image];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds  = YES;
    [_scrollview addSubview:_imageView];
    
    _scrollview.contentSize=_image.size;
    
    
    _scrollview.delegate = self;
    
    
    
    _scrollview.minimumZoomScale = 0.5;
    _scrollview.maximumZoomScale = 2.0;
}

#pragma mark - 缩放视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
#pragma mark - 开始缩放
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}
#pragma mark - 缩放完毕
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //缩放居中显示
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
}
#pragma mark - 允许自动旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
