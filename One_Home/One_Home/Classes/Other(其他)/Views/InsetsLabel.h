//
//  InsetsLabel.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-17.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsLabel : UILabel

@property(nonatomic) UIEdgeInsets insets;
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;

@end
