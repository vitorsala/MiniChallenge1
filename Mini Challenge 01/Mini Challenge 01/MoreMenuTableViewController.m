//
//  MoreMenuTableView.m
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 03/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "MoreMenuTableViewController.h"

@interface MoreMenuTableViewController()

@end

@implementation MoreMenuTableViewController

- (instancetype)initWithView:(UITableView *)view{
    self = [super init];
    if(self){
        _viewMoreMenu = view;
        _data = [[NSMutableArray alloc] init];

        [_data addObject:@"Mais Próximo"];
        [_data addObject:@"Mais Barato"];
        [_data addObject:@"24H"];


        _viewMoreMenu.delegate = self;
        _viewMoreMenu.dataSource = self;
//        [self tableView:_viewMoreMenu cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:0 length:[]];

        [_viewMoreMenu reloadData];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell" forIndexPath:indexPath];
    [cell lblOption].text = [_data objectAtIndex:[indexPath row]];
    return cell;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

@end
