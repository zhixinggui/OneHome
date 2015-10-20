//
//  BaseCell.m
//  One_Home
//
//  Created by hanxiaocu on 15-9-21.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "BaseCell.h"
#import "BaseModel.h"

@interface BaseCell ()
{
    UIImageView     *_iconIV;
    UILabel         *_nameLabel;
    UILabel         *_starLabel;
    UILabel         *_cateLabel;
    UILabel         *_sizeLabel;
    UILabel         *_descLabel;
    UIButton        *_limited;
    
}
@end

@implementation BaseCell

#pragma mark - 添加子视图
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
    
}

+ (BaseCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"base";
    
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


#pragma mark - 填充数据
- (void)setModel:(BaseModel *)model
{
    _model = model;
    [_iconIV sd_setImageWithURL:[NSURL URLWithString:model.app_icon]];
    _nameLabel.text = model.post_title;
    //星级
    NSMutableAttributedString *AttributedStr;
    //对于为评级的应用要判断一下 NSLog(@"%@",[model.app_apple_rated class]);
    if ([model.app_apple_rated isEqual:[NSNull null]] || model.app_apple_rated == nil ) {
        AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"评级:暂无"];
    }else{
    AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"评级:%@星",model.app_apple_rated]];
    }
    
    NSRange range = NSMakeRange(3, AttributedStr.length - 3);
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:16.0]
     
                          range:range];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor orangeColor]
     
                          range:range];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont boldSystemFontOfSize:16.0f]
                          range:range];
 
    _starLabel.attributedText = AttributedStr;
    


    
    //大小
    _sizeLabel.text = model.app_size;
    
    _descLabel.text = model.app_desc;
    
    
    if (model.category == 2) {
        _limited.titleLabel.text = @"";
        _limited = [[UIButton alloc]initWithFrame:CGRectMake(_sizeLabel.maxX - 8, 40, 75, 80)];
        [_limited setBackgroundImage:[UIImage imageNamed:@"pricedrop-free"] forState:UIControlStateNormal];
    }
    
}


+ (CGFloat)cellHeight
{
    return 130.0f;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}
@end
