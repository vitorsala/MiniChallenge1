//
//  RouteRequest.h
//  Mini Challenge 01
//
//  Created by William Hong Jun Cho on 3/6/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ParkingLot.h"

@interface RouteRequest : NSObject

+(RouteRequest *)calculateRoutes:(CLLocation *)src destinations:(NSArray *)dest block:(void(^)(NSMutableArray *))blc;

@end
