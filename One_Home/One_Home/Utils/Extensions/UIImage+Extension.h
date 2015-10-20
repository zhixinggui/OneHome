//
//  UIImage+Extension.h
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)



//设置图片拉伸
+ (UIImage *)resizeImage:(UIImage *)image;

+ (UIImage *)resizableImageWithName:(NSString *)imageName;

@end
