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

@end