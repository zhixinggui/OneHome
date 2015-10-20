//  HouseListViewController.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-9.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "BaseViewController.h"

#import "HouseSearchModel.h"
#import "DropdownMenu.h"

@interface HouseListViewController : BaseViewController

@property (copy,nonatomic) NSString *cityStr;

@property (nonatomic,strong) HouseSearchModel *searchModel;

@property (assign,nonatomic) BOOL hasHouse;

@property (nonatomic,strong) DropdownMenu *dropMenu;




@end
