//
//  CentralData.h
//  Mini Challenge 01
//
//  Created by William Hong Jun Cho on 3/5/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParkingLot.h"

@interface CentralData : NSObject

+(void)initData;
+(NSMutableArray *)getParkingLots;

@end
