//
//  HouseListViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-9.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "HouseListViewController.h"

#import "FilterModel.h"
#import "DropdownMenu.h"

#import "CustomButton.h"

#import "HouseModel.h"
#import "CityModel.h"

#import "ConditionDoubleTableView.h"

#import "HouseListCell.h"

#import "LocationHandler.h"

#import "HouseDetailViewController.h"
#import "MJRefresh.h"

@interface HouseListViewController () <UITableViewDataSource,UITableViewDelegate,LocationHandlerDelegate,dropdownDelegate>
{
    NSArray     *_regionArr;
    NSArray     *_scopeArr;
    
    NSInteger   _selectBtnIndex;
    
    CityMenu    *_menu;
    
}

@property (nonatomic,strong) FilterModel *filter;
@property (nonatomic, strong) UITableView *houseTableView;
@property (nonatomic, strong) NSMutableArray *houseListArr;

@end

@implementation HouseListViewController

#pragma mark - 懒加载
- (HouseSearchModel *)searchModel
{
    if (!_searchModel) {
        _searchModel = [[HouseSearchModel alloc] init];
    }
    return _searchModel;
}
- (NSMutableArray *)houseListArr
{
    if (!_houseListArr) {
        _houseListArr = [NSMutableArray array];
    }
    return _houseListArr;
}

#pragma mark - 生命周期
#pragma mark - 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitle:@"租房子"];
    self.cityStr = @"上海";
    self.view.frame = [UIScreen mainScreen].bounds;
    
    UIButton *citySelect = [ViewTool createCustomButtonWithFrame:CGRectMake(0, 0, 80, 44) withCustomRect:CGRectMake(45, 18, 10, 0) title:_cityStr imgName:@"header_bar_arrow_down" selectedImgName:nil bgImageName:nil font:OneFont(16.0f) target:self action:@selector(getCityList)];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:citySelect];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reduceBackgroundSize) name:@"hideMenu" object:nil];
    
    // 检测网络
    [self checkNetWork];
    
    
    //数据初始化
    [self initData];
    
    //初始化界面
    [self initUI];
    
    //定位
    [self location];
    
}

//-----------------------------------------------------------------------------------------------------------

#pragma mark - 数据初始化
-(void)initData
{
    _houseListArr = [NSMutableArray arrayWithCapacity:0];
    _filter = [[FilterModel alloc  ]init];
    self.hasHouse = YES;
    self.isShowCityMenu = NO;
}



//-----------------------------------------------------------------------------------------------------------

#pragma mark - 界面搭建
- (void)initUI{
    
    // 1.头部筛选视图
    // 1.1获取筛选数据
    [_filter getData];
    DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_filter.titleArray andLeftListArray:_filter.leftArray andRightListArray:_filter.rightArray];
    dropdown.delegate = self;
    _dropMenu = dropdown;
    
    // 2.房屋列表
    _houseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FILTER_HEIGHT, OneScreenW, ContainerH - FILTER_HEIGHT) style:UITableViewStylePlain];
    _houseTableView.delegate = self;
    _houseTableView.dataSource = self;
    _houseTableView.separatorStyle = UITableViewCellAccessoryNone;
    [_houseTableView setRowHeight:[HouseListCell cellHeight]];
    [self.view addSubview:_houseTableView];
    
    
    // 3.加载添加刷新视图
    [self createRefresh];
    [self.view addSubview:dropdown.view];
    
    // 4.添加city菜单
    _menu = [[CityMenu alloc] initWithFrame:CGRectMake(- OneScreenW, 0, OneScreenW, OneScreenH)];
    self.menu = _menu;
    _menu.delegate = self;
    [self.view addSubview:_menu];
}

//-----------------------------------------------------------------------------------------------------------

#pragma mark - 刷新视图
- (void)createRefresh{
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _houseTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.searchModel.time = [NSNumber numberWithInteger:0];
        [weakSelf loadDataAndisRemoveAll:YES];
    }];
    // 马上进入刷新状态
    [self.houseTableView.header beginRefreshing];
    
    // 上拉加载
    self.houseTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.searchModel.time = [NSNumber numberWithInteger:[[[self.houseListArr lastObject] update_time] integerValue]];
        [weakSelf loadDataAndisRemoveAll:NO];
    }];
}


