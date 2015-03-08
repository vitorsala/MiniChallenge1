//
//  ParkingLot.h
//  Mini Challenge 01
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 3/3/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ParkingLot : NSObject

@property NSString *name;
@property int opSchedule;
@property int closeSchedule;
@property float price;
@property NSString *adress;
@property float latitude;
@property float longitude;
@property CLLocation *location;
@property NSString *imageName;

- (NSString *) getDescription;
- (id) initName: (NSString *)n opSchedule: (int)o closeSchedule: (int)c price: (float)p adress: (NSString *)ad latitude:(float)la longitude:(float)lo;

@end
