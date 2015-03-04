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
    [_map addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapMap:)]];
    [_map addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onTapHoldMap:)]];
    [_map setShowsPointsOfInterest:YES];
    
    //UI setup
    [self changeState:_state];
//    _alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Msg" preferredStyle:UIAlertControllerStyleActionSheet];

//    _viewMoreMenu.layer.position = CGPointMake(_viewMoreMenu.layer.position.x, 800);
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [self test];
}

-(void)viewDidAppear:(BOOL)animated{
    _viewMoreController = [[MoreMenuTableViewController alloc] initWithView:(UITableView *)[self.view viewWithTag:100]];
    [_viewMoreController.viewMoreMenu setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeState:(int)state {
    for(UIView *subView in [self.view subviews]){
        [UIView transitionWithView:subView duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil];
        subView.hidden = (([subView tag] != 0 && state != [subView tag]) || [subView tag] == 100);
    }
}


-(void)test {
    [_locationManager startUpdatingLocation];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSLog(@"U.D. = %f", [defaults floatForKey:@"test"]);
    [defaults setFloat:6.0 forKey:@"test"];
    [defaults synchronize];
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

-(void)onTapMap:(UITapGestureRecognizer *)sender {
    CLLocationCoordinate2D coord = [_map convertPoint:[sender locationInView:self.view] toCoordinateFromView:self.view];
    [_map addAnnotation:[[CustomAnnotation alloc]initWithCoordinate:coord andTitle:@"title"]];
}

-(void)onTapHoldMap:(UILongPressGestureRecognizer *)sender {
    [_map removeAnnotations:[_map annotations]];
    
    CLLocationCoordinate2D coord = [_map convertPoint:[sender locationInView:self.view] toCoordinateFromView:self.view];
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

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    NSArray *annotations = [_map annotations];
//    for (CustomAnnotation *in annotations) {
//        MKMetersBetweenMapPoints(MKMapPointForCoordinate(ann.coordinate), MKMapPointForCoordinate(ann.coordinate));
//    }
    
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

#warning DELETAR MÉTODO!
- (IBAction)btnTest:(id)sender {
    _state = (_state == 1 ? 2 : 1);
    [self changeState:_state];
}

@end
