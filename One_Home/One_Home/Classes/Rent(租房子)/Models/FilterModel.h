//
//  FilterModel.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-14.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong) NSArray *leftArray;

@property (nonatomic,strong) NSArray *rightArray;


@property (nonatomic,strong) NSArray *regionArr;
@property (nonatomic,strong) NSArray *scopeArr;
@property (nonatomic,strong) NSArray *regionAndIdArr;
@property (nonatomic,strong) NSArray *subScopeAndIdArr;

- (void)getData ;

@end
