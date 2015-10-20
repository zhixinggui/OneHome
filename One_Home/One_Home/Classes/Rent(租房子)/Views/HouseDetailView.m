//
//  HouseDetailView.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-16.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "HouseDetailView.h"

#import "HouseDetailModel.h"



#import "FacilityModel.h"

@interface HouseDetailView () <UIScrollViewDelegate>
{
    
    HouseDetailModel    *_detailModel;
    
    UIScrollView        *_imgScrollView;
    
    NSInteger           _imgNum;
    
    UIPageControl       *_pageControl;
    
    NSTimer             *_timer;
    
    
    UIView              *_coverView;
    
    UILabel             *_priceLabel;
    
    UILabel             *_houseInfo;//房屋性质
    
    UILabel             *_houseAddre;//房屋位置简介
    
    
    UIButton            *_payBtn;
    
    UIButton            *_hourseType;
    
    UIView              *_coverBgView;
    
    NSString            *_roomId;
    
    
    UIView              *_roomBigPhoto;
    
    
}
@end

@implementation HouseDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


+ (instancetype)viewWithdetailModel:(HouseDetailModel *)model
{
    HouseDetailView *detailView = [[HouseDetailView alloc] initWithFrame:CGRectMake(0, 0, OneScreenW, OneScreenH)];
    [detailView addSubViewsWithDetailModel:model];
    return detailView;
}


