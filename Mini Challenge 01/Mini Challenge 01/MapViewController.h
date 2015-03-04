//
//  MapViewController.h
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 02/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CloudKit/CloudKit.h>
#import "MoreMenuTableViewController.h"
#import "CustomAnnotation.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>


@property CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchBar;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property UIAlertController* alert;
@property int state;
@property MoreMenuTableViewController* viewMoreController;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnOptions:(id)sender;
- (IBAction)btnNextPrev:(id)sender;
- (IBAction)btnSearchRoad:(id)sender;


-(void)changeState:(int)state;
@end
