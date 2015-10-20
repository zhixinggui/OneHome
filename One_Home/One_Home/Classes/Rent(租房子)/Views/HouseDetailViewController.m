//
//  HouseDetailViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-12.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "HouseDetailViewController.h"

#import "HouseModel.h"
#import "HouseDetailModel.h"


#import "HousePhotoViewController.h"


#import "HouseDetailView.h"


@interface HouseDetailViewController () <HouseDetailViewDelegate>
{
    HouseDetailView         *_detailView;
    
    UIScrollView            *_detailScrollView;
    
    UIButton                *_contactBtn;
    
}
@property (nonatomic,strong) HouseDetailModel  *detailModel;

@end

@implementation HouseDetailViewController
#pragma mark - 懒加载
//...
-(HouseDetailModel *)detailModel
{
    if (_detailModel) {
        _detailModel = [[HouseDetailModel alloc] init];
    }
    return _detailModel;
}

#pragma mark - 生命周期
#pragma mark - 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tabBarController.tabBar.hidden = YES;
    
    [self addTitle:@"合租详情"];
    
    //分享按钮
    [self setNavicationButtonWithFrame:CGRectMake(10, 5, 36, 30) title:nil target:self action:@selector(shareClick:) isLeft:NO backgroudImgName:@"btn_forum_share_n" selectedImgName:@"btn_forum_share_c"];
    
    
    //数据初始化
    [self initData];
    
    //获取数据
    [self loadData];
    
}
#pragma mark - 数据初始化
-(void)initData
{
    
}



//-----------------------------------------------------------------------------------------------------------


#pragma mark - 网络请求
- (void)loadData
{
    [ViewTool showHUDWithText:@"正在拼命加载..." toView:self.view];
    NSDictionary *dict = @{@"room_id":_roomId};
    [HttpTool sendPostWithUrl:HOUSE_DETAIL_URL parameters:dict success:^(id data) {
        [ViewTool hideHUDFromView:self.view];
        id backData = OneJsonParserWithData(data);
        self.detailModel = [HouseDetailModel objectWithKeyValues:backData[@"data"]];
        [self createDetailView];
    } fail:^(NSError *error) {
        [ViewTool hideHUDFromView:self.view];
        [ViewTool showHUDWithText:@"加载失败" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ViewTool hideHUDFromView:self.view];
        });
    }];
}

#pragma mark - 界面搭建
#pragma mark - 创建详情视图
- (void)createDetailView
{
    
    _detailView = [HouseDetailView viewWithdetailModel:_detailModel];
    _detailView.delegate = self;
    
    _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, OneScreenW, OneScreenH - 64 - 49)];
    _detailScrollView.contentSize = CGSizeMake(OneScreenW, _detailView.frame.size.height);
    _detailScrollView.bounces = NO;
    [_detailScrollView addSubview:_detailView];
    [self.view addSubview:_detailScrollView];
    
    //self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    UIButton *contactBtn = [ViewTool createCustomButtonWithFrame:CGRectMake(0, OneScreenH - 49 - 64, OneScreenW, 49) withCustomRect:CGRectMake(OneScreenW - 50, 0, 48, 0) title:@"联系房东" imgName:@"call_agent" selectedImgName:@"icon_jindutiao1.png" bgImageName:@"icon_jindutiao1.png" font:     OneFontWithName(@"MarkerFelt-Wide", 18.0f) target:self action:@selector(contactBtnClick)];
    [self.view addSubview:contactBtn];
    
}



#pragma mark - 点击图片查看
//最后放弃了那种笨蛋的行为，直接使用视图弹窗得啦
- (void)detailView:(HouseDetailView *)detailView photoDidSelect:(UIImage *)view
{
    
    CATransition *ani = [CATransition animation];
    ani.type = @"rippleEffect";
    ani.duration = 2.0f;
    ani.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:ani forKey:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                                            style:UIBarButtonItemStylePlain target:nil action:nil];
    HousePhotoViewController *photoVC = [[HousePhotoViewController alloc] init];
    
    self.navigationController.hidesBottomBarWhenPushed = YES;
    
    photoVC.image = view;
    
    [self.navigationController pushViewController:photoVC animated:NO];
    
    
    
    
}


#pragma mark - 分享链接
- (void)shareClick:(UIButton *)btn{
    NSLog(@"我分享啦哈");
}






#pragma mark - 联系房东
- (void)contactBtnClick{
    
    if (![_detailModel.owne_number isEqualToString:@""]) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"联系房东" message:[NSString stringWithFormat:@"电话:%@",@"18737175644"]  preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"18737175644"]]];
        }]];
        
        [self presentViewController:alertVc animated:YES completion:nil];
        
    }
}


#pragma mark - 查看室友或者隔壁房间
- (void)detailViewWithRoomId:(NSString *)roomId
{
    _roomId = roomId;
    [self loadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
