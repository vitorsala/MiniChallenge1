//
//  MoreMenuTableView.h
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 03/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTableViewCell.h"

@interface MoreMenuTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *viewMoreMenu;
@property NSMutableArray *data;

-(instancetype)initWithView:(UITableView *)view;

@end
