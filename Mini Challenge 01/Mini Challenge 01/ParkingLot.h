//
//  ParkingLot.h
//  Mini Challenge 01
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 3/3/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkingLot : NSObject

@property NSString *name;
@property int opSchedule;
@property int closeSchedule;
@property float price;
@property NSString *adress;

- (NSString *) getDescription;
- (id) initName: (NSString *)n opSchedule: (int)o closeSchedule: (int)c price: (float)p adress: (NSString *)ad;

@end