//-----------------------------------------------------------------------------------------------------------
#pragma mark - 网络请求
/**
 *  网络请求
 *
 *  @param isRemoveAll 是否移除数据数组的所有数据
 */
- (void)loadDataAndisRemoveAll:(BOOL)isRemoveAll{
    [ViewTool showHUDWithText:@"正在拼命加载..." toView:self.view];
    if (isRemoveAll) {
        [_houseListArr removeAllObjects];
    }
    //包装参数
    NSMutableDictionary *dict = self.searchModel.keyValues;
    [dict setValue:[NSNumber numberWithInteger:20] forKey:@"limit"];
    [dict setValue:[NSNumber numberWithInteger:-1] forKey:@"sort"];
    [dict setValue:[NSNumber numberWithInteger:-1] forKey:@"gender"];
    [HttpTool sendPostWithUrl:HOUSE_LIST_URL parameters:dict success:^(id data) {
        //结束刷新 隐藏缓冲视图
        [_houseTableView.header endRefreshing];
        [_houseTableView.footer endRefreshing];
        [ViewTool hideHUDFromView:self.view];
        id backData = OneJsonParserWithData(data);
        for (NSDictionary  *dict in backData[@"data"]) {
            HouseModel *model = [[HouseModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_houseListArr  addObject:model];
        }
        if (_houseListArr.count == 0) {
            self.hasHouse = NO;
        }else{
            self.hasHouse = YES;
        }
        [_houseTableView reloadData];
        if (isRemoveAll) {
            [_houseTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [ViewTool hideHUDFromView:self.view];
        [_houseTableView.header endRefreshing];
        [_houseTableView.footer endRefreshing];
        [ViewTool showHUDWithText:@"加载失败..." toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ViewTool hideHUDFromView:self.view];
        });
    }];
}



//-----------------------------------------------------------------------------------------------------------
#pragma mark - UITableView delegate & dataSource
#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hasHouse ? _houseListArr.count : 1;
}
#pragma mark - cell填充
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HouseListCell *cell = [HouseListCell cellWithTableView:tableView hasHouse:self.hasHouse];
    if (self.hasHouse) {
        cell.model = _houseListArr[indexPath.row];
    }else{
        cell.model = nil;
    }
    return cell;
}


#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HouseDetailViewController *detailVC = [[HouseDetailViewController alloc] init];
    detailVC.roomId = [_houseListArr[indexPath.row] room_id];
    detailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}



//-----------------------------------------------------------------------------------------------------------

#pragma mark - 检测网络 网络监测类
- (void)checkNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    //通过block回调,将网络状态传回
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //[self noticeUser:@"未知网络"];
                [UtilSG setBool:YES forKey:OneIsNetWork];
                //[self initUI];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                // LFLog(@"没网啊");
                [UtilSG setBool:NO forKey:OneIsNetWork];
                //[self initUI];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //[self noticeUser:@"3/4G 网络"];
                [UtilSG setBool:YES forKey:OneIsNetWork];
                //[self initUI];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //[self noticeUser:@"wifi"];
                [UtilSG setBool:YES forKey:OneIsNetWork];
                //[self initUI];
                // 请求数据
                //[self loadDataAndisRemoveAll:YES];
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 提示用户当前网络环境改变
- (void)noticeUser:(NSString *)str
{
    //获取设备的系统版本号
    CGFloat deviceVersion = [[UIDevice currentDevice].systemVersion doubleValue];
    if (deviceVersion >= 8.0) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前使用的是%@,是否继续？",str] preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前使用的是%@,是否继续？",str] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}


//-----------------------------------------------------------------------------------------------------------

#pragma mark - 定位
- (void)location{
    
    [[LocationHandler getSharedInstance] setDelegate:self];
    
    [[LocationHandler getSharedInstance] startUpdating];
    
}

