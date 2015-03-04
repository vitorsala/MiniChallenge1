//
//  MyPoint.m
//  Mini Challenge 01
//
//  Created by Lucas Leal Mendonça on 04/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "MyPoint.h"

@implementation MyPoint

@synthesize coordinate, title, imageName;

-(id) initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t imageName: (NSString *)n{
    self = [super init];
    if(self)
    {
        coordinate = c;
        [self setTitle:t];
        imageName = n;//Guarda apenas o NOME da imagem. No método annotationView ele é "convertida" pra UIImage.
    }
    return self;
}

-(MKAnnotationView *)annotationView{
    MKAnnotationView *av = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyPoint"];//Tem que ver esse reuseIdentifier ae
    av.enabled = YES;
    av.canShowCallout = YES;
    av.image = [UIImage imageNamed:imageName];
    av.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return av;
}


@end
