//
//  MainViewController.m
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 02/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "MainViewController.h"
#import "CustomButton.h"

@interface MainViewController (){
    int state;
    // views para animação
    __weak IBOutlet UIImageView *logoImageView;
    __weak IBOutlet CustomButton *nearestButton;
    __weak IBOutlet CustomButton *cheapestButton;
    __weak IBOutlet CustomButton *twentyFourButton;
    __weak IBOutlet CustomButton *searchButton;
    __weak IBOutlet UIImageView *nearestImageView;
    __weak IBOutlet UIImageView *cheapestImageView;
    __weak IBOutlet UIImageView *clockImageView;
    __weak IBOutlet UIImageView *searchImageView;
    // animar apenas uma vez
    BOOL firstTime;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate]; // status bar branca
    // esconder botoes para animacao
    [self hideButtons];
    // chegar imagem para baixo
    logoImageView.transform = CGAffineTransformMakeTranslation(0.0, 105.0);
    firstTime = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    if (firstTime == NO) {
        return;
    }
    // logo subindo
    [UIView animateWithDuration:1.0
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         logoImageView.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
                     }
                     completion:^(BOOL finished) {
                         // botoes aparecendo
                         [UIView animateWithDuration:0.5
                                         animations:^{
                                             nearestButton.alpha = 1.0;
                                             cheapestButton.alpha = 1.0;
                                             twentyFourButton.alpha = 1.0;
                                             searchButton.alpha = 1.0;
                                             nearestImageView.alpha = 1.0;
                                             cheapestImageView.alpha = 1.0;
                                             clockImageView.alpha = 1.0;
                                             searchImageView.alpha = 1.0;
                                             firstTime = NO;
                                         }];
                     }];
}

- (void)hideButtons {
    nearestButton.alpha = 0.0;
    cheapestButton.alpha = 0.0;
    twentyFourButton.alpha = 0.0;
    searchButton.alpha = 0.0;
    nearestImageView.alpha = 0.0;
    cheapestImageView.alpha = 0.0;
    clockImageView.alpha = 0.0;
    searchImageView.alpha = 0.0;
}

- (UIStatusBarStyle)preferredStatusBarStyle { //status bar branca
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAutomaticSearch:(id)sender {
    state = 1;
    [self performSegueWithIdentifier:@"transitionToMap" sender:sender];
}

- (IBAction)btnManualSearch:(id)sender {
    state = 2;
    [self performSegueWithIdentifier:@"transitionToMap" sender:sender];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"transitionToMap"]){
        MapViewController *map = [segue destinationViewController];
        [map setState:state];
        UIButton *btnSender = (UIButton *)sender;
        map.senderTitle = btnSender.titleLabel.text;
    }
}

@end