#pragma mark - 定位代理
- (void)didUpdateLocations:(NSArray *)locations
{
    //获取定位的坐标
    CLLocation *location = [locations firstObject];
    //获取坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    //NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    /**
     反地理编码  : (逆地理编码)置将位信息转换为地理信息
     地理编码    : 将地理位置转换为位置信息
     */
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //传入一个位置信息，通过block将地理信息返回
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            [ViewTool showHUDWithText:@"定位失败..." toView:self.view];
        }
        //地理信息
        CLPlacemark *placeMark = [placemarks firstObject];
        NSLog(@"address:%@",placeMark.addressDictionary);
    }];
    [[LocationHandler getSharedInstance] stopUpdating];
}


//-----------------------------------------------------------------------------------------------------------

#pragma mark - 筛选条件选择代理
- (void)dropdownSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right; {
    //实现代理，返回选中的下标，若左边没有列表，则返回0
    //NSLog(@"%s : You choice btn  %@ and %@", __FUNCTION__, left, right);
    _searchModel.time = [NSNumber numberWithInteger:0];
    if (_selectBtnIndex == 0) {
        if ([left integerValue]== 0) {
            _searchModel.region_id = @"";
            _searchModel.plate_id = @"";
        }else if ([left integerValue] != 0 && [right integerValue] == 0){
            _searchModel.region_id = _filter.regionAndIdArr[[left integerValue] - 1][@"mid"];
            _searchModel.plate_id = @"";
        }else{
            _searchModel.region_id = _filter.regionAndIdArr[[left integerValue] - 1][@"mid"];
            _searchModel.plate_id = _filter.subScopeAndIdArr[[left integerValue] - 1][[right integerValue] - 1][@"mid"];
        }
    }
    
    if (1 == _selectBtnIndex) {
        if ([right integerValue] == 0) {
            _searchModel.money_max = [NSNumber numberWithInteger:0];
            _searchModel.money_min = [NSNumber numberWithInteger:0];
        }else if(1 == [right integerValue]){
            _searchModel.money_max = [NSNumber numberWithInteger:1500];
            _searchModel.money_min = [NSNumber numberWithInteger:0];
        }else if (2 == [right integerValue]){
            _searchModel.money_max = [NSNumber numberWithInteger:2500];
            _searchModel.money_min = [NSNumber numberWithInteger:1500];
        }else if (3 == [right integerValue]){
            _searchModel.money_max = [NSNumber numberWithInteger:RAND_MAX];
            _searchModel.money_min = [NSNumber numberWithInteger:2500];
        }
    }
    
    if (2 == _selectBtnIndex) {
        if ([right integerValue] == 0) {
            _searchModel.square_max = [NSNumber numberWithInteger:0];
            _searchModel.square_min = [NSNumber numberWithInteger:0];
        }else if(1 == [right integerValue]){
            _searchModel.square_max = [NSNumber numberWithInteger:12];
            _searchModel.square_min = [NSNumber numberWithInteger:0];
        }else if (2 == [right integerValue]){
            _searchModel.square_max = [NSNumber numberWithInteger:20];
            _searchModel.square_min = [NSNumber numberWithInteger:12];
        }else if (3 == [right integerValue]){
            _searchModel.square_max = [NSNumber numberWithInteger:RAND_MAX];
            _searchModel.square_min = [NSNumber numberWithInteger:20];
        }
    }
    
    [self loadDataAndisRemoveAll:YES];
}

#pragma mark - 监听菜单的收缩
- (void)reduceBackgroundSize {
    [_dropMenu.view setFrame:CGRectMake(0, 0, OneScreenW, 35)];
}


//-----------------------------------------------------------------------------------------------------------


#pragma mark - 菜单
#pragma mark - 显示城市列表
- (void)getCityList{
    if (!self.isShowCityMenu) {
        [_menu showCityMenu:YES];
        self.isShowCityMenu = YES;
    }else{
        [_menu showCityMenu:NO];
        self.isShowCityMenu = NO;
    }
    
}

#pragma mark - 选择了哪一个城市
- (void)didSelectedCity:(CityModel *)city{
    self.request_url = city.request_url;
    self.cityStr = [city.city_name substringToIndex:2];
    //执行请求
    NSLog(@"你点击了%@",self.cityStr);
}

//-----------------------------------------------------------------------------------------------------------

#pragma mark - 点击了哪一个筛选条件
- (void)didSelectedBtn:(NSInteger)index{
    _selectBtnIndex = index;
}

//-----------------------------------------------------------------------------------------------------------

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
