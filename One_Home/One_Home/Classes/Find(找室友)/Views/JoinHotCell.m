//
//  JoinHotCell.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "JoinHotCell.h"

#import "JoinHotModel.h"

@interface JoinHotCell ()
{
    UIImageView     *_main_url;
    UILabel         *_address;
    UILabel         *_title;
    UILabel         *_memberNum;
    UIButton        *_join_no;
    
    BOOL            _isJoin;
}

@end

@implementation JoinHotCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *myId = @"JoinHotCell";
    
    JoinHotCell *cell = [tableView dequeueReusableCellWithIdentifier:myId];
    if (!cell) {
        cell = [[JoinHotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId];
        [cell addsubViews];
    }
    return cell;
}

//-(void)layoutSubviews

#pragma mark - 添加子视图
- (void)addsubViews{
    
    _main_url = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 65, 65)];
    _main_url.layer.cornerRadius = 5.0f;
    _main_url.clipsToBounds = YES;
    
    _title = [ViewTool createLabelWithFrame:CGRectMake(_main_url.maxX + 10, 10, OneScreenW - 200, 20) text:@"徐汇找室友" font:OneFontWithName(BoldFont, 15.0f)];
    //[_title sizeToFit];
    //_title.lineBreakMode = NSLineBreakByWordWrapping;
   //_title.numberOfLines = 1;
    _title.clipsToBounds = YES;
    
    _address = [ViewTool createLabelWithFrame:CGRectMake(_main_url.maxX + 10, _title.maxY + 5, OneScreenW - 80 - 100, 15) text:@"上海|徐汇|不限" font:OneFont(13.0f)];
    
    _memberNum = [ViewTool createLabelWithFrame:CGRectMake(_main_url.maxX + 10, _address.maxY, 150, 15) text:@"成员:429" font:OneFont(13.0f)];
    
    _join_no = [ViewTool createButtonWithFrame:CGRectMake(OneScreenW - 100 , 30, 80, 30) title:@"+加入" backgroundImgName:nil selectedImgName:nil font:OneFont(14.0f) target:self action:@selector(joinOrNo:)];
    _join_no.layer.cornerRadius = 15.0f;
    
    UIView *deliver = [ViewTool createDividerWithFrame:CGRectMake(0, 79, OneScreenW, 1) withBgImage:nil andColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:deliver];
    
    
    [self.contentView addSubview:_main_url];
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_address];
    [self.contentView addSubview:_memberNum];
    [self.contentView addSubview:_join_no];
}


- (void)layoutSubviews
{
    if ([_model.in_state isEqualToString:@"0"]) {//  0未加入，显示加入
        _isJoin = NO;
        [_join_no setTitle:@"+加入" forState:UIControlStateNormal];
    }else{//1 已经加入显示取消
        _isJoin = YES;
        [_join_no setTitle:@"-退出" forState:UIControlStateNormal];
    }
    
    if (_isJoin) {
        [_join_no setTitleColor:ONERGB(240, 201, 207) forState:UIControlStateNormal];
        _join_no.layer.borderColor = ONERGB(240, 201, 207).CGColor;
         [_join_no setBackgroundColor: [UIColor whiteColor] ];
        _join_no.layer.borderWidth = 1.0;
    }else{
        [_join_no setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_join_no setBackgroundColor: ONERGB(240, 201, 207) ];
    }
    [_join_no setSelected:NO];
}

#pragma mark - 重写setter方法给子视图填充数据
- (void)setModel:(JoinHotModel *)model
{
    
    _model = model;
    _title.text = model.title;
    [_main_url sd_setImageWithURL:[NSURL URLWithString:model.main_url]];
    _address.text = [NSString stringWithFormat:@"%@ |%@ |%@",model.city_name,model.region_name,model.scope_name];
    _memberNum.text = [NSString stringWithFormat:@"成员:%@",model.member_cnt];
 
}


- (void)joinOrNo:(UIButton *)btn{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_model.circle_id forKey:@"circle_id"];
    
    [ViewTool showHUDWithText:@"正在申请中..." toView:self.contentView];
    [dict setValue:[NSNumber numberWithInteger:_isJoin ? 0 : 1] forKey:@"operate"];
    [HttpTool sendPostWithUrl:JOIN_OR_QUIT_URL parameters:dict success:^(id data) {
        [ViewTool hideHUDFromView:self.contentView];
        id backData = OneJsonParserWithData(data);
        if ([backData[@"status"] isEqualToString:@"200"]) {
            _model.in_state = _isJoin ? @"0" : @"1";
            if ([self.delegate respondsToSelector:@selector(didSelectJoinOrQuit:withIndex:)]) {
                [self.delegate didSelectJoinOrQuit:_model withIndex:_index];
            }
            
        }
        //_isJoin 已经被刷新 状态改变啦，YES -- no  NO -- yes
        [MBProgressHUD showSuccess:!_isJoin ? @"你已经是它的成员咯" : @"退出成功哈"];
    } fail:^(NSError *error) {
        [ViewTool hideHUDFromView:self.contentView];
        [MBProgressHUD showError:@"操作失败"];
    }];
    
}




+ (NSString *)identifier
{
    return @"JoinHotCell";
}


+ (CGFloat)cellHeight
{
    return 80;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:NO];
    
    
}

@end
