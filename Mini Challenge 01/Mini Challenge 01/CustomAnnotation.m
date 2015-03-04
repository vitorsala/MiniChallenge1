//
//  CustomAnnotation.m
//  Mini Challenge 01
//
//  Created by William Hong Jun Cho on 3/3/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title {
    self = [super init];
    if(self) {
        _coordinate = coordinate;
        _title = title;
    }
    return self;
}

@end
