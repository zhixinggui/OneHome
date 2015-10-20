//
//  LocationHandler.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-10.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "LocationHandler.h"

static LocationHandler *DefaultManager = nil;

@interface LocationHandler()

-(void)initiate;

@end

@implementation LocationHandler

+(instancetype)getSharedInstance{
    if (!DefaultManager) {
        DefaultManager = [[self allocWithZone:NULL]init];
        [DefaultManager initiate];
    }
    return DefaultManager;
}
-(void)initiate{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        // iOS8需要添加如下代码
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            [_locationManager requestAlwaysAuthorization]; // 请求一直定位
            [_locationManager requestWhenInUseAuthorization]; // 请求在使用中定位
        }
        _locationManager.delegate = self;
    }
}

-(void)startUpdating{
    [_locationManager startUpdatingLocation];
}

-(void) stopUpdating{
    [_locationManager stopUpdatingLocation];
}



#pragma mark - IOS8.0
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if ([self.delegate respondsToSelector:@selector
         (didUpdateLocations:)])
    {
        [self.delegate didUpdateLocations:locations];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ViewTool showHUDWithText:@"定位失败..." toView:[UIApplication sharedApplication].keyWindow];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ViewTool hideHUDFromView:[UIApplication sharedApplication].keyWindow];
    });
    
}

@end
