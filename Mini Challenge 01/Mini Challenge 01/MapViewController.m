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
    
    CustomAnnotation *targetAnnotation;
    
    NSArray *directions;
    
    MKCircle *overlayCircle;
    
    float SEARCH_RADIUS;
}

@end

@implementation MapViewController

#pragma mark viewStuff

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SEARCH_RADIUS = 500;
    
    //location manager setup
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDelegate:self];
    
    //map setup
    [_map setDelegate:self];
    [_map addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapMap:)]];
    [_map addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onTapHoldMap:)]];
    _map.showsUserLocation = YES;
    
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
    [_alert addAction:[UIAlertAction actionWithTitle:@"Mais próximo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Mais Próximo");
    }]];
    [_alert addAction:[UIAlertAction actionWithTitle:@"Mais barato" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Mais Barato");
    }]];
    [_alert addAction:[UIAlertAction actionWithTitle:@"24h" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"24h");
    }]];
    
    //Data
    [CentralData initData];
    [self addParkingLots];
    
    [_locationManager startUpdatingLocation];
}

-(void)viewDidAppear:(BOOL)animated{
    //[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(findAllAnnotationsInRegion) userInfo:nil repeats:NO];
    //[self findAllAnnotationsInRegion];
    NSLog(@"%@", _senderTitle);
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

#pragma mark locationManager

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = locations.lastObject;
    [self updateMapToLocation:currentLocation];
    
    [_locationManager stopUpdatingLocation];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
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
-(void)addParkingLots {
    NSArray *parkinglots = [CentralData getParkingLots];
    for (ParkingLot *pl in parkinglots) {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(pl.latitude, pl.longitude);
        [_map addAnnotation:[[CustomAnnotation alloc]initWithCoordinate:coord andTitle:pl.name]];
    }
}

- (void)updateMapToLocation:(CLLocation *)location {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1250, 1250);
    [_map setRegion:region animated:YES];
}

-(void)calculateRoute:(CLLocationCoordinate2D)source destination:(CLLocationCoordinate2D)destination {
    MKMapItem *srcItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:source addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"", nil]]];
    MKMapItem *destItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:destination addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"", nil]]];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcItem];
    [request setDestination:destItem];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    
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

-(void)calculateRoutesByProximity:(CLLocation *)source destinations:(NSArray *)dest {
    [RouteRequest calculateRoutes:source destinations:dest block:^(NSMutableArray *dir) {
        directions = dir;
        MKDirectionsResponse *best = [dir firstObject];
        for (MKDirectionsResponse *response in dir) {
            MKRoute *r1 = [[best routes] firstObject];
            MKRoute *r2 = [[response routes] firstObject];
            if(r1.distance > r2.distance){
                best = response;
            }
        }
        [self mapDrawRoute:best.routes];
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
    if(sender.state == UIGestureRecognizerStateBegan){
        CGPoint point = [sender locationInView:self.view];
        CLLocationCoordinate2D coord = [_map convertPoint:point toCoordinateFromView:self.view];
        //NSLog(@"llll %f, %f", coord.latitude, coord.longitude);

        [_map removeAnnotation:targetAnnotation];
        targetAnnotation = [[CustomAnnotation alloc] initWithCoordinate:coord andTitle:@"Local"];
        [_map addAnnotation:targetAnnotation];
        
        targetLocation = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
        
        [self mapClearOverlay];
        [self mapDrawCircle:targetLocation];
        [self calculateRoutesByProximity:targetLocation destinations:[CentralData getClosestFrom:targetLocation maxDistance:SEARCH_RADIUS]];

        // Adiciona o endereço do local na barra de busca.
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        CLLocation *location = [[CLLocation alloc]initWithLatitude:[_map region].center.latitude longitude:[_map region].center.longitude];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if(error){
                NSLog(@"%@\n",error);
                return;
            }
            regionGeocoderLocation = [placemarks objectAtIndex:0];
            _txtSearchBar.text = regionGeocoderLocation.thoroughfare;

            //        NSLog(@"Received placemarks: %@", placemarks);
            //        NSLog(@"My country code: %@ and countryName: %@\n", mark.ISOcountryCode, mark.country);
            //        NSLog(@"My city name: %@ and Neighborhood: %@\n", mark.locality, mark.subLocality);
            //        NSLog(@"My street name: %@ @\n", mark.thoroughfare);
        }];

    }
}

-(void)mapClearOverlay {
    [_map removeOverlays:_map.overlays];
}

-(void)mapDrawCircle:(CLLocation *)location {
    [_map removeOverlay:overlayCircle];
    overlayCircle = [MKCircle circleWithCenterCoordinate:(location.coordinate) radius:SEARCH_RADIUS];
    [_map addOverlay:overlayCircle];
}

-(void)mapDrawRoute:(NSArray *)routes {
    [routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MKRoute *r = obj;
        MKPolyline *line = [r polyline];
        [_map addOverlay:line];
    }];
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

}

/**
 *  Busca pelo endereço
 */
- (IBAction)btnSearchRoad:(id)sender {
    if(![_txtSearchBar.text isEqualToString:@""]){
        [self showLocationFromAddress:[_txtSearchBar text]];
    }
}
- (IBAction)btnCurrentLocation:(id)sender {
    [_locationManager startUpdatingLocation];
    
}

#warning DELETAR MÉTODO!
- (IBAction)btnTest:(id)sender {

}

@end
