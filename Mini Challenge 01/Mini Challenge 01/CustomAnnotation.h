//
//  CustomAnnotation.h
//  Mini Challenge 01
//
//  Created by William Hong Jun Cho on 3/3/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title;

@end
