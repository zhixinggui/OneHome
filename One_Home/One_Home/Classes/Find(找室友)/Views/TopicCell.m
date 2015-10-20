//
//  TopicCell.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "TopicCell.h"

#import "JoinHotModel.h"

@interface TopicCell ()
{
    UILabel         *_replay_cnt;
    
    UILabel         *_title;
    
    UILabel         *_circel_title;
    
    UIImageView     *_main_url;
    
    UIImageView     *_user_avatar;
}
@end

@implementation TopicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *myId = @"TopicCell";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:[TopicCell identifier]];
    if (!cell) {
        cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId];
        [cell addSubViews];
    }
    return cell;
}

- (void)addSubViews{
    _replay_cnt = [ViewTool createLabelWithFrame:CGRectMake(20, 55, 25, 20) text:@"47" font:OneFont(15.0f)];
    [_replay_cnt setTextColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:_replay_cnt];
    
    _title = [ViewTool createLabelWithFrame:CGRectMake(65, 10, 200, 30) text:@"徐家汇撒网中,这两天就住,急着呢" font:OneFont(14.0f)];
    [self.contentView addSubview:_title];
    
    
    _main_url = [[UIImageView alloc] initWithFrame:CGRectMake(OneScreenW - 80, 5, 55 , 55)];
    _main_url.clipsToBounds = YES;
    _main_url.layer.cornerRadius = 5.0f;
    [self.contentView addSubview:_main_url];
    
    _user_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(65, 50, 20, 20)];
    _user_avatar.layer.cornerRadius = 10.0f;
    _user_avatar.clipsToBounds = YES;
    [self.contentView addSubview:_user_avatar];
    
    _circel_title = [ViewTool createLabelWithFrame:CGRectMake(_user_avatar.maxX + 5, 50, 180, 20) text:@"徐家汇找室友" font:OneFont(13.0f)];
    _circel_title.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_circel_title];
    
}


- (void)setModel:(JoinHotModel *)model
{
    _model = model;
    _circel_title.text = model.circel_title;
    _title.text = model.title;
    [_main_url sd_setImageWithURL:[NSURL URLWithString:model.main_url]];
    
    [_user_avatar sd_setImageWithURL:[NSURL URLWithString:model.user_avatar]];
    
    _replay_cnt.text = model.replay_cnt;
}

+ (NSString *)identifier{
    return @"TopicCell";
}


+(CGFloat)cellHeight
{
    return 80.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //  [super setSelected:selected animated:animated];
}

@end
