//
//  SMListCell.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListCell.h"

@implementation SMListCell

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
 */

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // get the image view
    UIView *imageView = [self.contentView viewWithTag:31];
    
    // reposition title and subtitle
    if (imageView) {
        float padding = 2;
        
        CGRect textLabelFrame = self.textLabel.frame;
        self.textLabel.frame = CGRectMake(
                                          CGRectGetWidth(imageView.frame) + padding * 4, 
                                          textLabelFrame.origin.y,
                                          CGRectGetWidth(self.frame) - CGRectGetWidth(imageView.frame) - padding * 7,
                                          CGRectGetHeight(textLabelFrame)
                                          );
        
        CGRect subtitleFrame = self.detailTextLabel.frame;
        self.detailTextLabel.frame = CGRectMake(
                                          CGRectGetWidth(imageView.frame) + padding * 4,
                                          subtitleFrame.origin.y,
                                          CGRectGetWidth(self.frame) - CGRectGetWidth(imageView.frame) - padding * 7,
                                          CGRectGetHeight(subtitleFrame)
                                          );
        
    }
}

@end
