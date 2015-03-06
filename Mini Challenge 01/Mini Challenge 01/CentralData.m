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
                   [[ParkingLot alloc] initName:@"Hue" opSchedule:1 closeSchedule:10 price:10.0 adress:@"e eu sei la" latitude:-23.547200 longitude: -46.656579 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.548277 longitude: -46.658669 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544656 longitude: -46.654653 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.541768 longitude: -46.660056 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.541438 longitude: -46.656661 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.547574 longitude: -46.661460 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551524 longitude: -46.663272 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551016 longitude: -46.667434 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551300 longitude: -46.666520 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544042 longitude: -46.663321 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.543414 longitude: -46.661803 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.538041 longitude: -46.653641 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.541157 longitude: -46.649665 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.542624 longitude: -46.648425 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544494 longitude: -46.649551 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.549941 longitude: -46.650596 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551004 longitude: -46.648392 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.552979 longitude: -46.653942 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.556830 longitude: -46.656911 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.558162 longitude: -46.658380 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.560152 longitude: -46.661433 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.558760 longitude: -46.661857 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.561513 longitude: -46.658723 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.564221 longitude: -46.659507 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.565074 longitude: -46.655426 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.563324 longitude: -46.652977 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.559059 longitude: -46.650610 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.555483 longitude: -46.653026 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.553283 longitude: -46.648586 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.555199 longitude: -46.645027 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551907 longitude: -46.644130 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.545182 longitude: -46.644463 imageName: @"location1"],
                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544299 longitude: -46.646471 imageName: @"location1"],
                   nil];
}

+(NSMutableArray *)getParkingLots {
    return parkingLots;
}

+(NSArray *)getClosestFrom:(CLLocation *)loc maxDistance:(float)maxDistance {
    NSMutableArray *p = [[NSMutableArray alloc]init];
    for (ParkingLot *pl in parkingLots) {
        double dist = [loc distanceFromLocation:pl.location];
        if(dist <= maxDistance) {
            [p addObject:pl];
        }
    }
    
    return p;
}



@end
