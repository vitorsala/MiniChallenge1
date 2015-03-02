//
//  MainViewController.m
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 02/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    int state;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAutomaticSearch:(id)sender {
    state = 1;
}

- (IBAction)btnManualSearch:(id)sender {
    state = 2;

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"transitionToMap"]){
        MapViewController *map = [segue destinationViewController];
        [map setState:state];
    }
}

@end
