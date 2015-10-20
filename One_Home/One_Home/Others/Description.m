//
//  Description.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-8.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "Description.h"

@implementation Description

#pragma mark - FontAwesome 使用
/**
 https://github.com/alexdrone/ios-fontawesome
 http://fortawesome.github.io/Font-Awesome/icons
 */

#pragma mark -NSString+FontAwesome
/*
 UILabel *label = [...]
 label.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
 label.text = [NSString fontAwesomeIconStringForEnum:FAGithub];
 label.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-github"];
 */
#pragma mark -UIImage+FontAwesome
/**
 UIImage *github = [UIImage imageWithIcon:@"fa-github" backgroundColor:[UIColor purpleColor] iconColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:255] iconScale:2.f fontSize:20];
 */
#pragma mark -FAImageView默认图片
/**
 FAImageView *imageView = [[FAImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];
 imageView.image = nil;
 [imageView setDefaultIconIdentifier:@"fa-github"];
 */




#pragma mark - 其他待续
@end
