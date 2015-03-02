//
//  MapViewController.m
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 02/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "MapViewController.h"

static const int STATE_MANUAL = 0;
static const int STATE_ROUTE = 1;

@interface MapViewController () {
    CLLocation *currentLocation;
    int state;
}

@end

@implementation MapViewController

/**
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    state = -1;
    
    
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeState:(int)s {
    
}

/**
    Map
 */
- (void)updateMapToLocation:(CLLocation *)location {
    currentLocation = location;
    if(location) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 250, 250);
        [self.map setRegion:region animated:YES];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
}

-(MKCoordinateRegion)getRoute:(MKPlacemark *)source destination:(MKPlacemark *)destination {
    MKMapItem *srcItem = [[MKMapItem alloc]initWithPlacemark:source];
    MKMapItem *destItem = [[MKMapItem alloc]initWithPlacemark:destination];
    
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
            [self.map addOverlay:line];
            
//            NSArray *steps = [r steps];
//            [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                
//            }];
            
        }];
    }];
    
    return MKCoordinateRegionMakeWithDistance(source.coordinate, 250, 250);
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;

        return aView;
    }
    return nil;
}

-(void)mapDrawRoute:(MKMapView *)map overlay:(id)overlay {
    
}


/**
    Actions
 */
- (IBAction)btnBack:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *nextView = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self presentViewController:nextView animated:YES completion:nil];
}

- (IBAction)btnOptions:(id)sender {
}

- (IBAction)btnNextPrev:(id)sender {
}

- (IBAction)btnSearchRoad:(id)sender {
}

@end