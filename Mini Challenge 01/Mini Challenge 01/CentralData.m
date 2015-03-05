//
//  CentralData.m
//  Mini Challenge 01
//
//  Created by William Hong Jun Cho on 3/5/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "CentralData.h"

static NSMutableArray *parkingLots;
@implementation CentralData



+(void)initData {
    parkingLots = [[NSMutableArray alloc]initWithObjects:
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:0.0 longitude:0.0],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:0.0 longitude:0.0],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:0.0 longitude:0.0],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:0.0 longitude:0.0],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:0.0 longitude:0.0],
                   nil];
}

+(NSMutableArray *)getParkingLots {
    return parkingLots;
}



@end
