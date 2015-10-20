//
//  FilterModel.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-14.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "FilterModel.h"

#import "RegionalModel.h"

@interface FilterModel ()


@end


@implementation FilterModel


- (instancetype)init{
    if (self = [super init]) {
        self.regionAndIdArr = [self getRegionAndIdByProperty:@[@"cname",@"mid"]];
        self.subScopeAndIdArr = [self getScopeAndIdArrByProperty:@[@"cname",@"mid"]];
    }
    return self;
}


-(NSArray *)regionArr{
    if (!_regionArr) {
        _regionArr = [self getRegion];
    }
    return _regionArr;
}


- (NSArray *)scopeArr
{
    if (!_scopeArr) {
        _scopeArr = [self getScopeArr];
    }
    return _scopeArr;
}


-(NSArray *)regionAndIdArr
{
    if (!_regionAndIdArr) {
        _regionAndIdArr = [self getRegionAndIdByProperty:@[@"cname",@"mid"]];
    }
    return _regionAndIdArr;
}

- (NSArray *)subScopeAndIdArr
{
    if (!_subScopeAndIdArr) {
        _subScopeAndIdArr = [self getScopeAndIdArrByProperty:@[@"cname",@"mid"]];
    }
    return _subScopeAndIdArr;
}

//测试数据
- (void)getData {
    [self setTitles];
    [self setLeftArray];
    [self setRightArray];
}

//每个下拉的标题
- (void) setTitles{
    _titleArray = @[@"区域", @"租金",@"面积"];
}

//左边列表可为空，则为单下拉菜单，可以根据需要传参
- (void)setLeftArray {
    NSMutableArray *One_leftArray = [NSMutableArray array];
    [One_leftArray insertObject:@"不限" atIndex:0];
    [One_leftArray addObjectsFromArray:self.regionArr];
    
    NSArray *Two_leftArray = [[NSArray alloc] init];
    NSArray *Three_leftArray = [[NSArray alloc] init];
    _leftArray = [[NSArray alloc] initWithObjects:One_leftArray, Two_leftArray,Three_leftArray, nil];
}


//右边列表不可为空
- (void)setRightArray {
    NSMutableArray *RS_rightArray = [NSMutableArray array];
    [RS_rightArray insertObject:@[@{@"cname":@"单击展示全部"}] atIndex:0];
    [RS_rightArray addObjectsFromArray:self.getScopeArr];
    
    
    NSArray *Money_rightArray = @[
                                  @[
                                      @{@"cname":@"不限"},
                                      @{@"cname":@"1500以下"},
                                      @{@"cname":@"1500 - 2500"},
                                      @{@"cname":@"2500以上"}
                                      ]
                                  ];
    NSArray *Area_rightArray = @[
                                 @[
                                     @{@"cname":@"不限"},
                                     @{@"cname":@"12以下"},
                                     @{@"cname":@"12 - 20"},
                                     @{@"cname":@"20以上"}
                                     ]
                                 ];
    
    _rightArray = [[NSArray alloc] initWithObjects:RS_rightArray, Money_rightArray,Area_rightArray, nil];
}




#pragma mark - 获取城市city
- (NSArray *)getRegion{
    return  [RegionalModel findByCriteria:[NSString stringWithFormat:@"where parent_id = %@",@"0"] WithProperty:@"cname"];
}
#pragma mark - 获取城市city和id
- (NSArray *)getRegionAndIdByProperty:(NSArray *)propertys{
    return [RegionalModel findDictByCriteria:[NSString stringWithFormat:@"where parent_id = %@",@"0"] WithProperty:propertys];
}

- (NSArray *)getScopeArr{
    //[array addObject:[NSNull null]];//不能使用NUNull  会崩溃
    //NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@[], nil];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in self.regionAndIdArr) {
        NSMutableArray *subScopeArr = [NSMutableArray arrayWithObjects:@{@"cname":@"不限"}, nil];
        [subScopeArr addObjectsFromArray:[RegionalModel findDictByCriteria:[NSString stringWithFormat:@"where parent_id = %@",dict[@"mid"]]WithProperty:@[@"cname"]]];
        [array addObject:subScopeArr];
    }
    return array;
}

- (NSArray *)getScopeAndIdArrByProperty:(NSArray *)propertys{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in self.regionAndIdArr) {
        NSArray * subScopeArr = [RegionalModel findDictByCriteria:[NSString stringWithFormat:@"where parent_id = %@",dict[@"mid"]] WithProperty:propertys];
        [array addObject:subScopeArr];
    }
    return array;
}






@end
