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
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.547200 longitude: -46.656579],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.548277 longitude: -46.658669],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544656 longitude: -46.654653],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.541768 longitude: -46.660056],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.541438 longitude: -46.656661],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.547574 longitude: -46.661460],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551524 longitude: -46.663272],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551016 longitude: -46.667434],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551300 longitude: -46.666520],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544042 longitude: -46.663321],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.543414 longitude: -46.661803],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.538041 longitude: -46.653641],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.541157 longitude: -46.649665],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.542624 longitude: -46.648425],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544494 longitude: -46.649551],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.549941 longitude: -46.650596],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551004 longitude: -46.648392],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.552979 longitude: -46.653942],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.556830 longitude: -46.656911],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.558162 longitude: -46.658380],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.560152 longitude: -46.661433],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.558760 longitude: -46.661857],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.561513 longitude: -46.658723],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.564221 longitude: -46.659507],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.565074 longitude: -46.655426],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.563324 longitude: -46.652977],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.559059 longitude: -46.650610],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.555483 longitude: -46.653026],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.553283 longitude: -46.648586],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.555199 longitude: -46.645027],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551907 longitude: -46.644130],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.545182 longitude: -46.644463],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544299 longitude: -46.646471],
                   nil];
}

+(NSMutableArray *)getParkingLots {
    return parkingLots;
}



@end
