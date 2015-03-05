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

    MKPlacemark *addressGeocoderLocation,
                *regionGeocoderLocation;
}

@end

@implementation MapViewController

#pragma mark viewStuff

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
    
    //UI setup
    [self changeState:_state];
    
    //permissions
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }

    // Actions
    _alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Msg" preferredStyle:UIAlertControllerStyleActionSheet];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancelou");
    }]];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Mais Próximo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Mais Próximo");
    }]];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Mais Barato" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Mais Barato");
    }]];
    [_alert addAction:[UIAlertAction actionWithTitle:@"24h" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"24h");
    }]];

    // Map configurations
    _map.showsUserLocation = YES;
    
    [self test];
}

-(void)viewDidAppear:(BOOL)animated{
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
}

#pragma mark locationManager

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = locations.lastObject;
    [self updateMapToLocation:currentLocation];
    [_locationManager stopUpdatingLocation];

    [_map removeOverlay:_searchRadius];
    _searchRadius = [MKCircle circleWithCenterCoordinate:(_map.userLocation.coordinate) radius:500];
    [_map addOverlay:_searchRadius];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:[_map region].center.latitude longitude:[_map region].center.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            NSLog(@"%@\n",error);
            return;
        }
        regionGeocoderLocation = [placemarks objectAtIndex:0];

//        NSLog(@"Received placemarks: %@", placemarks);
//        NSLog(@"My country code: %@ and countryName: %@\n", mark.ISOcountryCode, mark.country);
//        NSLog(@"My city name: %@ and Neighborhood: %@\n", mark.locality, mark.subLocality);
//        NSLog(@"My street name: %@ @\n", mark.thoroughfare);
    }];
}

-(CLLocation *)showLocationFromAddress:(NSString *)address {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            NSLog(@"%@\n",error);
            addressGeocoderLocation = nil;
            return;
        }
        addressGeocoderLocation = [placemarks lastObject];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(addressGeocoderLocation.location.coordinate, 1250, 1250);
        [_map setRegion:region animated:YES];
    }];
    return nil;
}

#pragma mark Map

- (void)updateMapToLocation:(CLLocation *)location {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1250, 1250);
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

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        render.lineWidth = 3.0;
        render.strokeColor = [UIColor blueColor];
        return render;
    }
    else if ([overlay isKindOfClass:[MKCircle class]]){
        MKCircleRenderer *circle = [[MKCircleRenderer alloc]initWithOverlay:overlay];
        circle.lineWidth = 1.0;
        circle.fillColor = [[UIColor colorWithRed:0 green:0 blue:0.4 alpha:1] colorWithAlphaComponent:0.05];
        circle.strokeColor = [[UIColor colorWithRed:0 green:0 blue:1 alpha:1] colorWithAlphaComponent:1];
        return circle;
    }
    return nil;
}

-(void)onTapMap:(UITapGestureRecognizer *)sender {
    
}

-(void)onTapHoldMap:(UILongPressGestureRecognizer *)sender {
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

#pragma mark Annotations

/**
 Método que faz as imagens customizadas das annotations aparecerem no mapa
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MyPoint class]]){
        
        MyPoint *p = (MyPoint *)annotation;
        MKAnnotationView *mkav = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyPoint"];
        
        if(mkav == nil){
            mkav = p.annotationView;
        } else {
            mkav.annotation = annotation;
        }
        return mkav;
    }
    return nil;
}

#pragma mark Actions

/**
 *  Volta para a mainView
 */
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Abre as opções de filtro
 */
- (IBAction)btnOptions:(id)sender {
    [self presentViewController:_alert animated:YES completion:nil];
}

/**
 *  NOT IMPLEMENTED
 */
- (IBAction)btnNextPrev:(id)sender {
    [self test];
}

/**
 *  Busca pelo endereço
 */
- (IBAction)btnSearchRoad:(id)sender {
    if(![_txtSearchBar.text isEqualToString:@""]){
        [self showLocationFromAddress:[_txtSearchBar text]];
    }
}

#warning DELETAR MÉTODO!
- (IBAction)btnTest:(id)sender {
    _state = (_state == 1 ? 2 : 1);
    [self changeState:_state];
}

@end
