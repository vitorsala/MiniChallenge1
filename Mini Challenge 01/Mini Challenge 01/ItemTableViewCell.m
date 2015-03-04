//
//  ItemTableViewCell.m
//  Mini Challenge 01
//
//  Created by Vitor Kawai Sala on 03/03/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell

- (void)awakeFromNib {
    _lblOption.text = @"label";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
