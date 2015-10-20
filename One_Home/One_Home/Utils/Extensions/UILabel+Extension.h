//
//  UILabel+Extension.h
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize;

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text maxSize:(CGSize)maxSize attributes:(NSDictionary *)attributesDict;

@end
