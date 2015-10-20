//
//  CityMenu.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-16.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "CityMenu.h"

#import "CityModel.h"

@implementation CityMenu



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        [self addSubviews];
        
        [self getData];
        
        
    }
    return self;
}

- (void)getData{
    _cityArr = [NSMutableArray arrayWithCapacity:0];
    
    [HttpTool sendPostWithUrl:CITY_MENU_URL parameters:nil success:^(id data) {
        id backData = OneJsonParserWithData(data);
        for (NSDictionary *dict in backData[@"data"]) {
            CityModel *model = [CityModel objectWithKeyValues:dict];
            [_cityArr addObject:model];
        }
        [_menuTable reloadData];
    } fail:^(NSError *error) {
    }];
}


- (void)addSubviews
{
    _menuTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _menuTable.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _menuTable.delegate = self;
    _menuTable.dataSource = self;
    [self addSubview:_menuTable];
    
}

#pragma mark - UItableView 代理和数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cityArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityId"];
    }
    cell.textLabel.text = [_cityArr[indexPath.row] city_name];
    cell.layer . cornerRadius  =  3.0f ;
    cell.layer . masksToBounds  =  YES ;
    cell.layer.borderWidth = 0.6;
    //cell.hidden = NO;
    return cell;
}

#pragma mark - 设置cell半透明
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIColor *altCellColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    cell.textLabel.backgroundColor = altCellColor;
    cell.detailTextLabel.backgroundColor = altCellColor;
    
    if (0 == [[_cityArr[indexPath.row] opened] integerValue]) {
        cell.userInteractionEnabled = NO;
         cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
}

#pragma mark - 选择城市代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(didSelectedCity:)]) {
        [self.delegate didSelectedCity:_cityArr[indexPath.row]];
    }
}


#pragma mark - 显示城市列表
- (void)showCityMenu:(BOOL)isShow
{
    //一个单位的延迟时间
    double diff = 0.10;
    //获取可视cell数组
    //NSArray *_cells =_menuTable.visibleCells;
    //初始化动画效果
    CGAffineTransform transform;
    if (isShow == NO ){
        transform = CGAffineTransformMakeTranslation( - self.frame.size.width, 0);
        for (int i = 0; i < _cityArr.count; i ++) {
            UITableViewCell *cell = [_menuTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [UIView animateWithDuration:0.3 delay:diff * (i + 1) options:UIViewAnimationOptionCurveEaseIn animations:^{
                cell.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.origin = CGPointMake(- self.frame.size.width, 0);
        }];
    }
    else {
        transform = CGAffineTransformMakeTranslation(self.frame.size.width, 0);
        [UIView animateWithDuration:0.5 animations:^{
            self.origin = CGPointMake(0, 0);
        }];
        for (int i = 0; i < _cityArr.count; i ++) {
            UITableViewCell *cell = [_menuTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [UIView animateWithDuration:0.3 delay:diff * (i + 1) options:UIViewAnimationOptionCurveEaseIn animations:^{
                cell.transform = transform;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    cell.transform = CGAffineTransformIdentity;
                }];
            }];
            
        }
    }
}


@end
