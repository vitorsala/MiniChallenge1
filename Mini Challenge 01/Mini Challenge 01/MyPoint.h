//
//  MyPoint.h
//  Mini Challenge 01
//
//  Created by Lucas Leal Mendonça on 04/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyPoint : NSObject <MKAnnotation>

-(id) initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t imageName: (NSString *)n subtitle: (NSString *)s;
-(MKAnnotationView *)annotationView;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

//Propriedade própria do nome da imagem
@property (nonatomic, copy) NSString *imageName;

@property(nonatomic, readonly, copy) NSString *subtitle;

@end
