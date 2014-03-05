//
//  SMTableCell.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 13/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMTableCell.h"

@implementation SMTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
        UIView *selectedBackgroundView = [UIView new];
        selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        self.selectedBackgroundView = selectedBackgroundView;
    }
    return self;
}

@end
