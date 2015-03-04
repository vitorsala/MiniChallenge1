//
//  MapViewController.m
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 02/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController () {
    CLLocation  *currentLocation,
                *startLocation,
                *targetLocation;
    
}

@end

@implementation MapViewController

/**
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //location manager setup
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDelegate:self];
    
    //map setup
    [_map setDelegate:self];
    [_map addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onTapHoldMap:)]];
    
    //UI setup
    [self changeState:_state];
    
    //permissions
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeState:(int)state {
    for(id subView in [self.view subviews]){
        if(state == 1){ // Info mode
            if([(UIView *)subView tag] == 1){
                [(UIView *)subView setHidden:false];
            }
            else if([(UIView *)subView tag] == 2){
                [(UIView *)subView setHidden:true];
            }
        }
        else if(state == 2){ // Search mode
            if([(UIView *)subView tag] == 1){
                [(UIView *)subView setHidden:true];
            }
            else if([(UIView *)subView tag] == 2){
                [(UIView *)subView setHidden:false];
            }
        }
    }
}


-(void)test {
    [_locationManager startUpdatingLocation];
}

/**
    Location Manager
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = locations.lastObject;
    [self updateMapToLocation:currentLocation];
    
    [_locationManager stopUpdatingLocation];
}

/**
    Map
 */
- (void)updateMapToLocation:(CLLocation *)location {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 250, 250);
    [_map setRegion:region animated:YES];
}

-(void)updateMapToCoordinate:(CLLocationCoordinate2D)coordinate {
    [_map setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000) animated:YES];
}

-(void)calculateRoute:(CLLocationCoordinate2D)source destination:(CLLocationCoordinate2D)destination {
    MKMapItem *srcItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:source addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"", nil]]];
    MKMapItem *destItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:destination addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"", nil]]];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcItem];
    [request setDestination:destItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        NSArray *routes = [response routes];
        [routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MKRoute *r = obj;
            MKPolyline *line = [r polyline];
            [_map addOverlay:line];
        }];
    }];
}

- (MKOverlayPathRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        render.lineWidth = 3.0;
        render.strokeColor = [UIColor blueColor];
        return render;
    }
    return nil;
}

-(void)onTapHoldMap:(UITapGestureRecognizer *)sender {
    [_map removeAnnotations:[_map annotations]];
    
    CGPoint point = [sender locationInView:self.view];
    CLLocationCoordinate2D coord = [_map convertPoint:point toCoordinateFromView:self.view];
    [_map addAnnotation:[[CustomAnnotation alloc]initWithCoordinate:coord andTitle:@"title"]];
    
    targetLocation = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [self calculateRoute:currentLocation.coordinate destination:targetLocation.coordinate];
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    //todo: select view, set it as new target location, calculate route
    NSLog(@"Selected");
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"Deselected");
}


/**
    Actions
 */
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnOptions:(id)sender {
}

- (IBAction)btnNextPrev:(id)sender {
}

- (IBAction)btnSearchRoad:(id)sender {
}

@end
