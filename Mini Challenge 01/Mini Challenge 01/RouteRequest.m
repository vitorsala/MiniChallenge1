//
//  RouteRequest.m
//  Mini Challenge 01
//
//  Created by William Hong Jun Cho on 3/6/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "RouteRequest.h"

static NSMutableArray *active;

@implementation RouteRequest {
    NSArray *destinations;
    CLLocation *source;
    NSMutableArray *directions;
    void (^block)(NSMutableArray *);
}

-(id)init {
    if(!active){
        active = [[NSMutableArray alloc]init];
    }
    return [super init];
}

-(void)calculateRoutes:(CLLocation *)src destinations:(NSArray *)dest block:(void(^)(NSMutableArray *))blc {
    directions = [[NSMutableArray alloc]init];
    block = blc;
    source = src;
    destinations = dest;
    
    MKMapItem *srcItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:src.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]]];
    
    //para não perder a referencia enquanto espera
    [active addObject:self];
    
    for (ParkingLot *pl in dest) {
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
        [request setSource:srcItem];
        [request setDestination:[[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:pl.location.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]]]];
        [request setTransportType:MKDirectionsTransportTypeAutomobile];
        
        MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if(error) {
                
            }
            [directions addObject:response];
            
            //finished
            if(directions.count == destinations.count) {
                block(directions);
                [active removeObject:self];
                [self destroy];
            }
        }];
    }
}

-(void)destroy {
    destinations = nil;
    source = nil;
    directions = nil;
    block = nil;
}

+(RouteRequest *)calculateRoutes:(CLLocation *)src destinations:(NSArray *)dest block:(void(^)(NSMutableArray *))blc {
    RouteRequest *rr = [[RouteRequest alloc]init];
    [rr calculateRoutes:src destinations:dest block:blc];
    return rr;
}


@end
