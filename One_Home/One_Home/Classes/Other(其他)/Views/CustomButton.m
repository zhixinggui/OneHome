//
//  CustomButton.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-13.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

#pragma mark - 覆盖高亮状态
//- (void)setHighlighted:(BOOL)highlighted
//{}

- (void)setCustom:(CGRect)custom
{
    _custom = custom;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    //(70, 15, 10, 0)
    //(x:60, y:18, width:10, height:0)
    CGFloat imageX = self.custom.origin.x;
    CGFloat imageY = self.custom.origin.y;
    CGFloat imageW = self.custom.size.width;
    CGFloat imageH = contentRect.size.height - 2 * imageY ;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 5.0f;
    CGFloat titleY = 10.0f;
    CGFloat titleW = self.custom.origin.x - titleX;
    CGFloat titleH = contentRect.size.height - 2 * titleY;
    //(0, 0, 80, 44)
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end