- (void)addSubViewsWithDetailModel:(HouseDetailModel *)model
{
    _detailModel = model;
    
    //1.图片轮播
    _imgNum = model.image_urls.count + 2;
    
    CGFloat scrollH = (OneScreenH - 64 - 40 - 44 - 120) / 2;
    _imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, OneScreenW, scrollH)];
    _imgScrollView.contentSize = CGSizeMake(_imgNum * OneScreenW, scrollH);
    _imgScrollView.showsHorizontalScrollIndicator = NO;
    _imgScrollView.pagingEnabled = YES;
    _imgScrollView.bounces=NO;
    _imgScrollView.delegate = self;
    [self addSubview:_imgScrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollH - 60, OneScreenW, 30)];
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=model.image_urls.count;
    //设置页码指示器的颜色
    // _pageControl.pageIndicatorTintColor=[UIColor clearColor];
    //设置当前页码的颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    //不允许响应页码器的点击。
    _pageControl.enabled = NO;
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    [self addTimer];
    
    
    //4 1 2 3 4 1
    //多添加最后一张图片到最前面位置
    [self addImageView:[model.image_urls lastObject] withFrame:_imgScrollView.bounds toScrollView:_imgScrollView atIndex:0];
    //多添加第一张图片到最后面位置
    [self addImageView:[model.image_urls firstObject] withFrame:CGRectMake(self.width * (_imgNum - 1), 0, OneScreenW, scrollH) toScrollView:_imgScrollView atIndex:(int)_imgNum - 1];
    
    CGRect ivFrame = _imgScrollView.bounds;
    for (int i = 0 ; i < model.image_urls.count; i ++) {
        ivFrame.origin.x = (i + 1)* (OneScreenW);
        [self addImageView:model.image_urls[i] withFrame:ivFrame toScrollView:_imgScrollView atIndex:(i + 1)];
    }
    //先移动到第二张，也就是1
    _imgScrollView.contentOffset = CGPointMake(self.width, 0);
    
    
    
    
    // 1.1主图上的覆盖view
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, _imgScrollView.maxY - 30, OneScreenW, 30)];
    _coverView.userInteractionEnabled = YES;
    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    CGFloat btnW = OneScreenW / 3;
    
    _hourseType = [ViewTool createButtonWithFrame:CGRectMake(0 , 0,btnW, 30) title:ROOM_TYPE[model.room_type] backgroundImgName:nil selectedImgName:nil font:OneFontWithName(CommonFontName,15.0f) target:self action:@selector(btnClick:)];
    [_coverView addSubview:_hourseType];
    
    _payBtn = [ViewTool createButtonWithFrame:CGRectMake(btnW ,0,btnW, 30) title:PAY_TYPE[model.pay_method]backgroundImgName:nil selectedImgName:nil font:OneFontWithName(CommonFontName,15.0f) target:self action:@selector(btnClick:)];
    [_coverView addSubview:_payBtn];
    
    for (int i = 0 ; i < 2; i ++) {
        UIView *deliver = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * btnW,2, 1, 26)];
        deliver.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        [_coverView addSubview:deliver];
    }
    
    // 2.房屋价格
    _priceLabel = [ViewTool createLabelWithFrame:CGRectMake(OneScreenW - 100, _coverView.y - 50, 100, 30) text:[NSString stringWithFormat:@"%@元/月",model.room_money] font:OneFont(15.0f)];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_coverView];
    [self addSubview:_priceLabel];
    
    CGFloat couponH = _imgScrollView.maxY;
    // 3 .领取500元
    if ([model.business_coupon isEqualToString:@"500"]) {
        UIButton *couponBtn = [ViewTool createCustomButtonWithFrame:CGRectMake(0, _imgScrollView.maxY, OneScreenW, 40) withCustomRect:CGRectMake(OneScreenW - 15, 15, 5, 0) title:@"可使用500元优惠劵,如何领取" imgName:@"icon_go" selectedImgName:nil bgImageName:nil font:OneFont(14.0f) target:self action:@selector(btnClick:)];
        [couponBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        couponBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:couponBtn];
        couponH = couponBtn.maxY;
    }
    
    
    
    // 4.房屋地址
    UIButton *houseAddress = [ViewTool createCustomButtonWithFrame:CGRectMake(0, couponH, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"房屋地址" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
    houseAddress.titleLabel.textAlignment = NSTextAlignmentLeft;
    [houseAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UILabel *address = [ViewTool createLabelWithFrame:CGRectMake(15, houseAddress.maxY + 10, OneScreenW - 15, 20) text:[NSString stringWithFormat:@"%@-%@",model.region_name,model.address] font:OneFont(13.0f)];
    UILabel *estateName = [ViewTool createLabelWithFrame:CGRectMake( 15,address.maxY  ,OneScreenW - 15, 20) text:model.estate_name font:OneFont(13.0f)];
    
    UILabel *roomNo = [ViewTool createLabelWithFrame:CGRectMake(15, estateName.maxY , OneScreenW - 15, 20) text:[NSString stringWithFormat:@"[No.%@]",model.room_no] font:OneFont(13.0f)];
    roomNo.textColor = [UIColor lightGrayColor];
    
    [self addSubview:houseAddress];
    [self addSubview:address];
    [self addSubview:estateName];
    [self addSubview:roomNo];
    CGFloat thiHouseY = roomNo.maxY + 10;
    
    // 5.1房屋介绍
    if ([model.room_type isEqualToString:@"0201"]|| [model.room_type isEqualToString:@"0202"]||[model.room_type isEqualToString:@"0203"]  ) {
        UIButton *houseInfo = [ViewTool createCustomButtonWithFrame:CGRectMake(0,roomNo.maxY + 10 , OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"房屋介绍" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
        houseInfo.titleLabel.textAlignment = NSTextAlignmentLeft;
        [houseInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:houseInfo];
        
        UIView   *hdeliver = [ViewTool createDividerWithFrame:CGRectMake(20,houseInfo.maxY + 85, OneScreenW - 40, 1) withBgImage:nil andColor:[UIColor grayColor]];
        [self addSubview:hdeliver];
        
        UIView *vdeliver = [ViewTool createDividerWithFrame:CGRectMake((OneScreenW - 1)/2, houseInfo.maxY + 20, 1, 130) withBgImage:nil andColor:[UIColor grayColor]];
        [self addSubview:vdeliver];
        
        //合租住房描述detail_house_fitment   detail_house_floor  detail_house_square  detail_house_type
        CGFloat ivWH = 35;
        CGFloat labW = (OneScreenW - 1) / 2;
        NSArray *ivArr = @[@"detail_house_square",@"detail_house_type",@"detail_house_floor",@"detail_house_fitment"];
        NSString *area = [NSString stringWithFormat:@"%.1fm²",[model.area floatValue]];
        NSString *type = [NSString stringWithFormat:@"%@室%@厅%@卫",model.room_num,model.hall_num,model.hall_num];
        NSString *floor = [NSString stringWithFormat:@"%@/%@层",model.floor,model.floor_total];
        NSString *fitment = DECORATION_TYPE[model.decoration];
        NSArray *infoLab = @[area,type,floor,fitment];
        
        for (int i = 0; i < 4 ; i ++) {
            UIImageView *iv = [ViewTool createImgViewWithFram:CGRectMake(75 + (i % 2) * (150 + ivWH),houseInfo.maxY +  15 + i / 2 * (ivWH + 50), ivWH, ivWH) imgName:ivArr[i]];
            [self addSubview:iv];
            
            UILabel *info = [ViewTool createLabelWithFrame:CGRectMake((i % 2) * (labW + 1), iv.maxY ,labW , 35) text:infoLab[i] font:OneFont(13.0f)];
            info.textAlignment = NSTextAlignmentCenter;
            [self addSubview:info];
        }
        
        
        thiHouseY = roomNo.maxY + 210;
    }
    
    
    // 5.2本房间介绍
    UIButton *thisHouseInfo = [ViewTool createCustomButtonWithFrame:CGRectMake(0,thiHouseY, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"本房间介绍" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
    thisHouseInfo.titleLabel.textAlignment = NSTextAlignmentLeft;
    [thisHouseInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:thisHouseInfo];
    
    
    //Noteworthy-Bold
    UILabel *roomName = [ViewTool createLabelWithFrame:CGRectMake(30, thisHouseInfo.maxY + 30 , 50, 30) text:model.room_name font:OneFontWithName(CommonFontName, 14.0f)];
    [self addSubview:roomName];
    
    UIView  *deliverRoom = [ViewTool createDividerWithFrame:CGRectMake(roomName.maxX + 30, thisHouseInfo.maxY, 1, 90) withBgImage:nil andColor:[UIColor lightGrayColor]];
    [self addSubview:deliverRoom];
    
    UILabel *roomInfo = [ViewTool createLabelWithFrame:CGRectMake(deliverRoom.maxX + 20, thisHouseInfo.maxY + 20, OneScreenW - deliverRoom.maxX - 20, 30) text:[NSString stringWithFormat:@"%.1fm² - %@",[model.room_area floatValue],DIRECTION_TYPE[model.room_direction]] font:OneFont(13.0f)];
    [self addSubview:roomInfo];
    BOOL is_auth = [model.check_in_state isEqualToString:@"2"];
    UIButton *roomStatus = [ViewTool createButtonWithFrame:CGRectMake(deliverRoom.maxX + 20, roomInfo.maxY, 100, 20) title:is_auth ? @"未入住" : @"已出租" backgroundImgName:is_auth ? @"icon_tag_green" :@"icon_tag_red" selectedImgName:nil font:OneFont(12.0f) target:nil action:nil];
    [self addSubview:roomStatus];
    
    
    
    // 6.房间设施
    UIButton *roomFacility = [ViewTool createCustomButtonWithFrame:CGRectMake(0,thisHouseInfo.maxY + 90, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"房间设施" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
    roomFacility.titleLabel.textAlignment = NSTextAlignmentLeft;
    [roomFacility setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:roomFacility];
    CGFloat imW =35;
    if (model.room_facility) {
        int n = (int)model.room_facility.count > 5 ? 5 : (int)model.room_facility.count;
        for (int i = 0;  i < n ; i ++) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i * (imW +30), roomFacility.maxY + 10, imW, 40)];
            [iv sd_setImageWithURL:[NSURL URLWithString:model.room_facility[i][@"img_url_gray"]] placeholderImage:nil];
            iv.userInteractionEnabled = YES;
            
            //添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFacility:)];
            [iv addGestureRecognizer:tap];
            iv.tag = 1000 - i - 1;
            [self addSubview:iv];
        }
        CGFloat roomBtnW = OneScreenW - n * (imW + 30) - 20  + 30 - 10;
        UIButton *roomBtn = [ViewTool createCustomButtonWithFrame:CGRectMake(20 + n * (imW + 30) - 30 + 10,roomFacility.maxY + 10, roomBtnW , 40) withCustomRect:CGRectMake(roomBtnW - 15, 15, 8, 0) title:nil imgName:@"icon_go" selectedImgName:nil bgImageName:nil font:OneFont(14.0f) target:self action:@selector(showFacility:)];
        roomBtn.tag = 99;
        [self addSubview:roomBtn];
        if ((int)model.room_facility.count > 5) {
            n = (int)model.room_facility.count;
            [roomBtn setTitle:[NSString stringWithFormat:@"+%d",n - 5] forState:UIControlStateNormal];
            [roomBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    
    
    // 7.公共设施
    UIButton *publicFacility = [ViewTool createCustomButtonWithFrame:CGRectMake(0,roomFacility.maxY + 60, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"公共设施" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
    publicFacility.titleLabel.textAlignment = NSTextAlignmentLeft;
    [publicFacility setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:publicFacility];
    if (![model.public_facility[0][@"type_no"] isEqualToString:@"0312"]){
        int n = (int)model.public_facility.count  > 5 ? 5 : (int)model.public_facility.count;
        for (int i = 0;  i < (n > 5 ? 5 : n) ; i ++) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i * (imW + 30), publicFacility.maxY + 10, imW, 40)];
            [iv sd_setImageWithURL:[NSURL URLWithString:model.public_facility[i][@"img_url_gray"]] placeholderImage:nil];
            iv.userInteractionEnabled = YES;
            
            //添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFacility:)];
            [iv addGestureRecognizer:tap];
            iv.tag = 1000 + i + 1;
            [self addSubview:iv];
        }
        CGFloat publicBtnW = OneScreenW - n * (imW + 30) - 20 + 30 - 10;
        UIButton *publicBtn = [ViewTool createCustomButtonWithFrame:CGRectMake(n * (imW + 30) + 20 - 30 + 10, publicFacility.maxY + 10, publicBtnW, 40) withCustomRect:CGRectMake(publicBtnW - 15,15, 8, 0) title:nil imgName:@"icon_go" selectedImgName:nil bgImageName:nil font:OneFont(14.0f) target:self action:@selector(showFacility:)];
        [self addSubview:publicBtn];
        publicBtn.tag = 100;
        if ((int)model.public_facility.count  > 5) {
            n = (int)model.public_facility.count;
            [publicBtn setTitle:[NSString stringWithFormat:@"+%d",n - 5] forState:UIControlStateNormal];
            [publicBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }else{
        //没有设备
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(30, publicFacility.maxY + 20, 50, 20)];
        [iv sd_setImageWithURL:[NSURL URLWithString:model.public_facility[0][@"img_url_gray"]]];
        [self addSubview:iv];
    }
    
    
    // 8.隔壁房间及室友
    UIButton *roomies = [ViewTool createCustomButtonWithFrame:CGRectMake(0,publicFacility.maxY + 60, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"隔壁房间及室友" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
    roomies.titleLabel.textAlignment = NSTextAlignmentLeft;
    [roomies setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:roomies];
    CGFloat firstY = roomies.maxY + 90;
    if (model.roomies.count == 0) {
        UILabel *roomiesInfo = [ViewTool createLabelWithFrame:CGRectMake(0, roomies.maxY + 30, OneScreenW, 25) text:@"暂无信息" font:OneFontWithName(CommonFontName, 13.0f)];
        roomiesInfo.textColor = [UIColor lightGrayColor];
        roomiesInfo.textAlignment = NSTextAlignmentCenter;
        [self addSubview:roomiesInfo];
    }else{
        firstY = roomies.maxY;
        for ( int i = 0;  i < model.roomies.count; i ++) {
            
            UIButton *bgBtn = [ViewTool createCustomButtonWithFrame:CGRectMake(0, firstY, OneScreenW, 90) withCustomRect:CGRectMake(OneScreenW - 15, 40, 8, 0) title:nil imgName:@"icon_go" selectedImgName:nil bgImageName:@"switch_cover" font:nil target:self action:@selector(seeDetail:)];
            _roomId = model.roomies[i][@"room_id"];
            [self addSubview:bgBtn];
            
            UILabel *roomisName = [ViewTool createLabelWithFrame:CGRectMake(30, firstY + 30 , 50, 30) text:model.roomies[i][@"room_name"] font:OneFontWithName(CommonFontName, 14.0f)];
            [self addSubview:roomisName];
            
            UIView  *deliverV = [ViewTool createDividerWithFrame:CGRectMake(roomisName.maxX + 30, firstY, 1, 90) withBgImage:nil andColor:[UIColor lightGrayColor]];
            [self addSubview:deliverV];
            
            UILabel *roomisInfo = [ViewTool createLabelWithFrame:CGRectMake(deliverV.maxX + 20, firstY + 20, OneScreenW - deliverV.maxX - 20, 30) text:[NSString stringWithFormat:@"%.1fm² - %@",[model.roomies[i][@"room_area"] floatValue],DIRECTION_TYPE[model.roomies[i][@"room_direction"]] ]font:OneFont(13.0f)];
            [self addSubview:roomisInfo];
            
            BOOL status = [model.roomies[i][@"status"] isEqualToString:@"2"];
            UIButton *roomStatus = [ViewTool createButtonWithFrame:CGRectMake(deliverV.maxX + 20, roomisInfo.maxY, 100, 20) title:status ? @"未入住" : @"已出租" backgroundImgName:status ? @"icon_tag_green" :@"icon_tag_red" selectedImgName:nil font:OneFont(12.0f) target:nil action:nil];
            [self addSubview:roomStatus];
            
            UIView  *deliverH = [ViewTool createDividerWithFrame:CGRectMake(0, deliverV.maxY, OneScreenW, 1) withBgImage:nil andColor:[UIColor lightGrayColor]];
            [self addSubview:deliverH];
            
            firstY = deliverH.maxY;
        }
        
        
    }
    
    // 9.房东介绍
    UIButton *owner = [ViewTool createCustomButtonWithFrame:CGRectMake(0,firstY, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"房东介绍" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
    owner.titleLabel.textAlignment = NSTextAlignmentLeft;
    [owner setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:owner];
    
    
    //Noteworthy-Bold
    UILabel *ownerName = [ViewTool createLabelWithFrame:CGRectMake(30, owner.maxY + 30 , 80, 30) text:model.owner_name font:OneFontWithName(CommonFontName, 14.0f)];
    [self addSubview:ownerName];
    
    UIView  *deliverOwner = [ViewTool createDividerWithFrame:CGRectMake(ownerName.maxX , owner.maxY, 1, 80) withBgImage:nil andColor:[UIColor lightGrayColor]];
    [self addSubview:deliverOwner];
    
    
    UIButton *ownerInfo = [ViewTool createButtonWithFrame:CGRectMake(deliverOwner.maxX , owner.maxY, OneScreenW - deliverOwner.maxX, 80) title:[NSString stringWithFormat:@"已经有%@人评价他啦",model.owner_evaluate_cnt] backgroundImgName:nil selectedImgName:nil font:OneFont(13.0f) target:self action:@selector(btnClick:)];
    [ownerInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:ownerInfo];
    
    
    // 10.房东稀罕这样的租客
    UIButton *ownerLike = [ViewTool createCustomButtonWithFrame:CGRectMake(0,owner.maxY + 80, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"房东稀罕这样的租客" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
    ownerLike.titleLabel.textAlignment = NSTextAlignmentLeft;
    [ownerLike setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:ownerLike];
    
    if (model.owner_like.count == 0) {
        UILabel *likeInfo = [ViewTool createLabelWithFrame:CGRectMake(0, ownerLike.maxY + 30, OneScreenW, 25) text:@"房东没有要求哟" font:OneFontWithName(CommonFontName, 13.0f)];
        likeInfo.textColor = [UIColor lightGrayColor];
        likeInfo.textAlignment = NSTextAlignmentCenter;
        [self addSubview:likeInfo];
        self.height = likeInfo.maxY + 30;
    }else{
        CGFloat likeW = 60;
        int n = (OneScreenW - 20 * 2 + 30) / (likeW + 30) ;
        n = n > (int) model.owner_like.count  ? (int) model.owner_like.count : n;
        for ( int i = 0;  i < model.owner_like.count;  i ++) {
            UIButton *ownerlikeInfo = [ViewTool createButtonWithFrame:CGRectMake(10 + (i % n) * (likeW + 30), 15 +ownerLike.maxY + i / n * 45, likeW, 30) title:OWNER_LIKE_TYPE[model.owner_like[i]] backgroundImgName:@"likebg" selectedImgName:nil font:OneFont(12.0f) target:nil action:nil];
            [self addSubview:ownerlikeInfo];
            self.height = ownerlikeInfo.maxY + 30;
        }
        
    }
    
    // 11.其他介绍
    if (![model.room_description isEqualToString:@""]) {
        UIButton *roomDescription = [ViewTool createCustomButtonWithFrame:CGRectMake(0,ownerLike.maxY + 85, OneScreenW, 30) withCustomRect:CGRectMake(OneScreenW - 25, 15, 5, 0) title:@"其他介绍" imgName:nil  selectedImgName:nil bgImageName:@"filter_bg_sel" font:OneFontWithName(@"Thonburi-Bold",14.0f) target:nil action:nil];
        roomDescription.titleLabel.textAlignment = NSTextAlignmentLeft;
        [roomDescription setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:roomDescription];
        
        
        CGSize size = [UILabel labelAutoCalculateRectWith:model.room_description font:OneFont(13.0f) maxSize:CGSizeMake(OneScreenW - 30, CGFLOAT_MAX)];
        UILabel  *description = [ViewTool createLabelWithFrame:CGRectMake(15, roomDescription.maxY + 5, OneScreenW - 30, size.height) text:model.room_description font:OneFont(13.0f)];
        description.numberOfLines = 0;
        [self addSubview:description];
        self.height = description.maxY + 5;
    }
}

#pragma mark - 给滚动视图添加图片
/**
 *  添加视图到滚动视图
 *
 *  @param imageUrlString   图片请求路径
 *  @param frame            视图尺寸
 *  @param scrollView       目标滚动视图
 */
-(void)addImageView:(NSString *)imageUrlString withFrame:(CGRect)frame toScrollView:(UIScrollView *)scrollView atIndex:(int)index
{
    UIImageView *iv = [[UIImageView alloc]initWithFrame:frame];
    [iv sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:OneImage(@"waiting_me")];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds  = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoSelect:)];
    iv.userInteractionEnabled = YES;
    [iv addGestureRecognizer:tap];
    [scrollView insertSubview:iv atIndex:index];
    //图片不失真
}


#pragma mark - pageController
-(void)changePage:(UIPageControl *)pageControl{
    
}

- (void)nextImage{
    int currentPage = (int)_pageControl.currentPage;
    // 页面  4 1 2 3 4 1
    // 页码    0 1 2 3      currentPage
    //offset 0 1 2 3 4 5
    
    //自定义动画节奏慢一点
//    if (currentPage == _imgNum - 3) {  //图中的页码3,然后继续走到1
//        currentPage ++;                // 起点就是在第一个位移,所以相对4页面来看
//        [UIView animateWithDuration:0.9 animations:^{
//              [_imgScrollView setContentOffset:CGPointMake((currentPage + 1)* self.width, 0)] ;
//        } completion:^(BOOL finished) {
//            [_imgScrollView setContentOffset:CGPointMake(self.width, 0)];
//        }];
//    }else{
//        currentPage ++;
//        [UIView animateWithDuration:1.0 animations:^{
//            [_imgScrollView setContentOffset:CGPointMake((currentPage + 1)* self.width, 0)] ;
//        }];
//    }
    
    if (currentPage == _imgNum - 3) {
        currentPage = 0;
        [_imgScrollView setContentOffset:CGPointMake(0, 0)];
    }else{
        currentPage ++;
    }
    [_imgScrollView setContentOffset:CGPointMake((currentPage + 1)* self.width, 0) animated:YES];
}


#pragma mark - UIScrollViewDelegate
// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    [self removeTimer];
}

//在减速时执行，使pagingEnabled一定会调用此方法。
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //移动到最右边的图片时，立即切换到第二张位置。
    if ((_imgNum - 1) * self.width == scrollView.contentOffset.x) {
        [scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    }
    
    //移动到最左边的图片时，立即切换到倒数第二张位置。
    if (0 == scrollView.contentOffset.x) {
        [scrollView setContentOffset:CGPointMake((_detailModel.image_urls.count) * self.width, 0) animated:NO];
    }
    [self addTimer];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //更新页码指示器
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    NSUInteger page = (_imgScrollView.contentOffset.x + self.width * 0.5) / self.width;
    if (0 == page) {
        page = _imgNum - 2;
    }
    else if (_imgNum - 1 == page) {
        page = 0;
    }
    else {
        page -= 1;
    }
    _pageControl.currentPage = page;
}


#pragma mark - 定时器
/**
 *  开启定时器
 */
- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
/**
 *  关闭定时器
 */
- (void)removeTimer
{
    [_timer invalidate];
}




#pragma mark - 显示room设备  public设备蒙版
- (void)showFacility:(id)sender{
    NSString *title = [NSString string];
    UIImageView *ivTag;
    UIButton *btn;
    int count ;
    if ([sender isKindOfClass:[UIButton class]]) {
        btn = (UIButton *)sender;
    }else if([sender isKindOfClass:[UIGestureRecognizer class]]){
        UITapGestureRecognizer *tpa = sender;
        ivTag = (UIImageView *)tpa.view;
    }
    
    if (btn.tag == 99 ||  (ivTag.tag < 1000 && ivTag.tag > 0)) {
        title = @"房屋设备";
        count = (int)_detailModel.room_facility.count;
    }else if((btn.tag == 100 || ivTag.tag > 1000))
    {
        title = @"公共设备";
        count = (int)_detailModel.public_facility.count;
    }
    
    _coverBgView = [[UIView alloc] initWithFrame:self.window.frame];
    _coverBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.window addSubview:_coverBgView];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, OneScreenW, OneScreenH - 64)];
    scrollView.contentSize = CGSizeMake(OneScreenW, count * (50 + 30) + 64 + 50 + 10 + 32 - 30);
    [_coverBgView addSubview:scrollView];
    
    UILabel *roomLabel = [ViewTool createLabelWithFrame:CGRectMake(0, 64, OneScreenW, 50) text:title font:OneFontWithName(@"Noteworthy-Bold", 15.0f)];
    roomLabel.textAlignment = NSTextAlignmentCenter;
    roomLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:roomLabel];
    
    UIView *deliver = [ViewTool createDividerWithFrame:CGRectMake(15, roomLabel.maxY + 10, OneScreenW - 30, 2) withBgImage:nil andColor:[UIColor whiteColor]];
    [scrollView addSubview:deliver];
    
    for (int i  = 0 ; i < count; i ++) {
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, deliver.maxY + 20 + i * (50 + 30), 50, 50)];
        iv.centerX = OneScreenW / 4;
        [iv sd_setImageWithURL:[NSURL URLWithString:(ivTag.tag > 1000 || btn.tag == 100 ) ? _detailModel.public_facility[i][@"img_url_bright"] : _detailModel.room_facility[i][@"img_url_bright"]]];
        [scrollView addSubview:iv];
        
        UILabel *label = [ViewTool createLabelWithFrame:CGRectMake(iv.maxX + 30, deliver.maxY + 20 + i * (50 + 30),  OneScreenW / 2, 50) text:(ivTag.tag > 1000 || btn.tag == 100 )? _detailModel.public_facility[i][@"name"] :_detailModel.room_facility[i][@"name"] font:OneFont(14.0f)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:label];
    }
    
    UIButton *closeBtn = [ViewTool createCustomButtonWithFrame:CGRectMake(0, OneScreenH - 64, OneScreenW, 64) withCustomRect:CGRectMake(OneScreenW / 2 - 11 , 21, 22, 0) title:nil imgName:@"joint_icon_del" selectedImgName:nil bgImageName:nil font:nil target:self action:@selector(hideFacility)];
    [_coverBgView addSubview:closeBtn];
    
}


#pragma mark - 隐藏蒙版
- (void)hideFacility{
    [_coverBgView removeAllSubviews];
    [_coverBgView removeFromSuperview];
}

#pragma mark - 查看室友详细信息
- (void)seeDetail:(UIButton *)sender{
    NSString *roomId = _roomId;
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(detailViewWithRoomId:)]) {
        [self.delegate detailViewWithRoomId:roomId];
    }
}


#pragma mark - 查看大图片
- (void)photoSelect:(UITapGestureRecognizer *)tap{

    if ([self.delegate respondsToSelector:@selector(detailView:photoDidSelect:)]) {
        UIImageView *imageV = (UIImageView *)tap.view;
        [self.delegate detailView:self photoDidSelect:imageV.image];
    }
}


- (void)btnClick:(UIButton *)btn{
    
    NSLog(@"%@",btn.titleLabel.text);
}


@end
