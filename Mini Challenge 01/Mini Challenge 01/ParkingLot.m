//
//  ParkingLot.m
//  Mini Challenge 01
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 3/3/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "ParkingLot.h"

@implementation ParkingLot

- (id) initName: (NSString *)n opSchedule: (int)o closeSchedule: (int)c price: (float)p adress: (NSString *)ad latitude:(float)la longitude:(float)lo {
    self = [super init];
    if (self) {
        _name = n;
        _opSchedule = o;
        _closeSchedule = c;
        _price = p;
        _adress = ad;
        _latitude = la;
        _longitude = lo;
    }
    return self;
}


- (NSString *)getDescription {
    NSString *d = [NSString alloc];
    if(_opSchedule == _closeSchedule){
        d = [d initWithString:[NSString stringWithFormat:@"Nome: %@ \nHorário: Aberto 24h \nPreço por hora: R$%f \nEndereço: %@", _name, _price, _adress]];
    } else {
        d = [d initWithString:[NSString stringWithFormat:@"Nome: %@\nHorário: %dh - %dh \nPreço por hora: R$%f\nEndereço: %@", _name, _opSchedule, _closeSchedule, _price, _adress]];
    }
    
    return d;
    
}


@end
