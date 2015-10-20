//
//  HouseDetailView.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-16.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HouseDetailModel,HouseDetailView,HouseModel;

@protocol HouseDetailViewDelegate <NSObject>

//介绍图片被点击
- (void)detailView:(HouseDetailView *)detailView photoDidSelect:(UIImage *)image;


- (void)detailViewWithRoomId:(NSString *)roomId;

@end

@interface HouseDetailView : UIView

@property (nonatomic,weak)  id<HouseDetailViewDelegate>delegate;

+ (instancetype)viewWithdetailModel:(HouseDetailModel *)model;

-(void)addSubViewsWithDetailModel:(HouseDetailModel *)model;



@end
