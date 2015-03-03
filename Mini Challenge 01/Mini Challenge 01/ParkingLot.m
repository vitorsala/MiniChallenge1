//
//  ParkingLot.m
//  Mini Challenge 01
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 3/3/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "ParkingLot.h"

@implementation ParkingLot

- (id) initName: (NSString *)n opSchedule: (int)o closeSchedule: (int)c price: (float)p adress: (NSString *)ad {
    self = [super init];
    if (self) {
        _name = n;
        _opSchedule = o;
        _closeSchedule = c;
        _price = p;
        _adress = ad;
        
    }
    return self;
}


- (NSString *)getDescription {
    NSString *d = [NSString alloc];
    d = [d initWithString:[NSString stringWithFormat:@"Nome: %@\nAbre às: %dh\nFecha às: %dh\nPreço por hora: R$%f\nEndereço: %@", _name, _opSchedule, _closeSchedule, _price, _adress]];
    
    return d;
    
}


@end
