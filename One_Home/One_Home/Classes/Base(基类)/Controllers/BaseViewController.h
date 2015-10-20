//
//  BaseViewController.h
//  One_Home
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeHandwriting.h"

#import "CityMenu.h"

@interface BaseViewController : UIViewController<CityMenuDelegate>

@property (nonatomic, strong) NSString *urlStr;


@property (nonatomic,strong) NSString *request_url;

@property (nonatomic,assign) BOOL isShowCityMenu;

@property (nonatomic,strong) CityMenu *menu;


@property (strong, nonatomic) FeHandwriting *handwritingLoader;


/*
 导航栏 标题
 */
- (void)addTitle:(NSString *)title;

- (void)setNavicationButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target
                        action:(SEL)action isLeft:(BOOL)isLeft backgroudImgName:(NSString *)bgImgName
               selectedImgName:(NSString *)selectedImgName;



@end
