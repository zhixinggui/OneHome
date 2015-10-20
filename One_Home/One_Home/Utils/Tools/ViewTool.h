//
//  ViewTool.h
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewTool : NSObject

//创建图标
+ (UIImageView *) createIconViewWithFrame:(CGRect)frame;

//创建标签
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font;



//创建button
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title  backgroundImgName:(NSString *)bgImgName selectedImgName:(NSString *)selectedImgName font:(UIFont *)font target:(id)target action:(SEL)action;


//创建Custombutton
+ (UIButton *)createCustomButtonWithFrame:(CGRect)frame withCustomRect:(CGRect)custom  title:(NSString *)title  imgName:(NSString *)imgName selectedImgName:(NSString *)selectedImgName bgImageName:(NSString *)bgImage font:(UIFont *)font target:(id)target action:(SEL)action;


//创建分割线
+ (UIView *)createDividerWithFrame:(CGRect)frame withBgImage:(NSString *)bgImgName andColor:(UIColor *)color;


//创建UItextFile
+ (UITextField *)createTextFiledWithFrame:(CGRect )frame placeHolder:(NSString *)placeHolder;

//创建ImageView

+ (UIImageView *)createImgViewWithFram:(CGRect)frame imgName:(NSString *)imgName;




// 显示缓冲视图
+ (void)showHUDWithText:(NSString *)text toView:(UIView *)view;

// 隐藏缓冲视图
+ (void)hideHUDFromView:(UIView *)view;












@end
