//
//  UIImage+Extension.m
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


//ios5出来后就过期啦
+ (UIImage *)resizeImage:(UIImage *)image
{
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    return [image stretchableImageWithLeftCapWidth:w / 2 topCapHeight:h / 2];
}



//ios6之后推荐
+ (UIImage *)resizableImageWithName:(NSString *)imageName
{
    // 加载原有图片
    UIImage *norImage = [UIImage imageNamed:imageName];
    // 获取原有图片的宽高的一半（）
    CGFloat w = norImage.size.width * 0.5;
    CGFloat h = norImage.size.height * 0.5;
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    return newImage;
}


@end
