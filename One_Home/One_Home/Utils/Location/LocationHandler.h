//
//  LocationHandler.h
//  One_Home
//
//  Created by hanxiaocu on 15-10-10.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>



@protocol LocationHandlerDelegate <NSObject>
/**IOS6.0之前的定位*/
@optional
-(void) didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation;
/**IOS7.0之后的定位*/
@required
- (void)didUpdateLocations:(NSArray *)locations;
@end

@interface LocationHandler : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@property(nonatomic,strong) id<LocationHandlerDelegate> delegate;

+(instancetype)getSharedInstance;

-(void)startUpdating;

-(void) stopUpdating;

@end
