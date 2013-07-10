//
//  SMListCell.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListCell.h"
#import "UIColor+SSToolkitAdditions.h"
#import "UIColor+ZulaAdditions.h"
#import <QuartzCore/QuartzCore.h>

@interface SMListCell()
- (void)appearanceForBackgroundColorHex:(NSString *)colorHex;
- (void)appearanceForTitleColor:(NSString *)hexColor;
- (void)appearanceForSubtitleColor:(NSString *)hexColor;
@end

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

- (void)applyAppearances:(NSDictionary *)appearances
{
    [self appearanceForBackgroundColorHex:[appearances objectForKey:@"bg_color"]];
    [self appearanceForTitleColor:[appearances objectForKey:@"title_color"]];
    [self appearanceForSubtitleColor:[appearances objectForKey:@"subtitle_color"]];
}

- (void)appearanceForBackgroundColorHex:(NSString *)colorHex
{
    // default value
    if (!colorHex) {
        colorHex = @"clean";
    }
    
    if ([colorHex isEqualToString:@"clean"] || [colorHex isEqualToString:@""]) {
        //[self setBackgroundColor:[UIColor clearColor]];
    } else {
        UIView *backgroundImageView = [self backgroundView];
        if (backgroundImageView) {
            [backgroundImageView setBackgroundColor:[UIColor colorWithHex:colorHex]];
        } else {
            
            float height = 80.0;
            
            // create a new view for the background color
            UIView *backgroundColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            
            UIColor *bgColor = [UIColor colorWithHex:colorHex];
            
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), height);
            /*
            if ([bgColor isWhite]) {
                gradient.colors = [NSArray arrayWithObjects:(id)[bgColor CGColor], (id)[[bgColor darkerColor] CGColor], nil];
            } else {
                gradient.colors = [NSArray arrayWithObjects:(id)[[bgColor lighterColor] CGColor], (id)[bgColor CGColor], nil];
            }*/
            gradient.colors = [NSArray arrayWithObjects:(id)[[bgColor lighterColor] CGColor], (id)[bgColor CGColor], nil];
            [backgroundColorView.layer insertSublayer:gradient atIndex:0];
            
            // Add a bottomBorder.
            CALayer *bottomBorder = [CALayer layer];
            bottomBorder.frame = CGRectMake(0.0f, height - 1.0f, CGRectGetWidth(self.frame), 1.0f);
            bottomBorder.backgroundColor = [[bgColor darkerColor] CGColor];
            [self.layer addSublayer:bottomBorder];
            
            //[backgroundColorView setBackgroundColor:[UIColor colorWithHex:colorHex]];
            [self setBackgroundView:backgroundColorView];
            
        }
    }
}

- (void)appearanceForTitleColor:(NSString *)hexColor
{
    // default value
    if (!hexColor) {
        hexColor = @"333333";
    }
    
    if ([hexColor isEqualToString:@"clean"]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self.textLabel setTextColor:[UIColor colorWithHex:hexColor]];
    }
}

- (void)appearanceForSubtitleColor:(NSString *)hexColor
{
    // default value
    if (!hexColor) {
        hexColor = @"666666";
    }
    
    if ([hexColor isEqualToString:@"clean"]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self.detailTextLabel setTextColor:[UIColor colorWithHex:hexColor]];
    }
}

@end
