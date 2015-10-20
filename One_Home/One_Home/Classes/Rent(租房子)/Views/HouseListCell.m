//
//  HouseListCell.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-12.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "HouseListCell.h"

#import "HouseModel.h"


@interface HouseListCell ()
{
    UIImageView         *_mainImageView;//主照片
    
    UIImageView         *_noHouseImageView;
    
    UIView              *_coverView;
    
    UILabel             *_houseInfo;//房屋性质
    
    UILabel             *_houseAddre;//房屋位置简介
    
    UILabel             *_priceLabel;//价格
    
    UIButton            *_payBtn;
    
    UIButton            *_hourseType;
    
}

@end

@implementation HouseListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView hasHouse:(BOOL)hasHouse
{
    static NSString *houseID = @"hourse";
    static NSString *noHouseID = @"nohourse";
    HouseListCell *cell;
    //[cell.contentView removeAllSubviews];
    if (hasHouse) {
        cell = [tableView dequeueReusableCellWithIdentifier:houseID];
        if (!cell) {
            cell = [[HouseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:houseID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubViewsAndHasHouse:YES];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:noHouseID];
        if (!cell) {
            cell = [[HouseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noHouseID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubViewsAndHasHouse:NO];
        }
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - 添加子控件视图
- (void)addSubViewsAndHasHouse:(BOOL)hasHouse{
    if (hasHouse) {
        // 1.房屋主图片
        _mainImageView = [ViewTool createImgViewWithFram:CGRectMake(0, 0, OneScreenW, (OneScreenH - 64 - 40 - 44 - 120) / 2) imgName:nil];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        _mainImageView.clipsToBounds  = YES;
        
        // 1.1主图上的覆盖view
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, _mainImageView.maxY - 30, OneScreenW, 30)];
        _coverView.userInteractionEnabled = YES;
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        // 1.2cover上的按钮
        CGFloat btnW = (OneScreenW - 2 ) / 3;
        
         _hourseType = [ViewTool createButtonWithFrame:CGRectMake(0 ,0,btnW, 30) title:nil backgroundImgName:nil selectedImgName:nil font:OneFontWithName(CommonFontName,15.0f) target:self action:@selector(btnClick:)];
        [_coverView addSubview:_hourseType];
        
        
        _payBtn = [ViewTool createButtonWithFrame:CGRectMake(btnW ,0,btnW, 30) title:@"nihao" backgroundImgName:nil selectedImgName:nil font:OneFontWithName(CommonFontName,15.0f) target:self action:@selector(btnClick:)];
        [_coverView addSubview:_payBtn];

        for (int i = 1 ; i < 3; i ++) {
            UIView *deliver = [ViewTool createDividerWithFrame:CGRectMake(i * btnW + (i - 1),2, 1, 26) withBgImage:nil andColor:[UIColor whiteColor]];
            [_coverView addSubview:deliver];
        }
        // 2.房屋信息
        _houseInfo = [ViewTool createLabelWithFrame:CGRectMake(10, _coverView.maxY + 2, OneScreenW, 30) text:@"[小区住宅] 次卧A - 20.0 m² - 南" font:OneFontWithName(CommonFontName, 15.0f)];
        // 3.房屋地址
        _houseAddre = [ViewTool createLabelWithFrame:CGRectMake(10, _houseInfo.maxY, OneScreenW, 30) text:@"浦东 - 张江 - 玉兰香苑 (一至四期)" font:OneFont(15.0f)];
        _houseAddre.textColor = [UIColor lightGrayColor];
        
        // 4.房屋价格
        _priceLabel = [ViewTool createLabelWithFrame:CGRectMake(OneScreenW - 100, _coverView.y - 50, 100, 30) text:@"1200 元/月" font:OneFont(15.0f)];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_mainImageView];
        [self.contentView addSubview:_coverView];
        [self.contentView addSubview:_houseInfo];
        [self.contentView addSubview:_houseAddre];
        [self.contentView addSubview:_priceLabel];
    }else{
        _noHouseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(OneScreenW / 2 - 75, (OneScreenH - 64 - 40 - 44) / 4 - 75, 150, 150)];
        _noHouseImageView.image = [UIImage imageNamed:@"bg_list_no_fangyuan"];
        _noHouseImageView.contentMode = UIViewContentModeScaleAspectFit;
        _noHouseImageView.clipsToBounds = YES;
        [self.contentView addSubview:_noHouseImageView];
    }
}

#pragma mark - 初始化模型
- (void)setModel:(HouseModel *)model
{
    _model = model;
    /**
     使用第三方库提供的方法获取gif格式的UIImage对象
     NSURL *url= [[NSBundle mainBundle]URLForResource:@"waiting.gif" withExtension:nil];
     [UIImage animatedImageWithAnimatedGIFURL:url]
     */
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.main_img_path] placeholderImage:OneImage(@"waiting_me")];
    
    //可以考虑使用字典，但是总感觉有些地方可能会有问题 NSArray *array =  [model arrayWithEnum];
    [_payBtn setTitle:PAY_TYPE[model.pay_method] forState:UIControlStateNormal];
    [_hourseType setTitle:ROOM_TYPE[model.room_type] forState:UIControlStateNormal];
    
    _priceLabel.text = [NSString stringWithFormat:@"%@元/月",model.room_money];
    
    _houseInfo.text = [NSString stringWithFormat:@"[%@] %@ - %.1f m² - %@",BUSINESS_TYPE[model.business_type],model.room_name,[model.room_area floatValue],DIRECTION_TYPE[model.room_direction]];
    
    _houseAddre.text = [NSString stringWithFormat:@"%@ - %@ - %@",model.region_name,model.scope_name,model.estate_name];
}

#pragma mark - cell高度
+ (CGFloat)cellHeight
{
    return (OneScreenH - 64 - 40 - 44) / 2;
}

- (void)btnClick:(UIButton *)btn{
    
    NSLog(@"%@",btn.titleLabel.text);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

@end
