//
//  ViewTool.m
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "ViewTool.h"
#import "UIImage+Extension.h"

#import "CustomButton.h"

@implementation ViewTool


+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    //label.textColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6];
    label.font = font;
    return label;
}

+ (UIImageView *)createIconViewWithFrame:(CGRect)frame
{
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:frame];
    icon.backgroundColor = [UIColor whiteColor];
    icon.layer.cornerRadius = 10.0f;
    icon.layer.masksToBounds = YES;
    return icon;
    
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title  backgroundImgName:(NSString *)bgImgName selectedImgName:(NSString *)selectedImgName  font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    // button.contentMode = UIViewContentModeCenter;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (bgImgName) {
        [button setBackgroundImage:[[UIImage resizableImageWithName:bgImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if (selectedImgName) {
        [button setBackgroundImage:[[UIImage imageNamed:selectedImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}


+ (UIButton *)createCustomButtonWithFrame:(CGRect)frame withCustomRect:(CGRect)custom title:(NSString *)title imgName:(NSString *)imgName selectedImgName:(NSString *)selectedImgName bgImageName:(NSString *)bgImage font:(UIFont *)font target:(id)target action:(SEL)action
{
    CustomButton *btn = [[CustomButton alloc] initWithFrame:frame];
    btn.custom = custom;
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (imgName) {
        [btn setImage:OneImage(imgName) forState:UIControlStateNormal];
    }
    if (selectedImgName) {
        [btn setImage:OneImage(selectedImgName) forState:UIControlStateSelected];
    }
    
    if (bgImage) {
        [btn setBackgroundImage:[UIImage resizableImageWithName:bgImage] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizableImageWithName:bgImage] forState:UIControlStateHighlighted];
    }
    if (font) {
        btn.titleLabel.font = font;
    }
    
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIView *)createDividerWithFrame:(CGRect)frame withBgImage:(NSString *)bgImgName andColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    if (bgImgName) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImgName]];
        [view addSubview:imageView];
    }else{
        view.backgroundColor = [color  colorWithAlphaComponent:0.4];
    }
    return view;
}


+ (UITextField *)createTextFiledWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    UITextField *textFiled = [[UITextField alloc] initWithFrame:frame];
    if (placeHolder) {
        [textFiled setPlaceholder:placeHolder];
    }
    textFiled.borderStyle = UITextBorderStyleRoundedRect;
    return textFiled;
}

+ (UIImageView *)createImgViewWithFram:(CGRect)frame imgName:(NSString *)imgName
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:frame];
    if (imgName) {
        imgView.image = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return imgView;
}



+ (void)showHUDWithText:(NSString *)text toView:(UIView *)view
{
    // 创建缓冲视图
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
}

+ (void)hideHUDFromView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
