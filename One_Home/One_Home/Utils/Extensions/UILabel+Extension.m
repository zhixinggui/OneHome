//
//  UILabel+Extension.m
//
//  Created by hanxiaocu on 15-9-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/**
 *  判断UILabel所占尺寸的大小
 *
 *  @param text    文字内容
 *  @param font    字体
 *  @param maxSize 允许所占最大的尺寸
 *
 *  @return 文字占的尺寸
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text maxSize:(CGSize)maxSize attributes:(NSDictionary *)attributesDict
{
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributesDict context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}


@end
