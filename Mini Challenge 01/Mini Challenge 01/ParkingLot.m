//
//  ParkingLot.m
//  Mini Challenge 01
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 3/3/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "ParkingLot.h"

@implementation ParkingLot

- (id) initName: (NSString *)n opSchedule: (int)o closeSchedule: (int)c price: (float)p adress: (NSString *)ad latitude:(float)la longitude:(float)lo imageName:(NSString*)i{
    self = [super init];
    if (self) {
        _name = n;
        _opSchedule = o;
        _closeSchedule = c;
        _price = p;
        _adress = ad;
        _latitude = la;
        _longitude = lo;
        _location = [[CLLocation alloc]initWithLatitude:la longitude:lo];
        _imageName = i;
    }
    return self;
}


- (NSString *)getDescription {
    NSString *d = [NSString alloc];
    if(_opSchedule == _closeSchedule){
        d = [d initWithString:[NSString stringWithFormat:@"Horário: Aberto 24h \nPreço por hora: R$%.2f \nEndereço: %@", _price, _adress]];
    } else {
        d = [d initWithString:[NSString stringWithFormat:@"Horário: %dh - %dh \nPreço por hora: R$%.2f\nEndereço: %@",  _opSchedule, _closeSchedule, _price, _adress]];
    }
    
    return d;
    
}


@end
