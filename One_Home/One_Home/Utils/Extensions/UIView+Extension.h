//
//  UIView+Extension.h
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@property (assign,nonatomic) CGPoint origin;

/**
 *	@brief	获取左上角纵坐标
 *
 *	@return	坐标值
 */
- (CGFloat)top;

/**
 *	@brief	获取视图右下角横坐标
 *
 *	@return	坐标值
 */
- (CGFloat)right;

/**
 *	@brief	获取视图右下角纵坐标
 *
 *	@return	坐标值
 */
- (CGFloat)bottom;



/**
 *	@brief	删除所有子对象
 */
- (void)removeAllSubviews;

@end
