//
//  SMMainView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/24/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMMainView.h"
#import "UIColor+SSToolkitAdditions.h"
#import "UIImageView+AFNetworking.h"
#import "SMImageView.h"

@interface SMMainView()
- (void)appearanceForBackgroundHexColor:(NSString *)hexColor;
- (void)appearanceForBackgroundImageAppearance:(NSDictionary *)appearance;
@end

@implementation SMMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    }
    return self;
}

/**
 App wide appearances. Available options are
 * bg_color
 * bg_image
 */
- (void)applyAppearances:(NSDictionary *)appearances
{
    [self appearanceForBackgroundHexColor:[appearances objectForKey:@"bg_color"]];
    [self appearanceForBackgroundImageAppearance:[appearances objectForKey:@"bg_image"]];
}

#pragma mark - appearances

- (void)appearanceForBackgroundHexColor:(NSString *)hexColor
{
    // default value
    if (!hexColor) {
        hexColor = @"clean";
    }
    
    if ([hexColor isEqualToString:@"clean"]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self setBackgroundColor:[UIColor colorWithHex:hexColor]];
    }
}

- (void)appearanceForBackgroundImageAppearance:(NSDictionary *)appearance
{
    // default value
    if (!appearance) {
        return;
    }
    
    // validate if there is a url data
    NSString *imageUrl = [appearance objectForKey:@"url"];
    if (!imageUrl) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    
    // validate url
    if (!url) {
        return;
    }
    
    // place the background
    SMImageView *imageView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [imageView applyAppearances:appearance]; // apply appearance (alignment and bg_color)
    [imageView setImageWithURL:url];
    
    [self addSubview:imageView];
    [self sendSubviewToBack:imageView];
}

@end
