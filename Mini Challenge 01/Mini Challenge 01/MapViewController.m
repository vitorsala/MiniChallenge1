//
//  MapViewController.m
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 02/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController () {
    CLLocation *currentLocation;
//    int state;
}

@end

@implementation MapViewController

/**
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeState:_state];
//    _alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Msg" preferredStyle:UIAlertControllerStyleActionSheet];

//    _viewMoreMenu.layer.position = CGPointMake(_viewMoreMenu.layer.position.x, 800);
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
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
